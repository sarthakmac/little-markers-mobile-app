import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/otpCredential.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/ui/screens/enterOtp.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/logoWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'dart:io' show Platform;

import '../registrationScreen.dart';
class SigInWithOtpScreen extends StatefulWidget {
  static const String routeName = '/sigInWithOtpScreen';

  @override
  _SigInWithOtpScreenState createState() => _SigInWithOtpScreenState();
}

class _SigInWithOtpScreenState extends State<SigInWithOtpScreen> {
  final sidePadding = SizeConfig.screenWidth * .1;
  int countryCode=91;
  var _phoneNumberController = MaskedTextController(mask: AppConstant.phoneNumberFormate);
  final _formKey = GlobalKey<FormState>();
  String signature;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SmsAutoFill().getAppSignature.then((value)
    {
      print('object$value');
      setState(() {
        signature=value;
      });

    });
  }
  bool resend=false;

  @override
  Widget build(BuildContext context) {
    final model =Provider.of<UserViewModel>(context);
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
                      fontWeight: FontWeight.w700),textAlign: TextAlign.center
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .02,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:  EdgeInsets.only(
                        left: sidePadding,
                        right: sidePadding
                    ),
                    child: AppTextFormFieldWidget(
                      controller:_phoneNumberController,
                      labelText: AppString.mobileNumber,
                      obsecureText: false,
                      textInputType: TextInputType.phone,
                      textInputAction: Platform.isIOS?TextInputAction.continueAction:TextInputAction.none,
                      validator: (value) {
                        return AppConstant.phoneValidator(
                            value, AppString.parentMobileNumber);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: sidePadding, right: sidePadding),
                  child: Row(
                    children: <Widget>[
                      Text(
                        AppString.otptextSubtitle,
                        style: TextStyle(
                          fontSize: AppConstant.fontSizeSmaller,
                          color: AppColors.fontColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                model.state==ViewState.BUSY?AppConstant.circularInidcator():Padding(
                  padding:
                  EdgeInsets.only(left: sidePadding, right: sidePadding),
                  child: AppBotton(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.06,
                    title: AppString.getOtp,
                    onTap: () {
                      bool isValid = _formKey.currentState.validate();
                      if (!isValid) {
                        return;
                      }

                      model.sendOtp(OtpCredential(phone: _phoneNumberController.text,
                      signature: signature)).then((value){
                        print(value.msg);
                        if(value.statuscode==1){
                          AppConstant.showSuccessToast(context, value.msg);
                          Navigator.of(context).pushNamed(EnterOtpScreen.routeName,arguments: OtpScreenArguments(
                            phoneNumber: _phoneNumberController.text,
                            logIn: true
                          ));
                        }else{
                          AppConstant.showFailToast(context, value.msg);
                        }
                      });


                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
//                resend?InkWell(
//                  child: Padding(
//                    padding:SizeConfig.sidePadding,
//                    child: Text('Resend'),
//                  ),
//                  onTap: (){
//                    model.sendOtp(OtpCredential(phone: _phoneNumberController.text,
//                        signature: signature)).then((value){
//                      print(value.msg);
//                      if(value.statuscode==1){
//                        AppConstant.showSuccessToast(context, value.msg);
//                        Navigator.of(context).pushReplacementNamed(EnterOtpScreen.routeName,arguments: OtpScreenArguments(
//                            phoneNumber: _phoneNumberController.text,
//                            logIn: true
//                        ));
//                      }else{
//                        AppConstant.showFailToast(context, value.msg);
//                      }
//                    });
//
//                  },
//                ):Container(),
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
                            AppString.signUp,
                            style: TextStyle(
                                color: AppColors.redBottonColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(RegistrationScreeen.routeName);
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
