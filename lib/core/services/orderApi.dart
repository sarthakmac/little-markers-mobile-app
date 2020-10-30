
import 'dart:convert';

import 'package:http/http.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/createOrderCredential.dart';
import 'package:turing_academy/core/model/SendApi/kidId.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/orderModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/services/baseApi.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';

class OrderApi extends BaseApi{

  Future<dynamic>getOrderApi(){
    print(AppUrl.orderListAddress +loggedInUser.id.toString());
    try{
      return getRequest(AppUrl.orderListAddress +loggedInUser.id.toString(), (r) {
        print(r.body);
        return (json.decode(r.body)['orders'] as List).map((e) => Order.fromJson(e)).toList();
      });
    }catch(e){
      print(e);
    }


  }

  Future<dynamic>createOrderApi(CreateOrderCredential createOrderCredential){

    return postRequest(AppUrl.createOrderAddress, (r) {
      print('############################${r.body}');
      return ResponseMessage(msg: jsonDecode(r.body)['msg'], statuscode: jsonDecode(r.body)['status']);

    },createOrderCredential);
  }

  Future<dynamic>clearCart(){
    return postRequest(AppUrl.clearCartAddress+loggedInUser.id.toString(), (r) {
      print('clear==${r.body}');
      return ResponseMessage(msg: jsonDecode(r.body)['msg'], statuscode: jsonDecode(r.body)['status']);
    });
  }



}