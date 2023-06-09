import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:woostorestackflutter/pages/accountProfilePage.dart';
import 'package:woostorestackflutter/utils/Constants.dart';
import 'package:woostorestackflutter/utils/WalletConnectCridentials.dart';

import 'Models/ProductModel.dart';

class ContractFactoryServies extends ChangeNotifier {
  Constants constants = Constants();

  //SHARE DATA
  String? storeName;
  String? myAccount;
  bool storeNameLoading = true;
  bool storeProductsLoading = true;
  bool productCreatedLoading = false;

  String? myBalance;

  List<ProductModel> allProducts = [];
  List<ProductModel> categoryProducts = [];
  List<ProductModel> allUserProducts = [];

  //1-Connect to blockchain Network(https/websocktio/web3dart)

  Web3Client? _cleint;
  String? _abiCode;
  EthereumAddress? _contractAddress;
  DeployedContract? _contract;
  BigInt? _productCount;

  var uri;

  ContractFactoryServies() {
    _setUpNetwork();
  }

  fetchMyBalance(String accountAddress) async {
    EtherAmount balance =
        await _cleint!.getBalance(EthereumAddress.fromHex(accountAddress));
    String ConvertedValueToETH =
        balance.getValueInUnit(EtherUnit.ether).toString();

    myBalance = ConvertedValueToETH;
  }

  // Create a connector
  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: PeerMeta(
      name: 'Woo Store',
      description: 'Decentralized mobiel app with flutter',
      url: 'https://coodes.org',
      icons: ['https://coodes.org/wp-content/uploads/2020/07/ic.png'],
    ),
  );

  connectWallet() async {
    if (!connector.connected) {
      await connector.createSession(onDisplayUri: (_uri) async {
        uri = _uri;
        await launchUrlString(_uri, mode: LaunchMode.externalApplication);
      });

      try {} catch (e) {
        print("Error at connect to wallet ${e}");
      }
    }
  }

  //Create Product Event

  fetchProductCreatedEvent(context) async {
    _cleint!
        .events(FilterOptions.events(
            contract: _contract!, event: _contract!.event("CreatedProduct")))
        .take(1)
        .listen((event) {
      print("event of Create Product ${event}");
      if (event.transactionHash!.isNotEmpty) {
        productCreatedLoading = false;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AccountProfilePage(account: myAccount.toString())));
      }
    });
    notifyListeners();
  }

  saveAccountAddress(String account) {
    myAccount = account;
   notifyListeners();
  }

  _setUpNetwork() async {
    _cleint =
        Web3Client(constants.NETWORK_HTTPS_RPC, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(constants.NETWORK_WSS_RPC)
          .cast<String>();
    });
    await _fetchABIAndContractAdrress();
    await _getDeployedContract();
  }

  //2-Connect with Smart Contract
  //a-get abi and contract address
  Future<void> _fetchABIAndContractAdrress() async {
    String abiFileRoot =
        await rootBundle.loadString(constants.CONTRACT_ABI_PATH);
    var abiJsonFormat = jsonDecode(abiFileRoot);
    _abiCode = jsonEncode(abiJsonFormat["abi"]);

    //Get Address
    _contractAddress = EthereumAddress.fromHex(constants.CONTRACT_ADDRESS);
  }

  //b-taake this abi and address to get teh deployed contract

  Future<void> _getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "MarketplaceProducts"),
        _contractAddress!);
    await _getStoreName();
    await _getStoreProductCount();
    await _getAllProducts();
  }

  //3-Fetch All Functions and Data

//GET STORE NAME FROM BLOCKCHAIN
  _getStoreName() async {
    List<dynamic> storeData = await _cleint!.call(
        contract: _contract!,
        function: _contract!.function("storeName"),
        params: []);

    if (storeData[0].length > 0) {
      storeName = storeData[0];

      storeNameLoading = false;
    } else {
      storeNameLoading = true;
    }
    notifyListeners();
  }

