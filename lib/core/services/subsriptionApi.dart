
import 'dart:convert';

import 'package:http/http.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/kidId.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/subscriptionModel.dart';
import 'package:turing_academy/core/services/baseApi.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';

class SubscriptionApi extends BaseApi{

  Future<dynamic>getSubcriptionApi(){
    return getRequest(AppUrl.activeSubscriptionAddress+loggedInUser.id.toString(), (r) {
      print(r.body);

      return (json.decode(r.body)['subscriptions'] as List).map((e) => Subscriptions.fromJson(e)).toList();
    });

  }



}