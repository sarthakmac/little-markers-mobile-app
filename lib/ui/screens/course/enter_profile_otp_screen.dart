import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/otpCredential.dart';
import 'package:turing_academy/core/model/SendApi/profile_otp_credential.dart';
import 'package:turing_academy/core/model/SendApi/updateProfileCredential.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/services/pushNotification.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/logoWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class EnterProfileOtpArguments{
  String phoneNumber;
  String firstName;
  String lastName;
  EnterProfileOtpArguments({this.phoneNumber,this.lastName,this.firstName});
}

class EnterProfileOtpScreen extends StatefulWidget {
  static const String routeName = '/enterProfileOtpScreen';
  final EnterProfileOtpArguments arguments;
  EnterProfileOtpScreen({this.arguments});

  @override
  _EnterProfileOtpScreenState createState() => _EnterProfileOtpScreenState();
}

class _EnterProfileOtpScreenState extends State<EnterProfileOtpScreen> with CodeAutoFill{

  ScrollController _scrollController;
  bool get isShrink =>
      _scrollController.hasClients && _scrollController.offset > 5;
  final sidePadding = SizeConfig.screenWidth * .1;
  int _start = 60;

  TextEditingController codetronller=TextEditingController();

  String currentText;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  String signature;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    SmsAutoFill().listenForCode;
    SmsAutoFill().getAppSignature.then((value)
    {
      print('object$value');
      setState(() {
        signature=value;
      });

    });
  }
  @override
  void codeUpdated() {

    print('###############$code');
    setState(() {
      currentText=code;
    });
    print(code);
    // TODO: implement codeUpdated
  }


  @override
  Widget build(BuildContext context) {
    final model=Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
//      pinned: true,
        elevation: !isShrink ? 0.0 : 2.0,
        backgroundColor: !isShrink ? Colors.transparent : Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: AppColors.yellowColor,
            child: Image.asset(
              AssetsStrings.backArrow,
              width: 20,
            ),
            padding: EdgeInsets.all(3),
            shape: CircleBorder(),
          ),
        ),
        title: Text(
          AppString.enterOtp, // + _scrollController.offset.toString(),
          style: AppStyles.headingTextStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[


              SizedBox(
                height: SizeConfig.screenHeight * .2,
              ),


              Padding(
                padding:
                EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppString.enterOtp,
                      style: TextStyle(
                          color: AppColors.redBottonColor,
                          fontSize: AppConstant.fontSizeVerySmall),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: PinFieldAutoFill(
                  codeLength: 6,
//                    decoration: UnderlineDecoration(
//                      colorBuilder: ColorBuilder(),
//                        textStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  currentCode: currentText,
                  onCodeChanged: (value){
                    currentText=value;
                  },
                  onCodeSubmitted: (v)async{
                    model.profileVerifyOtp(ProfileOtpCredential(
                      userID: loggedInUser.id.toString(),
                        phone: widget.arguments.phoneNumber,
                        otp: v,
                    )).then((value)async{
                      if(value.statuscode==1){
                        if(value.statuscode==1){
                          final UpdateProfileCredential updateProfileCredential = new UpdateProfileCredential(
                              firstname: widget.arguments.firstName,
                              lastname: widget.arguments.lastName,
                              phone:widget.arguments.phoneNumber,

                      );
                      ResponseMessage responseMessage = await Provider.of<UserViewModel>(context, listen: false)
                          .updateProfile(updateProfileCredential);
                      if (responseMessage.statuscode==1) {

                      AppConstant.showSuccessToast(context, responseMessage.msg);
                      Navigator.pop(context,true);

                      }
                      }else{
                      AppConstant.showFailToast(context, value.msg);
                      }
                      }else{
                        AppConstant.showFailToast(context, value.msg);
                      }
                    });

                  },

                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * .01,
              ),
              model.state==ViewState.BUSY?AppConstant.circularInidcator():Padding(
                  padding:
                  EdgeInsets.only(left: sidePadding, right: sidePadding),
                  child:AppBotton(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.06,
                    title: AppString.submit,
                    onTap: () async{
                      int currentIndex= await Prefs.getCurrentIndex();
                      if(currentText.length>5){
                        model.profileVerifyOtp(ProfileOtpCredential(
                          phone: widget.arguments.phoneNumber,
                          userID: loggedInUser.id.toString(),
                          otp: currentText,
                        )).then((value)async{
                          if(value.statuscode==1){
                            final UpdateProfileCredential updateProfileCredential = new UpdateProfileCredential(
                                firstname: widget.arguments.firstName,
                                lastname: widget.arguments.lastName,
                                phone:widget.arguments.phoneNumber,
                                fcmToken: await PushNotificationsManager().getToken()
                          );
                          ResponseMessage responseMessage = await Provider.of<UserViewModel>(context, listen: false)
                              .updateProfile(updateProfileCredential);
                          if (responseMessage.statuscode==1) {

                            AppConstant.showSuccessToast(context, responseMessage.msg);
                            Navigator.pop(context,true);

                          }
                          }else{
                            AppConstant.showFailToast(context, value.msg);
                          }
                        });



                      }else{
                        AppConstant.showFailToast(context, 'Please enter verify code');
                      }


                    },
                  )
//                      : AppBotton(
//                          width: SizeConfig.screenWidth,
//                          height: SizeConfig.screenHeight * 0.06,
//                          title: AppString.call,
//                          onTap: () {
//
//                          },
//                        ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * .03,
              ),
              InkWell(
                child: Padding(
                  padding:SizeConfig.sidePadding,
                  child: Text('Resend'),
                ),
                onTap: (){
                  model.sendProfileOtp(ProfileOtpCredential(phone: widget.arguments.phoneNumber,
                      userID: loggedInUser.id.toString())).then((value){
                    print(value.msg);
                    if(value.statuscode==1){
                      AppConstant.showSuccessToast(context, value.msg);
                    }else{
                      AppConstant.showFailToast(context, value.msg);
                    }
                  });

                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight * .25,
              ),

            ],
          ),
        ),
      ),
    );
  }


}
