import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/Constants.dart';

Widget customTextFieldWidget(int maxLines,String hintText,TextEditingController controller){
  Constants constants = Constants();

  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: TextField(
      style: TextStyle(color: constants.mainYBGColor),
      cursorColor: constants.mainYBGColor,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: constants.mainYellowColor,filled: true,
        hintText: hintText,hintStyle: TextStyle(color: constants.mainYBGColor)
      ),

    ),
  );
}