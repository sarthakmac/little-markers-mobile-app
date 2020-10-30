import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/sizeConfig.dart';

class AppBotton extends StatelessWidget {
  double width, height;
  Function onTap;
  String title;
  double borderRadius;
  Color color;
  Widget iconWidget;
  AppBotton(
      {this.width,
      this.height,
      this.onTap,
      this.title,
      this.borderRadius,
      this.color,
      this.iconWidget});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        child: iconWidget != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  iconWidget,
                  SizedBox(
                    width: SizeConfig.screenWidth * .02,
                  ),
                  Text(title,
                      style: TextStyle(
                          fontSize: AppConstant.fontSizeSmall,
                          color: Colors.white))
                ],
              )
            : Center(
                child: Text(title,
                    style: TextStyle(
                        fontSize: AppConstant.fontSizeSmall,
                        color: Colors.white)),
              ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius != null
                ? borderRadius
                : MediaQuery.of(context).size.height * 0.03),
            color: color != null ? color : AppColors.redBottonColor),
      ),
      onTap: onTap,
    );
  }
}

class SmallAPpButton extends StatelessWidget {
  double width, height;
  Function onTap;
  String title;
  double borderRadius;
  Color color;
  Widget iconWidget;
  double fontSIze;
  SmallAPpButton(
      {this.width,
      this.height,
      this.onTap,
      this.title,
      this.borderRadius,
      this.color,
      this.fontSIze,
      this.iconWidget});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        child: iconWidget != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  iconWidget,
                  SizedBox(
                    width: SizeConfig.screenWidth * .02,
                  ),
                  Text(title,
                      style: TextStyle(fontSize: fontSIze, color: Colors.white))
                ],
              )
            : Center(
                child: Text(title,
                    style: TextStyle(fontSize: fontSIze, color: Colors.white)),
              ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius != null
                ? borderRadius
                : MediaQuery.of(context).size.height * 0.03),
            color: color != null ? color : AppColors.redBottonColor),
      ),
      onTap: onTap,
    );
  }
}

class AppCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.accentColor,
      ),
    );
  }
}
