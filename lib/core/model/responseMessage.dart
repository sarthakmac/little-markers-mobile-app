
import 'package:flutter/cupertino.dart';

class ResponseMessage{
  final String msg;
  final int statuscode;
  final String kidId;
  ResponseMessage({@required this.msg,@required this.statuscode,this.kidId});
}

