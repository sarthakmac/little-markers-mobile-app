import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:turing_academy/core/model/appError.dart';
import 'package:turing_academy/core/model/sendable.dart';
import 'package:turing_academy/providers/authProvider.dart';

GetIt getIt = GetIt.instance;

abstract class BaseApi {
  // TODO: Move the endpoint to some settings file?
  static const _ENDPOINT = 'https://dayblizz.appspot.com/';
  final client = http.Client();



  @protected
  Future<dynamic> getRequest(String path, Function(Response) success) async {

//    print('loggedInUser.token==${loggedInUser.token}');
//    print(path);
    return _processResponse(await client.get('$path',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loggedInUser.token}'
    }), success);
  }

  @protected
  Future<dynamic> postRequest(String path, Function(Response) success, [Sendable body]) async {

    return _processResponse(

        await client.post(
            path,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${loggedInUser.token}'
            },

            body: body != null ? jsonEncode(body.toJson()) : null

        ), success
    );
  }
  @protected
  Future<dynamic> postRequestWithoutToken(String path, Function(Response) success, [Sendable body]) async {

    return _processResponse(

        await client.post(
            path,
            headers: {
              'Content-Type': 'application/json',
//              'Authorization': 'Bearer ${loggedInUser.token}'
            },

            body: body != null ? jsonEncode(body.toJson()) : null

        ), success
    );
  }

  @protected
  Future<dynamic> putRequest(String path, Function(Response) success, [Sendable body]) async {
    return _processResponse(
        await client.put(
            '${BaseApi._ENDPOINT}/$path',

            body: body != null ? jsonEncode(body.toJson()) : null
        ), success
    );
  }

  @protected
  Future<dynamic> deleteRequest(String path, Function(Response) success) async {
    return _processResponse(await client.delete('${BaseApi._ENDPOINT}/$path'), success);
  }

  dynamic _processResponse(Response response, Function(Response) success) {
    if (200 >= response.statusCode && response.statusCode < 300) {
      return success(response);
    } else {
      print(response.body);
      return ApiError.fromJson(json.decode(response.body));
    }
  }

}
