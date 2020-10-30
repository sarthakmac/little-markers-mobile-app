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
import 'package:turing_academy/ui/screens/detailScreen.dart';

class ViewHistoryWidget extends StatelessWidget {
  Order order;

  ViewHistoryWidget({this.order});

  Widget rowWidget(String title, subtitle) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(title, style: AppStyles.smallAccentTextStyle,),
            Expanded(child: Text(subtitle, textAlign: TextAlign.end,
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
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight * .01,
          ),
          Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: SizeConfig.screenWidth * .02,
              ),
              Container(
                width: SizeConfig.screenWidth * .13,
                height: SizeConfig.screenHeight * .08,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(
                        SizeConfig.screenWidth * .02),
                    border: Border.all(
                        color: AppColors.fontGreyColor,
                        width: 1
                    ),
                    image: DecorationImage(
                        image: AssetImage(AssetsStrings.appIcon),fit: BoxFit.cover)
                ),
              ),
              SizedBox(
                width: SizeConfig.screenWidth * .02,
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: getTile(order.orderItems,context),
                    ),
                  ),
//                  Text('${getTile(order.orderItems)}', style: AppStyles.headingTextStyle,),
                  RichText(
                    text: TextSpan(
                      text: '${AppString.orderId} ',
                      style: AppStyles.smallAccrentTextStyle,
                      children: <TextSpan>[
                        TextSpan(text: '${order.id}',
                            style: AppStyles.smallRedTextStyle),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .01,
          ),
//          rowWidget(AppString.startDate,'${AppConstant.changeDateformate(order.dateTime)}'),
//          rowWidget(AppString.endDate,'${AppConstant.changeDateformate(order.createdAt)}'),
          rowWidget(AppString.price, '\u20B9 ${order.grandTotal}'),
        ],
      ),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * .03),
          boxShadow: [BoxShadow(
            color: Colors.black12.withOpacity(.2),
            blurRadius: 5.0,
          ),
          ]
      ),
    );
  }

  List<TextSpan> getTile(List<OrderItems> orderItems,BuildContext context){
    List<TextSpan> arrayOfTextSpan = [];
    for (int index = 0; index < orderItems.length; index++){

      String text;
      if(index==orderItems.length-1){
         text = orderItems[index].product.name;
      }else{
         text = orderItems[index].product.name + ", ";
      }

      final span = TextSpan(
          text: text,
          style: TextStyle(color: AppColors.blackBackgroundColor,fontWeight: FontWeight.w700),
          recognizer: TapGestureRecognizer()..onTap = () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailScreen(
                    product:orderItems[index].product)));
          }
      );
      arrayOfTextSpan.add(span);
    }
    return arrayOfTextSpan;
}
}