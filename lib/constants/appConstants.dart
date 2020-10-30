import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:turing_academy/constants/urls.dart';

import 'appColors.dart';
import 'appStyle.dart';
import 'package:http/http.dart' as http;
class AppConstant {
  static double fontSizeMedium;
  static double fontSizeSmall;
  static double fontSizeLarge;
  static double fontSizeSmaller;
  static double fontSizeVerySmall;
  static double fontSizeVerySmaller;

  ///Size of the numbers which are shown when there are new post in the feedscreen or new messages;
  static double fontSizeNumberPopUpSmall;
  static double iconSizeSmall;
  static double iconSizeMedium;
  static double iconSizeLarge;
  static const phoneNumberFormate='00000000000';

  static String stringValidator(String value, String controllerName) {
    if (value.isEmpty) {
      return "$controllerName cannot be empty";
    }else if(value=='notvalid'){
      return 'Please enter valid $controllerName';
    }
    return null;
  }

  static bool isPasswordCompliant(String password)
  {

    bool isComplient = false;
    bool hasUppercase  = false;
    bool hasDigits = false;
    bool hasLowercase = false;
    bool hasSpecialCharacters = false;
    bool currectlength=false;
    var character='';
    var i=0;
    print(password);
    bool isDigit(String s, int idx) =>
        "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;
    if (! password?.isEmpty) {
      // Check if valid special characters are present
      hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      while (i < password.length){
        character = password.substring(i,i+1);
        print(character);

        if (isDigit(character , 0)){
          hasDigits=true;
        }else{
          print('rrr${character.length}');
          if(password.length>7){
            currectlength=true;
          }

          if (character == character.toUpperCase()) {
            hasUppercase=true;
          }
          if (character == character.toLowerCase()){
            hasLowercase=true;
          }
        }
        i++;
      }
    }
    isComplient = currectlength & hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters;
    return isComplient;
  }
  static String phoneValidator(String value, String controllerName) {
    if (value.isEmpty) {
      return "$controllerName cannot be empty";
    }else if(value.length<10){
      return 'minimum length 10 digit';
    }
    return null;
  }
  static String changeDateformate(String dateString){
    var dateTime = DateTime.parse(dateString);
    String date='${DateFormat('d MMM, yyyy').format(dateTime)}';
    return date;
  }

  static showFialureDialogue(String message, BuildContext context) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Something went wrong",
              style: AppStyles.headingTextStyle,
            ),
            content: Text(
              message,
              style: AppStyles.smallRedTextStyle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  static showCustomFialureDialogue(String title,String message, BuildContext context) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
             title,
              style: AppStyles.headingTextStyle,
            ),
            content: Text(
              message,
              style: AppStyles.smallRedTextStyle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static showSuccessDialogue(String message, BuildContext context) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Operation successful",
              style: AppStyles.headingTextStyle,
            ),
            content: Text(
              message,
              style: AppStyles.smallGreenTextStyle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  static comfirmsDialogue(String message, BuildContext context,Function function) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              message,
              style: AppStyles.headingTextStyle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  function();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static Widget circularInidcator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.accentColor,
      ),
    );
  }
  static  void showSuccessToast(BuildContext context,String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 5, gravity: gravity,backgroundColor: Colors.green);
  }
  static  void showFailToast(BuildContext context,String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 5, gravity: gravity,backgroundColor: AppColors.redBottonColor);
  }

  static Future<bool> checkAppStatus()async{
    try{
      final client = http.Client();
      var result=await client.get(AppUrl.appStatusChecker);
      print(result.body);

      if(200 >= result.statusCode && result.statusCode < 300){

        print(result.body);
        if(json.decode(result.body)=='true'){
          return true;
        }else{
          return false;
        }

      }else{
        return false;
      }
    }catch(e){
      print('$e');
      return false;
    }

  }

}
