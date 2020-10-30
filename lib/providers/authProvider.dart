import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/responseModel.dart';

import 'package:turing_academy/core/model/userModel.dart';
import 'package:turing_academy/core/pref.dart';

UserModel loggedInUser;

String token;

class AuthProvider with ChangeNotifier {
  Future<ResponseModel> loginUser({String email, String password,String fcmToken}) async {
    try {
      final response = await http.post(AppUrl.loginAPi,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password,
          'fcm_token':fcmToken}));
      if (response.statusCode == 200) {
        print(response.body);
        var data=json.decode(response.body);
        print(data['status']);
        if(data['status']==1){
          final responseUser =
          json.decode(response.body)['user'] as Map<String, dynamic>;
          loggedInUser = UserModel.fromJson(responseUser,json.decode(response.body)['token']);

          Prefs.setUserProfile(loggedInUser);
          //get token
          token = json.decode(response.body)['token'];



          return ResponseModel(
              isSUcessfull: true, responseMessage: data['msg']);
        }else{
          return ResponseModel(
              isSUcessfull: false, responseMessage: data['msg']);
        }

      } else {
        return ResponseModel(
            isSUcessfull: false, responseMessage: "The email or password you entered is incorrect");
      }
    } catch (e) {
      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }

  Future<ResponseModel> signUpUser(UserModel userModel) async {
    try {
      final response = await http.post(AppUrl.signUpApi,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'firstname': userModel.firstname,
            'lastname': userModel.lastname,
            'password': userModel.password,
            'confirm_password': userModel.password,
            'phone': userModel.phone,
            'email': userModel.email,
          }));
      print(response.body);
      if (response.statusCode == 200) {
        //login sucessfull
        print(response.body);
        final responseError = json.decode(response.body)['error'];
        if (responseError != null) {
          String allErrors = "";
          final error = responseError as Map<String, dynamic>;
          error.forEach((k, v) {
            allErrors += v.toString() + "\n";
          });
          return ResponseModel(isSUcessfull: false, responseMessage: allErrors);
        }
        return ResponseModel(
            isSUcessfull: true, responseMessage: "User SignUp  Successful");
      } else {
        return ResponseModel(
            isSUcessfull: false, responseMessage: "Sign Up Failed");
      }
    } catch (e) {
      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }
}