//GET STORE PRODUCT COUT FROM BLOCKCHAIN
  _getStoreProductCount() async {
    List<dynamic> storeData = await _cleint!.call(
        contract: _contract!,
        function: _contract!.function("count"),
        params: []);

    _productCount = storeData[0];
    print("THE PRODUCT COUNT IS ${_productCount}");
    notifyListeners();
  }

  //GET ALL PRODUCTs DATA FROM BLOCKCHAIN
  _getAllProducts() async {
    try {
      int count = int.parse(_productCount.toString());
      allProducts.clear();
      for (int i = 1; i <= count; i++) {
        List<dynamic> product = await _cleint!.call(
            contract: _contract!,
            function: _contract!.function("storeProducts"),
            params: [BigInt.from(i)]);

        if(product[4] != true){
          allProducts.add(ProductModel(
              id: product[0],
              name: product[1],
              description: product[2],
              image: product[3],
              sold: product[4],
              owner: product[5],
              price: product[6],
              category: product[7]));
        }


      }
      storeProductsLoading = false;
    } catch (e) {
      storeProductsLoading = true;
    }

    notifyListeners();
  }

  //string  memory name,string memory description, string memory image,uint price, string  memory category

  //1-Create Web3 client connect with create product func
  //2-Create cridentials from conncetor provider
  //3-Test this function with Static data
  //4-Connect all use inputs with image at ipfs and sedn with wallet
  //5-work with Create product event and take action after this event
  addProduct(String name, String description, String image, String price,
      String category, String account, BuildContext context) async {
    EthereumWalletConnectProvider provider =
        EthereumWalletConnectProvider(connector);
    WalletConnectCridentials cridentials =
        WalletConnectCridentials(provider: provider);
    productCreatedLoading = true;
    if (name.length > 1 &&
        description.length > 9 &&
        image.length > 10 &&
        price.length > 0 &&
        category.length > 1) {
      await _cleint!.sendTransaction(
          cridentials,
          Transaction.callContract(
              from: EthereumAddress.fromHex(account),
              contract: _contract!,
              function: _contract!.function("createProduct"),
              parameters: [
                name,
                description,
                image,
                BigInt.from(int.parse(price)),
                category
              ]),
          chainId: constants.CHAIN_ID);
    } else {
      print("Error at Craete product ");
    }
    fetchProductCreatedEvent(context);

    notifyListeners();
  }
  //Buy Product Function

  buyProduct(BigInt id,String account,BigInt amount) async {
    EthereumWalletConnectProvider provider =
        EthereumWalletConnectProvider(connector);
    WalletConnectCridentials cridentials =
        WalletConnectCridentials(provider: provider);
    productCreatedLoading = true;
    if (id!=null ) {
      await _cleint!.sendTransaction(
          cridentials,
          Transaction.callContract(
              from: EthereumAddress.fromHex(account),
              contract: _contract!,
              function: _contract!.function("buyProduct"),
              value: EtherAmount.fromUnitAndValue(EtherUnit.wei, amount),
              parameters: [
                id,
              ]),
          chainId: constants.CHAIN_ID);
    } else {
      print("Error at Buy product ");
    }

    notifyListeners();
  }

  getUserProducts() async {
    try {
      int count = int.parse(_productCount.toString());
      allUserProducts.clear();
      for (int i = 1; i <= count; i++) {
        List<dynamic> product = await _cleint!.call(
            contract: _contract!,
            function: _contract!.function("storeProducts"),
            params: [BigInt.from(i)]);

        if(product[5].toString() == myAccount.toString()){
          allUserProducts.add(ProductModel(
              id: product[0],
              name: product[1],
              description: product[2],
              image: product[3],
              sold: product[4],
              owner: product[5],
              price: product[6],
              category: product[7]));
        }


      }
      storeProductsLoading = false;
    } catch (e) {
      storeProductsLoading = true;
    }

    notifyListeners();
  }

  //fetch category products

  getCategoryProducts(String categoryName) async {
    try {
      categoryProducts.clear();
      for (int i = 1; i <= allProducts.length; i++) {

        if(allProducts[i].category == categoryName){
          categoryProducts.add(ProductModel(
              id: allProducts[i].id,
              name: allProducts[i].name,
              description: allProducts[i].description,
              image: allProducts[i].image,
              sold: allProducts[i].sold,
              owner: allProducts[i].owner,
              price: allProducts[i].price,
              category: allProducts[i].category));
        }


      }
    } catch (e) {
      print("Error at getCategoryProducts ${e} ");
    }

    notifyListeners();
  }
}
