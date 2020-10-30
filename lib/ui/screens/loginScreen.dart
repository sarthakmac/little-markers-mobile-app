import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/SendApi/updateProfileCredential.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/services/pushNotification.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/cartProvider.dart';
import 'package:turing_academy/providers/kidsProvider.dart';
import 'package:turing_academy/providers/shippingProvider.dart';
import 'package:turing_academy/ui/screens/authentication/signInwithOtp.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/screens/otpOnMessageScreen.dart';
import 'package:turing_academy/ui/screens/registrationScreen.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/logoWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'package:turing_academy/ui/widgets/socialLogIn.dart';
import 'package:turing_academy/ui/widgets/widgetOr.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final TextEditingController _emailCOntroller = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _passwordFocusNode = FocusNode();
  ResponseModel responseModel =
      new ResponseModel(isSUcessfull: null, responseMessage: null);

  final _formKey = GlobalKey<FormState>();

  void login() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      responseModel = await Provider.of<AuthProvider>(context, listen: false)
          .loginUser(email:_emailCOntroller.text,password: _passwordController.text,
      fcmToken: await PushNotificationsManager().getToken());

      setState(() {
        _isLoading = false;
      });

      if (!responseModel.isSUcessfull) {
        AppConstant.showFialureDialogue(responseModel.responseMessage, context);
        currentCartList = [];


      } else {
        setState(() {
          _isLoading = false;
        });
        int currentIndex= await Prefs.getCurrentIndex();
        Provider.of<UserViewModel>(context,listen: false)
            .updateProfile(UpdateProfileCredential(
            fcmToken: await PushNotificationsManager().getToken(),
            firstname: loggedInUser.firstname,
            lastname: loggedInUser.lastname,
            phone: loggedInUser.phone
        ));
        Provider.of<KidsProvider>(context, listen: false).getAllKids();
        Provider.of<ShippingProvider>(context, listen: false)
            .getAllShippingRates();

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName,arguments:currentIndex);
      }
    } catch (e) {
      _isLoading = false;
      if(mounted){
        setState(() {

        });
      }

      AppConstant.showFialureDialogue("The email or password you entered is incorrect", context);

    }
  }



  @override
  void dispose() {
    _emailCOntroller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
                        fontSize: AppConstant.fontSizeSmall*1.1,
                        color: AppColors.redBottonColor,
                        fontWeight: FontWeight.w700),textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppTextFormFieldWidget(
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      controller: _emailCOntroller,
                      labelText: AppString.parentsEmailAddress,
                      textInputType: TextInputType.emailAddress,
                      obsecureText: false,
                      validator: (value) {
                        if(EmailValidator.validate(value)){
                          return null;
                        }else{
                          if(value==''){
                            return AppConstant.stringValidator(value, AppString.email);
                          }
                          return AppString.pleaseEntervalidEmail;

                        }
                      },
                      onSubmit: (val){
                        if(EmailValidator.validate(val)){
                          FocusScope.of(context).requestFocus(_passwordFocusNode);

                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppTextFormFieldWidget(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      labelText: AppString.password,
                      textInputAction: TextInputAction.done,
                      obsecureText: true,
                      validator: (value)=>AppConstant.stringValidator(value, AppString.password),
                      onSubmit: (val){
                        login();
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .022,
                  ),
                  InkWell(
                    child: Text(
                      AppString.forgotYourPassword,
                      style: TextStyle(
                          fontSize: AppConstant.fontSizeSmall,
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(OtpOnMessageScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .023,
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
                            title: AppString.signIn,
                            onTap: login,
                          ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .024,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppBotton(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.06,
                      title: AppString.signInwithOtp,
                      onTap: (){
                        Navigator.of(context)
                            .pushNamed(SigInWithOtpScreen.routeName);
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .024,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: AppOrWidget(),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        right: SizeConfig.screenWidth * .1),
                    child: SocialLogInRow(),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .05,
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
                              Navigator.of(context)
                                  .pushNamed(RegistrationScreeen.routeName);
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
      ),
    );
  }
}
