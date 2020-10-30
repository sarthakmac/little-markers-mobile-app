
import 'package:turing_academy/core/model/sendable.dart';


class UpdateProfileCredential extends Sendable {
  final String firstname;
  final String lastname;
  final String phone;
  final String fcmToken;


  UpdateProfileCredential({
    this.lastname,this.firstname,this.phone,this.fcmToken
  });

  /// Create the JSON required by Dayblizz API server for updating a post.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname']=this.firstname;
    data['lastname']=this.lastname;
    data['phone']=this.phone;
    data['fcm_token']=this.fcmToken;

    return data;
  }
}
