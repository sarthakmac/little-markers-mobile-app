
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/sendable.dart';

/// The kid change class is used to transfer all relevant content for updating
/// an existing kid on the little-marker server.
///

class CreateOrderCredential extends Sendable {
  final String user_id;
  final String kid_id;
  final String sub_total;
  final String tax_total;
  final String shipping_total;
  final String grand_total;
  final String date_time;
  final String payment_id;
  final List<CartCollection> cartContent;


  CreateOrderCredential({this.payment_id,
  this.user_id,this.kid_id,this.cartContent,this.date_time,this.grand_total,this.shipping_total,this.sub_total,this.tax_total
  });

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kid_id']=kid_id;
    data['user_id']=user_id;
    data['payment_id']=payment_id;
    data['sub_total']=sub_total;
    data['tax_total']=tax_total;
    data['shipping_total']=shipping_total;
    data['grand_total']=grand_total;
    data['date_time']=date_time;
    data['cartContent']=jsonEncode(getCartCollections(cartContent));


    return data;
  }
}

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
      'quantity':ct.quantity,
      'attributes':{
        'type':ct.product.type
      }

    });
  });
  print("cart===$cart");
  return cart;
}
