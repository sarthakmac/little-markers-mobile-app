import 'package:flutter/material.dart';

class ShippingModel {
  final int id;
  final String shipping_title;
  final String shipping_cost;
  final String status;
  final String created_at;
  final String updated_at;

  ShippingModel(
      {@required this.id,
      @required this.shipping_title,
      @required this.shipping_cost,
      @required this.status,
      @required this.created_at,
      @required this.updated_at});

  static List<ShippingModel> shiptListFromJson(List collection) {
    List<ShippingModel> shipList =
        collection.map((json) => ShippingModel.fromJson(json)).toList();
    return shipList;
  }

  ShippingModel.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.shipping_title = json['shipping_title'],
        this.shipping_cost = json['shipping_cost'],
        this.status = json['status'],
        this.created_at = json['created_at'],
        this.updated_at = json['updated_at'];
}
