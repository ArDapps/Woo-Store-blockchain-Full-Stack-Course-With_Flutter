import 'package:flutter/material.dart';
import 'package:woostorestackflutter/pages/ProductDetailsPage.dart';
import 'package:woostorestackflutter/services/Models/ProductModel.dart';
import 'package:woostorestackflutter/utils/Constants.dart';

Widget customProductCardWidget (context,String imageUrl,String productName,String price,ProductModel product){
  var convertedPrice = int.parse(price) / 1000000000000000000;
Constants constants = Constants();
  return Padding(
    padding:  EdgeInsets.all(6.0),
    child: Container(
      decoration: BoxDecoration(
        color: constants.mainBGColor,
            borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage(product:product ,)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:DecorationImage(
                  image: NetworkImage(imageUrl),fit: BoxFit.cover,

                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,left: 8),
              child: Text(productName,style: TextStyle(fontSize: 20,color: constants.mainBlackColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(top:1.0,left: 8,bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.monetization_on_outlined,color: constants.mainYellowColor),
                  convertedPrice.toString().length > 3 ?Text(convertedPrice.toString().substring(0,3)  +" ETH",style: TextStyle(fontSize: 15,color: constants.mainBlackColor),):Text(convertedPrice.toString()+" ETH",style: TextStyle(fontSize: 15,color: constants.mainBlackColor),)
                ],
              ),
            )

          ],
        ),
      ),

    ),
  );
}