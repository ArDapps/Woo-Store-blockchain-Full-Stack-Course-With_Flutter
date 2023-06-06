import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:woostorestackflutter/utils/Constants.dart';

import 'Models/ProductModel.dart';

class ContractFactoryServies extends ChangeNotifier{

  Constants constants = Constants();

  //SHARE DATA
  String? storeName;
  bool storeNameLoading = true;
  bool storeProductsLoading = true;

  List<ProductModel> allProducts = [];

  //1-Connect to blockchain Network(https/websocktio/web3dart)

  Web3Client? _cleint;
  String? _abiCode;
  EthereumAddress? _contractAddress;
  DeployedContract ? _contract;
  BigInt? _productCount;

  ContractFactoryServies(){
    _setUpNetwork();
  }
  _setUpNetwork() async{

    _cleint =  Web3Client(constants.NETWORK_HTTPS_RPC, Client(),socketConnector: (){
      return IOWebSocketChannel.connect(constants.NETWORK_WSS_RPC).cast<String>();
    });
   await _fetchABIAndContractAdrress();
   await _getDeployedContract();
  }
  //2-Connect with Smart Contract
    //a-get abi and contract address
    Future <void>_fetchABIAndContractAdrress () async{
    String abiFileRoot = await rootBundle.loadString(constants.CONTRACT_ABI_PATH);
    var abiJsonFormat = jsonDecode(abiFileRoot);
     _abiCode = jsonEncode(abiJsonFormat["abi"]);


    //Get Address
    _contractAddress = EthereumAddress.fromHex(constants.CONTRACT_ADDRESS);

    }

    //b-taake this abi and address to get teh deployed contract

Future<void> _getDeployedContract()async{
    _contract =DeployedContract(ContractAbi.fromJson(_abiCode!, "MarketplaceProducts"), _contractAddress!);
    await _getStoreName();
    await _getStoreProductCount();
    await _getAllProducts();
}

  //3-Fetch All Functions and Data

//GET STORE NAME FROM BLOCKCHAIN
_getStoreName () async{
   List<dynamic> storeData = await _cleint!.call(contract: _contract!, function: _contract!.function("storeName"), params: []);

   if(storeData[0].length > 0){

     storeName = storeData[0];

     storeNameLoading =false;
   }else{
     storeNameLoading =true;
   }
   notifyListeners();
}

//GET STORE PRODUCT COUT FROM BLOCKCHAIN
  _getStoreProductCount () async{
    List<dynamic> storeData = await _cleint!.call(contract: _contract!, function: _contract!.function("count"), params: []);

    _productCount = storeData[0];
    print("THE PRODUCT COUNT IS ${_productCount}");
    notifyListeners();
  }


  //GET ALL PRODUCTs DATA FROM BLOCKCHAIN
  _getAllProducts () async{

    try{
      int count = int.parse(_productCount.toString());
      allProducts.clear();
      for(int i = 1;i<=count ;i++){
        List<dynamic> product = await _cleint!.call(contract: _contract!, function: _contract!.function("storeProducts"), params: [BigInt.from(i)]);


        allProducts.add(ProductModel(id: product[0], name: product[1], description: product[2], image: product[3], sold: product[4], owner: product[5], price: product[6], category: product[7]));

      }
      storeProductsLoading =false;
    }catch(e){
      storeProductsLoading =true;
    }




    notifyListeners();
  }

}