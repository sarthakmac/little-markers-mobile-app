
import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appConstants.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    AppConstant.fontSizeVerySmaller = screenHeight*.01;
    AppConstant.fontSizeVerySmall = screenHeight*.012;
    AppConstant.fontSizeSmaller=screenHeight*.015;
    AppConstant.fontSizeSmall = screenHeight*.021;
    AppConstant.fontSizeMedium = screenHeight*.025;
    AppConstant.fontSizeLarge = screenHeight*.035;
    AppConstant.iconSizeMedium=screenHeight*.018; //IconThemeData.fallback().size
    AppConstant.iconSizeSmall=screenHeight*.015;
    AppConstant.iconSizeLarge=screenHeight*.023;
    AppConstant.fontSizeNumberPopUpSmall = screenHeight*.015;
  }

  static EdgeInsets sidePadding=EdgeInsets.only(left: 10,right: 10);
  static EdgeInsets verticalPadding=EdgeInsets.only(bottom: 20,top: 20);
  static Widget verticalSmallSpace(){
    return SizedBox(height: 20,);
  }
}