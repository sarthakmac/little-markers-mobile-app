import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/textReport.dart';

class ReviewWidget extends StatelessWidget {
  TextReport textReport;
  ReviewWidget({this.textReport});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight * 0.18,
      width: SizeConfig.screenWidth * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: SizeConfig.screenHeight * 0.11,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        child: Container(
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.13,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: textReport.image!=null?NetworkImage(AppUrl.storageAddress+textReport.image):AssetImage("assets/user.png"))),
                        ),
                        backgroundColor: Colors.blueGrey[100],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 2,
                    left: 2,
                    child: Container(
                      width: SizeConfig.screenWidth * 0.2,
                      height: SizeConfig.screenHeight * 0.03,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: AppColors.whiteColor,
                            size: 10,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            textReport.ratings,
                            style: AppStyles.smallerWhiteTextStyle,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: AppColors.brownColor),
                    ))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${textReport.title}",
                  style: AppStyles.normalheadingTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${textReport.description}",
                  style: AppStyles.smallerGrayTextStyle,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${AppConstant.changeDateformate(textReport.createdAt)}",
                  style: AppStyles.smallerRedTextStyle,
                )
              ],
            ))
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * .03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(.2),
              blurRadius: 5.0,
            ),
          ]),
    );
  }
}
