import 'package:flutter/material.dart';

class UserAddressModel {
  final int user_id;
  final String shipping_address_1;
  final String shipping_address_2;
  final String shipping_city;
  final String shipping_state;
  final String shipping_zipcode;
  final String shipping_country;
  final String billing_address_1;
  final String billing_address_2;
  final String billing_city;
  final String billing_zipcode;
  final String billing_state;
  final String billing_country;
  final String shipping_phone;

  UserAddressModel(
      {@required this.user_id,
      @required this.shipping_address_1,
      @required this.shipping_address_2,
      @required this.shipping_city,
      @required this.shipping_state,
      @required this.shipping_zipcode,
      @required this.shipping_country,
      @required this.billing_address_1,
      @required this.billing_address_2,
      @required this.billing_city,
      @required this.billing_zipcode,
      @required this.billing_state,
        this.shipping_phone,
      @required this.billing_country});

  UserAddressModel.fromJson(Map<String, dynamic> json)
      : this.user_id = json['user_id'],
        this.shipping_address_1 = json['shipping_address_1'],
        this.shipping_address_2 = json['shipping_address_2'],
        this.shipping_city = json['shipping_city'],
        this.shipping_state = json['shipping_state'],
        this.shipping_zipcode = json['shipping_zipcode'],
        this.shipping_country = json['shipping_country'],
        this.billing_address_1 = json['billing_address_1'],
        this.billing_address_2 = json['billing_address_2'],
        this.billing_city = json['billing_city'],
        this.billing_zipcode = json['billing_zipcode'],
        this.billing_state = json['billing_state'],
        this.shipping_phone=json['shipping_phone'],
        this.billing_country = json['billing_country'];
}
