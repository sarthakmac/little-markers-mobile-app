

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';

class ChangePasswordCredentail extends Sendable {
  final int user_id;
  final String old_password;
  final String password;
  final String password_confirmation;

  ChangePasswordCredentail(
      {
        @required this.user_id,
        @required this.old_password,
        @required this.password,
        @required this.password_confirmation});

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['old_password'] = this.old_password;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    return data;
  }
}
