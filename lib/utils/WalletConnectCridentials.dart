
import 'dart:typed_data';

import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/src/crypto/secp256k1.dart';
import 'package:web3dart/web3dart.dart';

class WalletConnectCridentials extends CustomTransactionSender {


  @override
  // TODO: implement address
  EthereumAddress get address => throw UnimplementedError();
  EthereumWalletConnectProvider provider;

  WalletConnectCridentials({required this.provider});

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async{
    final hash = await provider.sendTransaction(from: transaction.from!.hex,to: transaction.to?.hex,data: transaction.data,gas: transaction.maxGas,gasPrice: transaction.gasPrice?.getInWei,value: transaction.value?.getInWei,nonce: transaction.nonce);

    return hash;
  }

  @override
  MsgSignature signToEcSignature(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToEcSignature
    throw UnimplementedError();
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }

}