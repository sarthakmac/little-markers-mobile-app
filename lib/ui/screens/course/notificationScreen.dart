import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/notification.dart';
import 'package:turing_academy/core/viewModel/baseView.dart';
import 'package:turing_academy/core/viewModel/notifcationViewModel.dart';
import 'package:turing_academy/ui/widgets/course/viewNotificationWidget.dart';
import 'package:turing_academy/ui/widgets/courseAppBar.dart';

class NotificationScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  NotificationScreen({this.scaffoldkey});
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  ScrollController _scrollController;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink => _scrollController.hasClients && _scrollController.offset > 5;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding=SizeConfig.screenWidth*.03;
    return BaseView<NotificationViewModel>(
      onModelReady: (model)=>model.getNotificationList(),
      builder: (context,model,child){
        return Column(
          children: <Widget>[
            CourseAppBar(isShrink: isShrink,title: AppString.notification,
              scaffoldkey: widget.scaffoldkey,),
            SizedBox(height: SizeConfig.screenHeight*.01,),
            model.notifications.length>0?Padding(
              padding:  EdgeInsets.only(
                  left: sidePadding,right: sidePadding
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                      child: new Text(AppString.markAllasRead),
                      onPressed: (){
                        if(model.notifications.length>0){
                          model.markallasReadnotification().then((value){
                            model.getNotificationList();
                            AppConstant.showSuccessToast(context, value.msg);
                          });
                        }


                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                  ),
                  OutlineButton(
                      child: new Text(AppString.clearNotification),
                      onPressed: (){
                        if(model.notifications.length>0){
                          model.clearnotification().then((value){
                            model.getNotificationList();
                            AppConstant.showSuccessToast(context, value.msg);
                          });
                        }


                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                  ),
                ],
              ),
            ):Container(),
            model.state==ViewState.BUSY?Expanded(child: AppConstant.circularInidcator()):Expanded(child:
            Padding(
              padding:  EdgeInsets.only(
                  left: sidePadding,
                  right: sidePadding
              ),
              child: viewNotification(model.notifications),
            )),
            SizedBox(height: SizeConfig.screenHeight*.1,),

          ],
        );
      },
    );
  }

  Widget viewNotification(List<Notifications> _notifications){
    if(_notifications.length==0){
      return Center(child: Text('No new notification',style: AppStyles.largeBlackTextStyle,));
    }
    return ListView.builder(padding: EdgeInsets.all(0),itemCount: _notifications.length,itemBuilder: (BuildContext context,int index){
      return Padding(
        padding:  EdgeInsets.only(
            bottom: SizeConfig.screenHeight*.01
        ),
        child: ViewNotificationWidget(
          notifications: _notifications[index],
        ),
      );
    });
  }
}
