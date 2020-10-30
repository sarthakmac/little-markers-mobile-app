

import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/sendable.dart';

/// The kid change class is used to transfer all relevant content for updating
/// an existing kid on the little-marker server.
///

class KidCredentail extends Sendable {
  final int kidId;
  final int id;
  final int user_id;
  final String firstname;
  final String lastname;
  final String dob;
  final String education;
  final String school;
  final String university;
  final String status;
  final String created_at;
  final String updated_at;

  KidCredentail(
      {
        this.kidId,
        this.id,
        @required this.user_id,
        @required this.firstname,
        @required this.lastname,
        @required this.dob,
        @required this.education,
        @required this.school,
        @required this.university,
        @required this.status,
        @required this.created_at,
        @required this.updated_at});

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kid_id']=this.kidId;
    data['id'] = this.id;
    data['user_id'] = this.user_id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['school'] = this.school;
    data['dob'] = this.dob;
    data['education'] = this.education;
    data['university'] = this.university;
    data['status'] = this.status;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
