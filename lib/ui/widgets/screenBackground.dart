import 'package:flutter/material.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';

class ScreenBackGround extends StatelessWidget {
  Widget child;
  ScreenBackGround({this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: SizeConfig.screenHeight*.3,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsStrings.topBacground),fit: BoxFit.cover)
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: SizeConfig.screenHeight*.47,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsStrings.bottomBacground),fit: BoxFit.cover)
              ),
            ),
          ),
        ),
        child
      ],
    );
  }
}
