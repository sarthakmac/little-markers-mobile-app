

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';


class ProfileOtpCredential extends Sendable {
  final String phone;
  final String otp;
  final String userID;



  ProfileOtpCredential({
    this.phone,this.otp,this.userID
  });

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone']=this.phone;
    data['otp']=this.otp;
    data['user_id']=this.userID;

    return data;
  }
}
