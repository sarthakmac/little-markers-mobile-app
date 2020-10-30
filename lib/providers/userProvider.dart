//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:turing_academy/constants/urls.dart';
//import 'package:turing_academy/core/model/responseModel.dart';
//import 'package:turing_academy/core/model/userAddressModel.dart';
//import 'package:turing_academy/core/model/userModel.dart';
//import 'package:http/http.dart' as http;
//import 'package:turing_academy/providers/authProvider.dart';
//
////UserAddressModel userAddressModel;
//
//class UserProvider with ChangeNotifier {
//  Future<ResponseModel> updateUserProfile(UserModel userModel) async {
//    try {
//      final response = await http.post(AppUrl.userProfileUrl,
//          headers: {
//            'Content-Type': 'application/json',
//            'Authorization': 'Bearer $token'
//          },
//          body: json.encode({
//            'firstname': userModel.firstname,
//            'lastname': userModel.lastname,
//            'phone': userModel.phone
//          }));
//      if (response.statusCode == 200) {
//        //profile update Sucessfull
//        loggedInUser = new UserModel(
//            firstname: userModel.firstname,
//            lastname: userModel.lastname,
//            email: loggedInUser.email,
//            password: loggedInUser.password,
//            phone: userModel.phone,
//            id: loggedInUser.id);
//        final ResponseModel responseModel = ResponseModel(
//            isSUcessfull: true,
//            responseMessage: "Profile Update Was SUcessfull");
//        return responseModel;
//      }
//    } catch (e) {
//      print(e);
//      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
//    }
//  }
//
//  Future<ResponseModel> getUserAddres(int userId) async {
//    userAddressModel = new UserAddressModel(
//        user_id: 0,
//        shipping_address_1: "",
//        shipping_address_2: "",
//        shipping_city: "",
//        shipping_state: "",
//        shipping_zipcode: "",
//        shipping_country: "",
//        billing_address_1: "",
//        billing_address_2: "",
//        billing_city: "",
//        billing_zipcode: "",
//        billing_state: "",
//        billing_country: "");
//    try {
//      String address = AppUrl.getAddress.trim() + userId.toString().trim();
//      final response = await http.get(
//        address,
//        headers: {
//          'Content-Type': 'application/json',
//          'Authorization': 'Bearer $token'
//        },
//      );
//      if (response.statusCode == 200) {
//        final statusCode = json.decode(response.body)['status'];
//
//        if (statusCode == 0) {
//          return ResponseModel(
//              isSUcessfull: false,
//              responseMessage: json.decode(response.body)['status'].toString());
//        }
//
//        //address update Sucessfull
//        final responseAddress =
//            json.decode(response.body)['addresses'] as Map<String, dynamic>;
//        userAddressModel = UserAddressModel.fromJson(responseAddress);
//        final ResponseModel responseModel = ResponseModel(
//            isSUcessfull: true,
//            responseMessage: "User Address gotten Sucessfull");
//        // notifyListeners();
//        return responseModel;
//      }
//    } catch (e) {
//      print(e);
//      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
//    }
//  }
//
//  Future<ResponseModel> updateUserAddress(
//      UserAddressModel userAddressModel) async {
//    try {
//      final response = await http.post(AppUrl.updateUserAddress,
//          headers: {
//            'Content-Type': 'application/json',
//            'Authorization': 'Bearer $token'
//          },
//          body: json.encode({
//            'billing_address_1': userAddressModel.billing_address_1,
//            'billing_address_2': userAddressModel.billing_address_2,
//            'billing_city': userAddressModel.billing_city,
//            'billing_country': userAddressModel.billing_country,
//            'billing_state': userAddressModel.billing_state,
//            'billing_zipcode': userAddressModel.billing_zipcode,
//            'shipping_address_1': userAddressModel.shipping_address_1,
//            'shipping_address_2': userAddressModel.shipping_address_2,
//            'shipping_city': userAddressModel.shipping_city,
//            'shipping_country': userAddressModel.shipping_country,
//            'shipping_state': userAddressModel.shipping_state,
//            'shipping_zipcode': userAddressModel.shipping_zipcode,
//            'user_id': userAddressModel.user_id
//          }));
//      if (response.statusCode == 200) {
//        final responseError = json.decode(response.body)['error'];
//        if (responseError != null) {
//          String allErrors = "";
//          final error = responseError as Map<String, dynamic>;
//          error.forEach((k, v) {
//            allErrors += v.toString() + "\n";
//          });
//          return ResponseModel(isSUcessfull: false, responseMessage: allErrors);
//        }
//        //address update Sucessfull
//        final ResponseModel responseModel = ResponseModel(
//            isSUcessfull: true,
//            responseMessage: "Address Update Was Sucessfull");
//        return responseModel;
//      }
//    } catch (e) {
//      print(e);
//      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
//    }
//  }
//}
