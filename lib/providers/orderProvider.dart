import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/orderModel.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:http/http.dart' as http;
import 'package:turing_academy/providers/cartProvider.dart';

import 'authProvider.dart';

class OrderProvider with ChangeNotifier {
  getCartCollections(List<CartCollection>cartCollections) {
    var cart = [];
    cartCollections.forEach((ct) {
//      Map<String, dynamic> cartValue = new Map<String, dynamic>();
//      cartValue['id'] = ct.product.id;
//      cartValue['name'] = ct.product.name;
//      cartValue['price'] = double.parse(ct.product.price);
//      cartValue['quantity'] = ct.quantity.toString();
      cart.add({
        'id':ct.product.id,
        'name':ct.product.name,
        'price':ct.product.price,
        'quantity':ct.quantity

      });
    });
    print("cart===$cart");
    return cart;
  }

  Future<ResponseModel> createOrder(OrderModel orderModel,List<CartCollection>cartCollections) async {
    print(orderModel.kid_id);
    print(orderModel.date_time);
    print(orderModel.sub_total);
    print(orderModel.tax_total);
    print(orderModel.shipping_total);
    print(loggedInUser.id);
    var carts = jsonEncode(orderModel.collections.map((e) => e.toJson()).toList());


    try {
      final response = await http.post(AppUrl.createOrderAddress,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'user_id': loggedInUser.id,
            'kid_id': orderModel.kid_id,
            'sub_total': orderModel.sub_total,
            'tax_total': orderModel.tax_total,
            'shipping_total': orderModel.shipping_total,
            'grand_total': orderModel.grand_total,
            'date_time': orderModel.date_time,
            "cartContent": [
              {
                "id": "11",
                "quantity": "1",
                "attributes": {
                  "type": "physical"
                }
              },
              {
                "id": "10",
                "quantity": "2",
                "attributes": {
                  "type": "virtual"
                }
              }
            ]
          }));
      print('################################sub===${response.body}');
      if (response.statusCode == 200) {

        print('################################sub===${response.body}');
        final responseError = json.decode(response.body)['error'];
        if (responseError != null) {
          String allErrors = "";
          final error = responseError as Map<String, dynamic>;
          error.forEach((k, v) {
            allErrors += v.toString() + "\n";
          });
          final response = await http.post(AppUrl.clearCartAddress+loggedInUser.id.toString(),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token'
              },);
          print(response);
          return ResponseModel(isSUcessfull: false, responseMessage: allErrors);
        }

        //address update Sucessfull
        final ResponseModel responseModel = ResponseModel(
            isSUcessfull: true, responseMessage: "Order Created SUcessfully");
        return responseModel;
      }
    } catch (e) {

      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }
}
