import 'package:flutter/cupertino.dart';

class UserModel {
 int id;
  String token;
 String firstname;
  String lastname;
  String email;
 String password;
  String phone;
  String userImage;

  UserModel(
      {@required this.id,
         this.token,
      @required this.firstname,
      @required this.lastname,
      @required this.email,
      @required this.password,
      @required this.phone,this.userImage});

  UserModel.fromJson(Map<String, dynamic> json,String token)
      : this.id = json['id'],
        this.token=token,
        this.firstname = json['firstname'],
        this.lastname = json['lastname'],
        this.email = json['email'],
        this.userImage=json['image'],
        this.password = json['password'],
        this.phone = json['phone'];
}
