import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';

class CreditCardWidget extends StatelessWidget {
  final int index;

  const CreditCardWidget({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.65,
      height: SizeConfig.screenHeight * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index % 2 == 0
              ? AppColors.accentColor.withOpacity(0.9)
              : AppColors.redBottonColor.withOpacity(0.9)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Holder Name",
              style: AppStyles.smallerWhiteLightTextStyle,
            ),
            Text(
              "Dhey Rathod",
              style: AppStyles.mediumWhiteTextStyle,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "9781 - XXXX - XXXX - XXXX",
              style: AppStyles.mediumWhiteLightTextStyle,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Exp. Date",
                      style: AppStyles.smallerWhiteLightTextStyle,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "11/12",
                      style: AppStyles.mediumWhiteTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "CCV",
                      style: AppStyles.smallerWhiteLightTextStyle,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "***",
                      style: AppStyles.mediumWhiteTextStyle,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
