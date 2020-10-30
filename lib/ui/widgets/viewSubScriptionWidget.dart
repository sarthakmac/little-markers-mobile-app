import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/model/subscriptionModel.dart';
import 'package:turing_academy/ui/screens/course/timeline.dart';
import 'package:turing_academy/ui/screens/detailScreen.dart';
import 'package:turing_academy/ui/screens/subscription/courseContainScreen.dart';
import 'package:turing_academy/ui/screens/subscription/subProductDetails.dart';

class ViewSubScriptionWidget extends StatelessWidget {
  Subscriptions subscriptions;
  ViewSubScriptionWidget({this.subscriptions});

  Widget rowWidget(String title,subtitle){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(title,style: AppStyles.smallAccentTextStyle,),
            Expanded(child: Text(subtitle,textAlign: TextAlign.end,
              style: AppStyles.smallRedTextStyle,))

          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.fontGreyColor.withOpacity(.2))
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
//        Navigator.of(context).pushNamed(MyResult.routeName,arguments: subscriptions.id.toString());
      },
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight*.01,
            ),
            Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.screenWidth*.02,
                ),
                Container(
                  width: SizeConfig.screenWidth*.13,
                  height: SizeConfig.screenHeight*.08,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(SizeConfig.screenWidth*.02),
                      border: Border.all(
                          color: AppColors.fontGreyColor,
                          width: 1
                      ),
                      image: DecorationImage(image: AssetImage(AssetsStrings.appIcon),
                      fit: BoxFit.cover)
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth*.02,
                ),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: '${AppString.orderId} ',
                              style: AppStyles.smallAccrentTextStyle,
                              children: <TextSpan>[
                                TextSpan(text: '${subscriptions.order.id}', style: AppStyles.smallRedTextStyle),
                              ],
                            ),
                          ),
                        ),
//                        OutlineButton(
//                            child: new Text(AppString.courseActivities),
//                            onPressed: (){
//                              Navigator.of(context).pushNamed(MyResult.routeName,arguments: subscriptions.id.toString());
//                            },
//                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
//                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth*.01,
                        ),

                        
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: getTile(subscriptions.product.subProducts,context),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Expanded(
                          child: OutlineButton(
                              child: new Text(AppString.courseContent,style: AppStyles.mediumBlackTextStyle),
                              onPressed: (){
                                Navigator.of(context).pushNamed(CourseContainScreen.routeName,arguments: subscriptions);
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                          ),
                        ),
                        Expanded(
                          child: OutlineButton(
                              child: new Text(AppString.courseActivities,style: AppStyles.mediumBlackTextStyle,),
                              onPressed: (){
                                Navigator.of(context).pushNamed(MyResult.routeName,arguments: subscriptions.id.toString());
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),

            SizedBox(
              height: SizeConfig.screenHeight*.01,
            ),
            rowWidget(AppString.startDate,'${AppConstant.changeDateformate(subscriptions.subscriptionStartDate)}'),
            rowWidget(AppString.endDate,'${AppConstant.changeDateformate(subscriptions.subscriptionEndDate)}'),
            rowWidget(AppString.price,'\u20B9 ${subscriptions.order.grandTotal}'),
          ],
        ),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth*.03),
            boxShadow: [BoxShadow(
              color: Colors.black12.withOpacity(.2),
              blurRadius: 5.0,
            ),]
        ),
      ),
    );
  }

  List<TextSpan> getTile(List<SubProducts> subProducts,BuildContext context){
    List<TextSpan> arrayOfTextSpan = [];
    for (int index = 0; index < subProducts.length; index++){
      final text = subProducts[index].name + ", ";
      final span = TextSpan(
          text: text,
          style: TextStyle(color: AppColors.blackBackgroundColor,fontWeight: FontWeight.w700),
          recognizer: TapGestureRecognizer()..onTap = () {
            print('object');
            Navigator.of(context).pushNamed(SubProductDetailScreen.routeName,arguments: subProducts[index]);
          }
      );
      arrayOfTextSpan.add(span);
    }
    return arrayOfTextSpan;
  }
}
