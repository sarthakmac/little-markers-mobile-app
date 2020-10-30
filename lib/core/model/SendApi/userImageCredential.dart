import 'dart:io';

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';

class UserImageCredential extends Sendable {
  final int userId;
  final File file;


  UserImageCredential({
    this.userId,this.file
  });

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id']=this.userId;
    data['image']=this.file;

    return data;
  }
}
