import 'package:flutter/cupertino.dart';
import 'package:woostorestackflutter/widgets/CustomButtonWIdget.dart';

import '../utils/Constants.dart';

Widget headingCoverWidget (context){
  Constants constants = Constants();

  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.40,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/cover.png"),
            fit: BoxFit.cover,
            scale: 1
          )
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.50,

                child: Text("Discovery Web3 Products",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
          ),
          customButtonWidget((){}, 25, constants.mainYBGColor, "Connect Wallet", constants.mainBlackColor),
        ],
      )
    ],
  );
}