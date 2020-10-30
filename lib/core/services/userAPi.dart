
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/changePasswordCredential.dart';
import 'package:turing_academy/core/model/SendApi/otpCredential.dart';
import 'package:turing_academy/core/model/SendApi/updateAddressCredential.dart';
import 'package:turing_academy/core/model/SendApi/updateProfileCredential.dart';
import 'package:turing_academy/core/model/SendApi/userImageCredential.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/model/userAddressModel.dart';
import 'package:turing_academy/core/model/userModel.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/services/baseApi.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:http/http.dart'as http;
import 'package:async/async.dart';

class UserApi extends BaseApi{


  Future<dynamic>updateUserApi(UpdateProfileCredential updateProfileCredential){

    return postRequest(AppUrl.userProfileUrl, (r) {
      print(r.body);
      final responseError = json.decode(r.body)['error'];
      if (responseError != null) {
        String allErrors = "";
        final error = responseError as Map<String, dynamic>;
        error.forEach((k, v) {
          allErrors += v.toString() + "\n";
        });
        return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
      }else{
        return ResponseMessage(
            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
        );
      }

    },updateProfileCredential);
  }
  Future<dynamic>updateUserBillingAddressApi(UpdateAddressCredential updateAddressCredential){

    return postRequest(AppUrl.updatebillingAddress, (r) {
      print(r.body);
      final responseError = json.decode(r.body)['error'];
      if (responseError != null) {
        String allErrors = "";
        final error = responseError as Map<String, dynamic>;
        error.forEach((k, v) {
          allErrors += v.toString() + "\n";
        });
        return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
      }else{
        return ResponseMessage(
            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
        );
      }

    },updateAddressCredential);
  }
  Future<dynamic>updateUserShippingAddressApi(UpdateAddressCredential updateAddressCredential){

    return postRequest(AppUrl.updateSippingAddress, (r) {
      print(r.body);
      final responseError = json.decode(r.body)['error'];
      if (responseError != null) {
        String allErrors = "";
        final error = responseError as Map<String, dynamic>;
        error.forEach((k, v) {
          allErrors += v.toString() + "\n";
        });
        return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
      }else{
        return ResponseMessage(
            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
        );
      }

    },updateAddressCredential);
  }
Future <dynamic>getUserAddressApi(){
  String address = AppUrl.getAddress.trim() + loggedInUser.id.toString().trim();

  return getRequest(address, (r) {
    return UserAddressModel.fromJson(json.decode(r.body)['addresses']);
  });


}
//  Future<dynamic>updateUserImageApi(UserImageCredential userImageCredential){
//
//    return postRequest(AppUrl.userImageUrl, (r) {
//      print(r.body);
//      final responseError = json.decode(r.body)['error'];
//      if (responseError != null) {
//        String allErrors = "";
//        final error = responseError as Map<String, dynamic>;
//        error.forEach((k, v) {
//          allErrors += v.toString() + "\n";
//        });
//        return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
//      }else{
//        return ResponseMessage(
//            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
//        );
//      }
//
//    },userImageCredential);
//  }
  Future<dynamic>updateUserImageApi(UserImageCredential userImageCredential)async{
    var uri = Uri.parse(AppUrl.userImageUrl);

    print(userImageCredential.userId);


    var request = http.MultipartRequest('POST', uri,
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loggedInUser.token}'
    });
    request.files.add(
      http.MultipartFile(
          'image',
          http.ByteStream(
              DelegatingStream(userImageCredential.file.openRead())),
          await userImageCredential.file.length(),
      filename: basename(userImageCredential.file.path),
    ),

    );
    request.fields['user_id'] = userImageCredential.userId.toString();

    try{
      var response = await request.send();
      var data= response.stream.transform(utf8.decoder);
      String dataString=await data.single;
      var res= jsonDecode(dataString);
      print('apiRes==$res');

      return ResponseMessage(
          msg: res['msg'],statuscode: 1
      );
    }catch(e){
      print('error$e');
      return  ResponseMessage(
          msg:'Please try after sometime',statuscode: 2
      );

    }





  }

  Future <dynamic>getUserDetailsApi(){
    String address = AppUrl.userDetailsAddress;

    return getRequest(address, (r) {
      return UserModel.fromJson(json.decode(r.body,),loggedInUser.token);
    });


  }

  Future<dynamic>changePasswordApi(ChangePasswordCredentail changePasswordCredentail){
    return postRequest(AppUrl.changePasswordAddress, (r) {
      print(r.body);
      final responseError = json.decode(r.body)['error'];
      if (responseError != null) {
        String allErrors = "";
        final error = responseError as Map<String, dynamic>;
        error.forEach((k, v) {
          allErrors += v.toString() + "\n";
        });
        return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
      }else{
        return ResponseMessage(
            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
        );
      }
    },changePasswordCredentail);

  }
  Future<dynamic>sendOtpApi(OtpCredential otpCredential){
    return postRequestWithoutToken(AppUrl.sendOtp, (r) {
      print(r.body);
      final responseError = json.decode(r.body)['error'];
      if (responseError != null) {
        String allErrors = "";
        final error = responseError as Map<String, dynamic>;
        error.forEach((k, v) {
          allErrors += v.toString() + "\n";
        });
        return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
      }else{
        return ResponseMessage(
            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
        );
      }
    },otpCredential);

  }
  Future<dynamic>verifyOtpApi(OtpCredential otpCredential){
    return postRequestWithoutToken(AppUrl.verifyOtp, (r) {
      print(r.body);
      final responseError = json.decode(r.body)['error'];
      if (responseError != null) {
        String allErrors = "";
        final error = responseError as Map<String, dynamic>;
        error.forEach((k, v) {
          allErrors += v.toString() + "\n";
        });
        return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
      }else{
        return ResponseMessage(
            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
        );
      }
    },otpCredential);

  }
  Future<dynamic>loginVerifyOtpApi(OtpCredential otpCredential){

    print('working');
    return postRequestWithoutToken(AppUrl.loginVerifyOtp, (r) {
      print(r.body);
      final responseError = json.decode(r.body);
      if (responseError['status'] == 0) {

        return ResponseModel(isSUcessfull: false, responseMessage: responseError['msg']);
      }else{
        final responseUser =
        json.decode(r.body)['user'] as Map<String, dynamic>;
        loggedInUser = UserModel.fromJson(responseUser,json.decode(r.body)['token']);

        Prefs.setUserProfile(loggedInUser);
        //get token



        return ResponseModel(
            isSUcessfull: true, responseMessage: "User logged in Sucessfull");
      }
    },otpCredential);

  }

}