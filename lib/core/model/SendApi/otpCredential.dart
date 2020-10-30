

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';


class OtpCredential extends Sendable {
  final String phone;
  final String otp;
  final String signature;
  final String fcm;



  OtpCredential({
    this.phone,this.otp,this.signature,this.fcm
  });

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone']=this.phone;
    data['otp']=this.otp;
    data['signature']=this.signature;
    data['fcm_token']=this.fcm;

    return data;
  }
}
