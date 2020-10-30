import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';

class AddProductCartCredentail extends Sendable {
  final int quantity;
  final int product_id;
  final int user_id;


  AddProductCartCredentail(
      {
        @required this.quantity,
        @required this.user_id,
        @required this.product_id,});

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity']=this.quantity;
    data['user_id'] = this.user_id;
    data['product_id'] = this.product_id;

    return data;
  }
}
