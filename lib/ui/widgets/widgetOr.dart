import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';

class AppOrWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * .35,
          height: 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              AppColors.accentColor.withOpacity(.1),
              AppColors.accentColor.withOpacity(.3),
              AppColors.accentColor.withOpacity(.4),
              AppColors.accentColor.withOpacity(.7),
            ],
            stops: [0.1, 0.5, 0.7, 0.9],
          )),
        ),
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * .04,
          child: Center(
            child: Text(
              "OR",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .03,
                  color: Colors.white),
            ),
          ),
          backgroundColor: AppColors.accentColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .35,
          height: 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              AppColors.accentColor.withOpacity(.7),
              AppColors.accentColor.withOpacity(.4),
              AppColors.accentColor.withOpacity(.3),
              AppColors.accentColor.withOpacity(.1),
            ],
            stops: [0.1, 0.5, 0.7, 0.9],
          )),
        ),
      ],
    );
  }
}

class MyCardListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * .30,
          height: 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(.1),
              Colors.grey.withOpacity(.3),
              Colors.grey.withOpacity(.4),
              Colors.grey.withOpacity(.7),
            ],
            stops: [0.1, 0.5, 0.7, 0.9],
          )),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "My Card List",
              style: AppStyles.smallerPaymentBoldTextStyle,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * .03),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .30,
          height: 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(.7),
              Colors.grey.withOpacity(.4),
              Colors.grey.withOpacity(.3),
              Colors.grey.withOpacity(.1),
            ],
            stops: [0.1, 0.5, 0.7, 0.9],
          )),
        ),
      ],
    );
  }
}
