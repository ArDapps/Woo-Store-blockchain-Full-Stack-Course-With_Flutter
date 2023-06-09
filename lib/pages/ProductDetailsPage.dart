import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:woostorestackflutter/services/Models/ProductModel.dart';
import 'package:woostorestackflutter/utils/Constants.dart';
import 'package:woostorestackflutter/widgets/CustomButtonWIdget.dart';

import '../services/ContractFactoryServies.dart';

class ProductDetailsPage extends StatelessWidget {

  ProductModel product;

  ProductDetailsPage({required this.product,Key? key}) : super(key: key);
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    var contractFactory = Provider.of<ContractFactoryServies>(context);

    var convertedPrice = (int.parse(product.price.toString()) / 1000000000000000000).toString();
    // var cutPrice = convertedPrice.toString().substring(0,6);

    return Scaffold(
      backgroundColor: constants.mainBGColor,
      appBar: AppBar(
        backgroundColor: constants.mainBGColor,
        elevation: 0,
        title: Text(
          product.name,
          style: TextStyle(color: constants.mainYellowColor),
        ),
        iconTheme: IconThemeData(color: constants.mainYellowColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                      scale: 1)),
            ),
            Container(
              color: constants.mainBlackColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.gamepad_rounded,
                              color: constants.mainYellowColor,
                              size: 40,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              Text(
                                "Category",
                                style:
                                    TextStyle(color: constants.mainYellowColor),
                              ),
                              Text(
                                product.category,
                                style:
                                    TextStyle(color: constants.mainWhiteGColor,fontSize: 20),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        print("WILL OPEN ETHERSCAN");
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.link,
                            color: constants.mainYellowColor,
                            size: 40,
                          ),
                          Text("Explore",style:
                          TextStyle(color: constants.mainYellowColor,fontSize: 15),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:25.0,left: 8,bottom: 8),
              child: Text(
                "Description",
                style: TextStyle(color: constants.mainBlackColor,fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0,left: 18),
              child: Text(
                product.description,
                style: TextStyle(color: constants.mainBlackColor,fontWeight: FontWeight.normal,fontSize: 15),textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                color: constants.mainWhiteGColor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          RandomAvatar(product.owner.toString(),height: 50,width: 50)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Seller",
                              style:
                              TextStyle(color: constants.mainBlackColor),
                            ),
                            Text(
                              product.owner.toString(),
                              style:
                              TextStyle(color: constants.mainGrayColor,fontSize: 10),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                convertedPrice.length > 3?Text(" ETH ${convertedPrice.substring(0,5)} ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: constants.mainBlackColor),):Text(" ETH ${convertedPrice} ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: constants.mainBlackColor),),
                product.owner.toString()!= contractFactory.myAccount?customButtonWidget(() async{

                   contractFactory.buyProduct(product.id,contractFactory.myAccount.toString(),product.price)
                  ;}, 15, constants.mainBlackColor, "BUY NOW", constants.mainWhiteGColor, 150):Text("Can not Buy Yours",style: TextStyle(fontSize: 10,color: constants.mainRedColor),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
