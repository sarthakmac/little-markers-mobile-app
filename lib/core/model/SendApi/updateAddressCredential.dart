

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';


class UpdateAddressCredential extends Sendable {
  final String billing_address_1;
  final String billing_address_2;
  final String billing_city;
  final String billing_country;
  final String billing_state;
  final String billing_zipcode;
  final String shipping_address_1;
  final String shipping_address_2;
  final String shipping_city;
  final String shipping_country;
  final String shipping_state;
  final String shipping_zipcode;
  String shipping_phone;
  final int user_id;



  UpdateAddressCredential({this.shipping_phone,
    this.user_id,this.billing_address_1,this.billing_address_2,this.billing_city,this.billing_country,this.billing_state,this.billing_zipcode,this.shipping_address_1,this.shipping_address_2,
    this.shipping_city,this.shipping_country,this.shipping_state,this.shipping_zipcode
  });

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billing_address_1']=this.billing_address_1;
    data['billing_address_2']= this.billing_address_2;
    data['billing_city']= this.billing_city;
    data['billing_country']= this.billing_country;
    data['billing_state']= this.billing_state;
    data['billing_zipcode']= this.billing_zipcode;
    data['shipping_address_1']= this.shipping_address_1;
    data['shipping_address_2']= this.shipping_address_2;
    data['shipping_city']=this.shipping_city;
    data['shipping_country']= this.shipping_country;
    data['shipping_state']= this.shipping_state;
    data['shipping_zipcode']= this.shipping_zipcode;
    data['shipping_phone']=this.shipping_phone;
    data['user_id']=this.user_id;

    return data;
  }
}
