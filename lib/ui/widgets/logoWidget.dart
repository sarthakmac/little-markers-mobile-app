import 'package:flutter/material.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 140,
        height: SizeConfig.screenHeight*.3,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(
              AssetsStrings.logo,
            ),fit: BoxFit.cover)
        )
    );
  }
}
