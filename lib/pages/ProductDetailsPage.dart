import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:woostorestackflutter/utils/Constants.dart';
import 'package:woostorestackflutter/widgets/CustomButtonWIdget.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({Key? key}) : super(key: key);
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.mainBGColor,
      appBar: AppBar(
        backgroundColor: constants.mainBGColor,
        elevation: 0,
        title: Text(
          "Product Details",
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
                      image: AssetImage("images/splach.png"),
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
                                "Games",
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
                constants.mokeParagraph,
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
                          RandomAvatar("0x9135AFACE007e45b8875B50E6bE9ec0EE501C073",height: 60,width: 60)
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
                              "0x9135AFACE007e45b8875B50E6bE9ec0EE501C073",
                              style:
                              TextStyle(color: constants.mainGrayColor,fontSize: 12),
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
                Text(" ETH 0.5 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: constants.mainBlackColor),),
                customButtonWidget((){print("BUY MOW");}, 15, constants.mainBlackColor, "BUY NOW", constants.mainWhiteGColor, 150)
              ],
            )
          ],
        ),
      ),
    );
  }
}
