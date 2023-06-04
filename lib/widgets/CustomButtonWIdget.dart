import 'package:flutter/material.dart';
import 'package:woostorestackflutter/utils/Constants.dart';

Widget customButtonWidget (Function onPress,double borderSize,Color bgColor,String buttonTitle,Color buttonTextColor){
  return InkWell(
    onTap: ()=>onPress(),
    child: Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderSize),
        color: bgColor

      ),
      child: Center(child: Text(buttonTitle,style: TextStyle(color: buttonTextColor,fontWeight: FontWeight.bold),)),
    ),
  );
}