import 'package:flutter/material.dart';
import 'package:woostorestackflutter/widgets/CustomButtonWIdget.dart';
import 'package:woostorestackflutter/widgets/CustomProductCardWidget.dart';
import 'package:woostorestackflutter/widgets/CustomTextFieldWidgets.dart';
import 'package:woostorestackflutter/widgets/HeadingCoverWidget.dart';

import '../utils/Constants.dart';

class DiscoveryPage extends StatelessWidget {
   DiscoveryPage({Key? key}) : super(key: key);
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headingCoverWidget(context),
              Text("Home sPage"),
              customButtonWidget((){},3,constants.mainBlackColor,"Buy NOW",constants.mainWhiteGColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customButtonWidget((){},25,constants.mainYellowColor,"Connect Wallet",constants.mainBlackColor),
              ),
              customTextFieldWidget(1,"Product Name",TextEditingController()),
              customTextFieldWidget(3,"Product Description",TextEditingController()),

              customProductCardWidget(constants.imageMoke,"Gift Card Product","0.8"),


            ],
          ),
        ),
      ),
    );
  }
}
