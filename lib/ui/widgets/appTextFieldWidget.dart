import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'dart:io' show Platform;

class AppTextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  bool obsecureText;
  TextInputType textInputType;
  AppTextFieldWidget(
      {this.controller, this.labelText, this.obsecureText, this.textInputType});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor: AppColors.fontGreyColor,
          accentColor: Colors.orange,
          hintColor: Colors.green),
      child: TextField(
        style: AppStyles.textFieldTextStyle,
        controller: controller,
        cursorColor: AppColors.fontGreyColor,
        keyboardType:
            textInputType != null ? textInputType : TextInputType.text,
        obscureText: obsecureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: AppColors.redBottonColor,
              fontSize: AppConstant.fontSizeSmall),
//          border: UnderlineInputBorder(
//            borderSide: BorderSide(
//              color: AppColors.fontGreyColor
//            )
//          )
        ),
      ),
    );
  }
}

class AppTextFormFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  bool obsecureText;
  TextInputType textInputType;
  Function validator;
  Function onSubmit;
  FocusNode focusNode;
  bool enabled;
  TextInputAction textInputAction;

  bool autoCorrect;
  AppTextFormFieldWidget(
      {this.controller,this.enabled:true,
      this.labelText,
      this.obsecureText,
      this.textInputType,
      this.validator,this.onSubmit,this.autoCorrect:false,this.textInputAction,this.focusNode});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor: AppColors.fontGreyColor,
          accentColor: Colors.orange,
          hintColor: Colors.green),
      child: TextFormField(
        style: AppStyles.textFieldTextStyle,
        controller: controller,
        cursorColor: AppColors.fontGreyColor,
        autocorrect: autoCorrect,
        enabled: enabled,
        focusNode: focusNode,
        textInputAction: textInputAction!=null?textInputAction:Platform.isIOS?TextInputAction.continueAction:TextInputAction.none,
        keyboardType:
            textInputType != null ? textInputType : TextInputType.text,
        obscureText: obsecureText,
        validator: validator,
        onFieldSubmitted: (val){
          if(onSubmit!=null){
            onSubmit(val);
          }


        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: AppColors.redBottonColor,
              fontSize: AppConstant.fontSizeSmall),
//          border: UnderlineInputBorder(
//            borderSide: BorderSide(
//              color: AppColors.fontGreyColor
//            )
//          )
        ),
      ),
    );
  }
}
