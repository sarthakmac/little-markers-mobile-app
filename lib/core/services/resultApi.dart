
import 'dart:convert';

import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addProductCartCredential.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/textReport.dart';
import 'package:turing_academy/core/services/baseApi.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';

class ResultApi extends BaseApi{

  Future<dynamic>getTextResultApi(String subriptionId){
    return getRequest(AppUrl.resultImage+subriptionId, (r) {
      print(r.body);
      return (json.decode(r.body)['text_report'] as List).map((e) => TextReport.fromJson(e)).toList();
    });

  }
  Future<dynamic>getImageResultApi(String subriptionId){
    return getRequest(AppUrl.resultImage+subriptionId, (r) {
      print(r.body);
      return (json.decode(r.body)['text_report'] as List).map((e) => TextReport.fromJson(e)).toList();
    });

  }
  Future<dynamic>getVideoResultApi(String subriptionId){
    return getRequest(AppUrl.resultVideo+subriptionId, (r) {
      print(r.body);
      return (json.decode(r.body)['text_report'] as List).map((e) => TextReport.fromJson(e)).toList();
    });

  }





}