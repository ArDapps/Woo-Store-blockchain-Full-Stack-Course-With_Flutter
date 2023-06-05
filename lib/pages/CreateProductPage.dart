import 'package:flutter/material.dart';
import 'package:woostorestackflutter/widgets/CustomButtonWIdget.dart';
import 'package:woostorestackflutter/widgets/CustomTextFieldWidgets.dart';

import '../utils/Constants.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {

  Constants constants = Constants();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String dropMenuValue = "Games";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: constants.mainBGColor,
      appBar: AppBar(
        title: Text("Upload Product To Bloackchain"),
        backgroundColor: constants.mainYellowColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "Create Product and Add It to The Blockchain Network",
                style: TextStyle(
                    color: constants.mainBlackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  customTextFieldWidget(1, "Product Name", nameController),
                  customTextFieldWidget(1, "Product Price", priceController),
                  customTextFieldWidget(4, "Product Description", descriptionController),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "Select Category",
                    style: TextStyle(
                      color: constants.mainBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: DropdownButton <String>(
                      value: dropMenuValue,
                        items: constants.categoryList.map<DropdownMenuItem<String>>(( String value){
                      return DropdownMenuItem<String>(
                        value: value,
                          child: Text(value));
                    }).toList(),
                        onChanged: ( String? value){
                        setState(() {
                          dropMenuValue = value!;
                        });
                    }),
                  )
                ],
              ),

            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    customButtonWidget((){}, 1, constants.mainRedColor, "Select Image To Added to IPFS", constants.mainWhiteGColor,300),
                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: customButtonWidget((){}, 10, constants.mainBlackColor, "Create Product", constants.mainWhiteGColor,150),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
