import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/responseModel.dart';

import 'package:http/http.dart' as http;
import 'package:turing_academy/core/model/shippingModel.dart';

import 'authProvider.dart';

List<ShippingModel> shippingListModel;

class ShippingProvider with ChangeNotifier {
  Future<ResponseModel> getAllShippingRates() async {
    shippingListModel = [];
    try {
      String address = AppUrl.shippingListAddress;
      final response = await http.get(
        address,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final statusCode = json.decode(response.body)['status'];

        if (statusCode == 0) {
          return ResponseModel(
              isSUcessfull: false,
              responseMessage: json.decode(response.body)['status'].toString());
        }
        //address update Sucessfull
        final Iterable responseShippingList =
            json.decode(response.body)['products'];
        shippingListModel =
            ShippingModel.shiptListFromJson(responseShippingList);
        final ResponseModel responseModel = ResponseModel(
            isSUcessfull: true,
            responseMessage: "Shipping List gotten Sucessfull");
        return responseModel;
      }
    } catch (e) {
      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }
}
