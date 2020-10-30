
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:path/path.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/kidId.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/services/baseApi.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:async/async.dart';

class KidApi extends BaseApi{

  Future<dynamic>getkitList(){
    return getRequest(AppUrl.kidsAddress + loggedInUser.id.toString(), (r) {
      print(r.body);

      return (json.decode(r.body)['kids'] as List).map((e) => KidModel.fromJson(e)).toList();
    });

  }
  Future<dynamic>addKidList(KidCredentail kidCredentail){
    return postRequest(AppUrl.addKidAddress, (r) {
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
            msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status'],
          kidId: json.decode(r.body)['kid']['id'].toString()
        );
      }

    },kidCredentail);
  }

  Future<dynamic>updateKid(KidCredentail kidCredentail){
    print(kidCredentail.toJson());
    return postRequest(AppUrl.updateKidAddress, (r) {
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

    },kidCredentail);

  }
  Future<dynamic>deleteKid(KidModel kidModel){

    print(KidIdSend(kidId: kidModel.id).toJson());

    return postRequest(AppUrl.deleteKidAddress, (r) {
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

    },KidIdSend(kidId: kidModel.id));

  }
  Future<dynamic>updateKidImageApi(String kidId,File image)async{
    var uri = Uri.parse(AppUrl.updateKidImage);
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
            DelegatingStream.typed(image.openRead())),
        await image.length(),
        filename: basename(image.path),
      ),

    );
    request.fields['kid_id'] = kidId;

    try{
      var response = await request.send();
      var data= await response.stream.transform(utf8.decoder);
      String dataString=await data.single;
      var res= jsonDecode(dataString);


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


}