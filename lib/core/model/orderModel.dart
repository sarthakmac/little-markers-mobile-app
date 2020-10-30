import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/cartModel.dart';

class OrderModel {
  final int user_id;
  final int kid_id;
  final String sub_total;
  final String tax_total;
  final String shipping_total;
  final String grand_total;
  final String date_time;
  final List<CartCollection>collections;

  OrderModel(
      {@required this.user_id,
      @required this.kid_id,
      @required this.sub_total,
      @required this.tax_total,
      @required this.shipping_total,
      @required this.grand_total,
      @required this.date_time,
      @required this.collections});
}
