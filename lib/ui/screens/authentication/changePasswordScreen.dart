import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/changePasswordCredential.dart';
import 'package:turing_academy/core/model/SendApi/userImageCredential.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/courseAppBar.dart';
import 'package:turing_academy/ui/widgets/profileImageWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = "change-password";
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ScrollController _scrollController;
  bool lastStatus = true;
  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController= TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink =>
      _scrollController.hasClients && _scrollController.offset > 5;

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

  Widget _devider() {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.screenHeight * .01,
          bottom: SizeConfig.screenHeight * .01),
      child: Container(
        height: 1,
        width: SizeConfig.screenWidth,
        color: AppColors.fontGreyColor.withOpacity(.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = SizeConfig.screenWidth * .03;
    final verticalPadding = SizeConfig.screenHeight * .01;
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
          AppString.changePassword, // + _scrollController.offset.toString(),
          style: AppStyles.headingTextStyle,
        ),
        centerTitle: true,
      ),
      body: model.state==ViewState.BUSY?AppConstant.circularInidcator():SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.05),
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.8,
              child: Form(
                key: _formKey,
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    ProfileImageWidget(
                      height: SizeConfig.screenHeight * .12,
                      width: SizeConfig.screenHeight * .12,
                      imageUrl: loggedInUser.userImage,
                      onpictureChange: (image){

                       model
                            .updateUserImage(UserImageCredential(
                            userId: loggedInUser.id,
                            file: image
                        )).then((value){

                          if(value.statuscode==1){

                            AppConstant.showSuccessDialogue(value.msg, context);

                          }else{

                            AppConstant.showFialureDialogue(value.msg, context);

                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * .02,
                    ),
                    Center(
                        child: Text(
                      "${loggedInUser.firstname} ${loggedInUser.lastname}",
                      style: AppStyles.titleTextStyle,
                    )),
                    SizedBox(
                      height: SizeConfig.screenHeight * .005,
                    ),
                    Center(
                      child: Text(
                        "${loggedInUser.email}",
                        style: AppStyles.verySmallRedTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _devider(),
                    Padding(
                      padding: EdgeInsets.only(
                        left: sidePadding, right: sidePadding,
//                    top: verticalPadding,bottom: verticalPadding
                      ),
                      child: AppTextFormFieldWidget(
                        controller: oldPasswordController,
                        labelText: AppString.oldPassword,
                        obsecureText: true,
                        validator:(value)=> AppConstant.stringValidator(value, AppString.oldPassword),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: sidePadding, right: sidePadding,
//                    top: verticalPadding,bottom: verticalPadding
                      ),
                      child: AppTextFormFieldWidget(
                        controller: newPasswordController,
                        labelText: AppString.newPassword,
                        obsecureText: true,
                        validator:(val){
                          if(AppConstant.isPasswordCompliant(val)){
                            return null;
                          }else{
                            if(val.length<9){
                              return AppString.minimumCharacter;
                            }else{
                              return AppString.passwordContainCapsNumberSymbols;
                            }
                          }

                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: sidePadding, right: sidePadding,
//                    top: verticalPadding,bottom: verticalPadding
                      ),
                      child: AppTextFormFieldWidget(
                        controller: confirmPasswordController,
                        labelText: AppString.confirmPassword,
                        obsecureText: true,
                        validator: (val){
                          if(val!=newPasswordController.text){
                            return AppString.bothPasswordsMustMatch;
                          }else{
                            return null;
                          }
                        },

                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sidePadding,
                          right: sidePadding,
                          top: verticalPadding,
                          bottom: verticalPadding),
                      child: AppBotton(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * .06,
                        title: AppString.updatePassword,
                        onTap: (){
                          bool isValid = _formKey.currentState.validate();
                          if (!isValid) {
                            return;
                          }
                          model.changePassword(ChangePasswordCredentail(
                            user_id: loggedInUser.id,
                            password_confirmation: confirmPasswordController.text,
                            password: newPasswordController.text,
                            old_password: oldPasswordController.text
                          )).then((value){
                            if(value.statuscode==1){
                              AppConstant.showSuccessDialogue(value.msg, context);
                            }else{
                              AppConstant.showFialureDialogue(value.msg, context);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
