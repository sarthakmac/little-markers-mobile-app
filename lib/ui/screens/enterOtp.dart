import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/otpCredential.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/services/pushNotification.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/logoWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class OtpScreenArguments{
  String phoneNumber;
  bool logIn;
  OtpScreenArguments({this.logIn,this.phoneNumber});
}
class EnterOtpScreen extends StatefulWidget {
  static const String routeName = '/enterOtpScreen';
  OtpScreenArguments otpScreenArguments;
  EnterOtpScreen({this.otpScreenArguments});

  @override
  _EnterOtpScreenState createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> with CodeAutoFill{
  final sidePadding = SizeConfig.screenWidth * .1;
  Timer _timer;
  int _start = 60;

  TextEditingController codetronller=TextEditingController();

  String currentText;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }


  String signature;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

      body: ScreenBackGround(
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(
                  height: SizeConfig.screenHeight * .07,
                ),
                LogoWidget(),

                SizedBox(
                  height: SizeConfig.screenHeight * .03,
                ),
                Text(
                  AppString.welcome,
                  style: TextStyle(
                      color: AppColors.blackBackgroundColor,
                      fontSize: AppConstant.fontSizeLarge,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Text(
                  AppString.appName,
                  style: TextStyle(
                      fontSize: AppConstant.fontSizeMedium,
                      color: AppColors.redBottonColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .02,
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
                      if(widget.otpScreenArguments.logIn){

                        model.loginverifyOtp(OtpCredential(
                            phone: widget.otpScreenArguments.phoneNumber,
                            otp: v,
                          fcm: await PushNotificationsManager().getToken()
                        )).then((value) {

                          if (!value.isSUcessfull) {
                            AppConstant.showFialureDialogue(value.responseMessage, context);

                          } else {

                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                          }

                        });


                      }else{
                        model.verifyOtp(OtpCredential(
                            phone: widget.otpScreenArguments.phoneNumber,
                            otp: v,
                          fcm: await PushNotificationsManager().getToken()
                        )).then((value){
                          if(value.statuscode==1){
                            AppConstant.showSuccessToast(context, value.msg);
                            if(Navigator.canPop(context)){
                              Navigator.pop(context);
                            }
                            if(Navigator.canPop(context)){
                              Navigator.pop(context);
                            }
                          }else{
                            AppConstant.showFailToast(context, value.msg);
                          }
                        });
                      }

                    },

                  ),
                ),
//                Padding(
//                  padding:
//                      EdgeInsets.only(left: sidePadding, right: sidePadding),
//                  child: PinCodeTextField(
//
//                    length: 6,
//                    obsecureText: false,
//                    animationType: AnimationType.fade,
//                    shape: PinCodeFieldShape.underline,
//                    animationDuration: Duration(milliseconds: 300),
////                    borderRadius: BorderRadius.circular(5),
//                    fieldHeight: 50,
//                    backgroundColor: Colors.transparent,
//                    fieldWidth: 40,
//                    activeFillColor: Colors.transparent,
//                    enableActiveFill: false,
////                    errorAnimationController: errorController,
//                    controller: codetronller,
//
//                    onCompleted: (v) {
//                      if(widget.otpScreenArguments.logIn){
//
//                        model.loginverifyOtp(OtpCredential(
//                            phone: widget.otpScreenArguments.phoneNumber,
//                            otp: v
//                        )).then((value) {
//
//                          if (!value.isSUcessfull) {
//                            AppConstant.showFialureDialogue(value.responseMessage, context);
//
//                          } else {
//
//                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
//                          }
//
//                        });
//
//
//                      }else{
//                        model.verifyOtp(OtpCredential(
//                            phone: widget.otpScreenArguments.phoneNumber,
//                            otp: v
//                        )).then((value){
//                          if(value.statuscode==1){
//                            AppConstant.showSuccessToast(context, value.msg);
//                            if(Navigator.canPop(context)){
//                              Navigator.pop(context);
//                            }
//                            if(Navigator.canPop(context)){
//                              Navigator.pop(context);
//                            }
//                          }else{
//                            AppConstant.showFailToast(context, value.msg);
//                          }
//                        });
//                      }
//
//                    },
//                    onChanged: (value) {
//                      print(value);
//                      setState(() {
//                        currentText = value;
//                      });
//                    },
//                  ),
//                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
//                Padding(
//                  padding:
//                      EdgeInsets.only(left: sidePadding, right: sidePadding),
//                  child: RichText(
//                    text: TextSpan(
//                      text: '00:$_start ',
//                      style: TextStyle(
//                        fontSize: AppConstant.fontSizeSmaller,
//                        color: AppColors.redBottonColor,
//                      ),
//                      children: <TextSpan>[
//                        TextSpan(
//                            text: AppString.verifyviaCall,
//                            style: TextStyle(
//                              fontSize: AppConstant.fontSizeSmaller,
//                              color: AppColors.accentColor,
//                            )),
//                      ],
//                    ),
//                  ),
//                ),
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
                              if(widget.otpScreenArguments.logIn){

                                model.loginverifyOtp(OtpCredential(
                                    phone: widget.otpScreenArguments.phoneNumber,
                                    otp: currentText,
                                  fcm: await PushNotificationsManager().getToken()
                                )).then((value) {

                                  if (!value.isSUcessfull) {
                                    AppConstant.showFialureDialogue(value.responseMessage, context);

                                  } else {

                                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName,arguments: currentIndex);
                                  }

                                });


                              }else{
                                model.verifyOtp(OtpCredential(
                                    phone: widget.otpScreenArguments.phoneNumber,
                                    otp: currentText,
                                  fcm: await PushNotificationsManager().getToken()
                                )).then((value){
                                  if(value.statuscode==1){
                                    AppConstant.showSuccessToast(context, value.msg);
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                    }
                                    if(Navigator.canPop(context)){
                                      Navigator.pop(context);
                                    }
                                  }else{
                                    AppConstant.showFailToast(context, value.msg);
                                  }
                                });
                              }

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
                    model.sendOtp(OtpCredential(phone: widget.otpScreenArguments.phoneNumber,
                        signature: signature)).then((value){
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
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight * .02,
                  ),
                  child: Container(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppString.dontHaveAccount,
                          style: TextStyle(
                              color: AppColors.fontGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                          child: Text(
                            AppString.signUpNow,
                            style: TextStyle(
                                color: AppColors.redBottonColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
