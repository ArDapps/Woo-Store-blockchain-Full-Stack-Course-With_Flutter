
import 'package:flutter/material.dart';

import '../utils/Constants.dart';

Widget customLoaderWidget (){
  Constants constants = Constants();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: constants.mainYellowColor,
          borderRadius: BorderRadius.circular(25)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: constants.mainBlackColor,
                borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: constants.mainWhiteGColor,

            ),
          ),
        ),
      ),
    ),
  );

}