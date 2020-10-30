
import 'dart:convert';

import 'package:http/http.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/kidId.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/notification.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/services/baseApi.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';

class NotificationAPi extends BaseApi{

  Future<dynamic>getNotificationApi(){
    return getRequest(AppUrl.notificationAdrress+'/'+loggedInUser.id.toString(), (r) {
      print(r.body);

      return (json.decode(r.body)['notifications'] as List).map((e) => Notifications.fromJson(e)).toList();
    });

  }
  Future<dynamic>clearNotificationApi(){
    return getRequest(AppUrl.clearAllNotification+loggedInUser.id.toString(), (r) {
      print(r.body);
      var res=json.decode(r.body);

      return ResponseMessage(msg: res['msg'], statuscode: res['status']);
    });

  }
  Future<dynamic>markAllNotificationApi(){
    return getRequest(AppUrl.markAllReadNotification+loggedInUser.id.toString(), (r) {
      print(r.body);
      var res=json.decode(r.body);

      return ResponseMessage(msg: res['msg'], statuscode: res['status']);
    });

  }



}