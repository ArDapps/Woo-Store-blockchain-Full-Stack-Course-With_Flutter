import 'package:web3dart/credentials.dart';

class ProductModel {
  late BigInt id;
  late String name;
  late String description;
  late String image;
 late bool sold;
  late EthereumAddress owner;
  late BigInt price;
  late String category;

  ProductModel({
    required this.id,required this.name,required this.description,required this.image,required this.sold,required this.owner,required this.price,required this.category,
});
}