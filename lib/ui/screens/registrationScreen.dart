import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/model/userModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/screens/loginScreen.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/logoWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'package:turing_academy/ui/widgets/socialLogIn.dart';
import 'package:turing_academy/ui/widgets/widgetOr.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreeen extends StatefulWidget {
  static const String routeName = '/registrationScreen';

  @override
  _RegistrationScreeenState createState() => _RegistrationScreeenState();
}

class _RegistrationScreeenState extends State<RegistrationScreeen> {
  bool _isLoading = false;
  int countryCode=91;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  var _phoneNumberController = MaskedTextController(mask: '0000000000');

  ResponseModel responseModel =
      new ResponseModel(isSUcessfull: null, responseMessage: null);

  final _formKey = GlobalKey<FormState>();
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  void signUp() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final UserModel userModel = new UserModel(
          firstname: _nameController.text,
          lastname: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phone: countryCode.toString()+_phoneNumberController.text,
          id: null);
      responseModel = await Provider.of<AuthProvider>(context, listen: false)
          .signUpUser(userModel);
      setState(() {
        _isLoading = false;
      });

      if (!responseModel.isSUcessfull) {
        AppConstant.showFialureDialogue(responseModel.responseMessage, context);
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      AppConstant.showFialureDialogue(responseModel.responseMessage, context);
    }
  }
  
  bool agree=false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackGround(
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.screenHeight * .07,
                  ),
                  LogoWidget(),
                  SizedBox(
                    height: SizeConfig.screenHeight * .01,
                  ),
                  Text(
                    AppString.createAccount,
                    style: TextStyle(
                        color: AppColors.blackBackgroundColor,
                        fontSize: AppConstant.fontSizeLarge,
                        fontWeight: FontWeight.bold),
                  ),
//                  SizedBox(
//                    height: SizeConfig.screenHeight * .01,
//                  ),
//                  Text(
//                    AppString.appName,
//                    style: TextStyle(
//                        fontSize: AppConstant.fontSizeMedium,
//                        color: AppColors.redBottonColor,
//                        fontWeight: FontWeight.w700),textAlign: TextAlign.center
//                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppTextFormFieldWidget(
                      controller: _nameController,
                      labelText: AppString.parentFirstName,
                      obsecureText: false,
                      validator: (value) {
                        return AppConstant.stringValidator(
                            value, AppString.parentFirstName);
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppTextFormFieldWidget(
                      controller: _lastNameController,
                      labelText: AppString.parentLastName,
                      obsecureText: false,
                      validator: (value) {
                        return AppConstant.stringValidator(
                            value, AppString.parentLastName);
                      },
                    ),
                  ),
//                SizedBox(
//                  height: SizeConfig.screenHeight*.005,
//                ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppTextFormFieldWidget(
                      controller: _emailController,
                      labelText: AppString.parentsEmailAddress,
                      obsecureText: false,
                      validator: (value) {
                        if(EmailValidator.validate(value)){
                          return null;
                        }else{
                          return AppString.pleaseEntervalidEmail;

                        }
                      },
                    ),
                  ),
//                SizedBox(
//                  height: SizeConfig.screenHeight*.005,
//                ),
//                  Padding(
//                    padding: EdgeInsets.only(
//                        left: SizeConfig.screenWidth * .1,
//                        right: SizeConfig.screenWidth * .1),
//                    child: Row(
//                      children: <Widget>[
//                        CountryCodePicker(
//                          initialSelection: 'IN',
////                          initialSelection:
////                          Localizations.localeOf(context).countryCode,
//                          onChanged: (code) {
//                            setState(() {
//                              countryCode = int.parse(code.dialCode);
//                              print(countryCode);
//                            });
//                          },
//                          textStyle: TextStyle(fontSize: 20),
//                        ),
//                        SizedBox(
//                          width: SizeConfig.screenWidth*.01,
//                        ),
//                        Expanded(
//                          child: AppTextFormFieldWidget(
//                            controller: _phoneNumberController,
//                            labelText: AppString.parentMobileNumber,
//                            textInputType: TextInputType.phone,
//                            obsecureText: false,
//                            validator: (value) {
//                              return AppConstant.phoneValidator(
//                                  value, AppString.parentMobileNumber);
//                            },
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
                  Padding(
                    padding:  EdgeInsets.only(
                      left: SizeConfig.screenWidth * .1,
                      right: SizeConfig.screenWidth * .1,
                    ),
                    child: AppTextFormFieldWidget(
                      controller: _phoneNumberController,
                      labelText: AppString.parentMobileNumber,
                      textInputType: TextInputType.phone,
                      obsecureText: false,
                      validator: (value) {
                        return AppConstant.phoneValidator(
                            value, AppString.parentMobileNumber);
                      },
                    ),
                  ),

//                SizedBox(
//                  height: SizeConfig.screenHeight*.005,
//                ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppTextFormFieldWidget(
                      controller: _passwordController,
                      labelText: AppString.password,
                      obsecureText: true,
                      validator: (value) {
                        if(AppConstant.isPasswordCompliant(value)){
                          return null;
                        }else{
                          if(_passwordController.text.length<8){
                            return AppString.minimumCharacter;
                          }else{
                            return AppString.passwordContainCapsNumberSymbols;
                          }
                        }
//                        if(value.toString().isEmpty){
//                          return AppConstant.stringValidator(value, AppString.password);
//                        }else if(value.toString().length<8){
//                          return AppString.minimumCharacter;
//                        }else{
//                          return null;
//                        }
                      },
                    ),
                  ),
//                SizedBox(
//                  height: SizeConfig.screenHeight*.022,
//                ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .05,
                        right: SizeConfig.screenWidth * .1),
                    child: Row(
                      children: <Widget>[
                        Checkbox(value: agree, onChanged: (val) {
                          
                          setState(() {
                            agree=val;
                          });
                          
                        }),
                        InkWell(
                          child: SizedBox(
                              width: SizeConfig.screenWidth * .65,
                              child: Text(
                                AppString.iagree,
                                style: AppStyles.verySmallBlackTextStyle,
                              )),
                          onTap: ()async{
                            const url = 'https://turingacademy.io/terms-and-conditions/';
                            if (await canLaunch(url)) {
                            await launch(url);
                            } else {
                            throw 'Could not launch $url';
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.accentColor,
                            ),
                          )
                        : AppBotton(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.06,
                            title: AppString.signUp,
                            onTap:(){
                              if(agree){
                                signUp();
                              }else{
                                showToast('Please accept terms and conditions');
                              }
                            },
                          ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .015,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppOrWidget(),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: SocialLogInRow(),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .015,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.screenHeight * .01,
                    ),
                    child: Container(
                      width: SizeConfig.screenWidth,
                      child: Column(
                        children: <Widget>[
                          Text(
                            AppString.alreadyHaveaAccount,
                            style: TextStyle(
                                color: AppColors.fontGreyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          InkWell(
                            child: Text(
                              AppString.signinSmall,
                              style: TextStyle(
                                  color: AppColors.redBottonColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: 20,
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
      ),
    );
  }
}
