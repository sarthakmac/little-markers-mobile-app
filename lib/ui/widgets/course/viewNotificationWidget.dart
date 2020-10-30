import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/notification.dart';
import 'package:turing_academy/core/services/notificationApi.dart';
import 'package:turing_academy/core/viewModel/notifcationViewModel.dart';
class ViewNotificationWidget extends StatelessWidget {
  Notifications notifications;
  ViewNotificationWidget({this.notifications});
  @override
  Widget build(BuildContext context) {
    final model=Provider.of<NotificationViewModel>(context);
    return InkWell(
      onTap: (){


      },
      child: Container(
        child: Padding(
          padding:  EdgeInsets.all(SizeConfig.screenHeight*.015),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              SizedBox(
                width: SizeConfig.screenWidth*.2,
                height: SizeConfig.screenHeight*.08,
                child: Image.asset(AssetsStrings.notificationIcon),
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${notifications.title}',style: notifications.readStatus=="unread"?AppStyles.unReadTitleTextStyle:
                  AppStyles.readtitleTextStyle,),
                  Text('${notifications.body}',style: AppStyles.smallerGrayTextStyle,),
                  Text('${AppConstant.changeDateformate(notifications.createdAt)}',style: AppStyles.smallerRedTextStyle,),
                ],
              )),
              Text('${notifications.addedAt}',style: AppStyles.smallerRedTextStyle,),

            ],
          ),
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
}
