import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/responseModel.dart';

import 'package:http/http.dart' as http;

import 'authProvider.dart';

List<KidModel> kidListModel;

class KidsProvider with ChangeNotifier {
  Future<ResponseModel> getAllKids() async {
    kidListModel = [];
    try {
      String address = AppUrl.kidsAddress + loggedInUser.id.toString();
      final response = await http.get(
        address,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final statusCode = json.decode(response.body)['status'];

        if (statusCode == 0) {
          return ResponseModel(
              isSUcessfull: false,
              responseMessage: json.decode(response.body)['status'].toString());
        }
        //address update Sucessfull
        final Iterable responseProductLIst = json.decode(response.body)['kids'];
        if (responseProductLIst != null) {
          kidListModel = KidModel.kidstListFromJson(responseProductLIst);
        }
        final ResponseModel responseModel = ResponseModel(
            isSUcessfull: true, responseMessage: "kid Gotten Sucessfull");
        return responseModel;
      }
    } catch (e) {
      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }

  Future<ResponseModel> addKid(KidModel kidmodel) async {
    try {
      final response = await http.post(AppUrl.addKidAddress,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'user_id': loggedInUser.id,
            'firstname': kidmodel.firstname,
            'lastname': kidmodel.lastname,
            'age': kidmodel.age,
            'education': kidmodel.education,
            'school': kidmodel.school,
            'university': kidmodel.university,
            'status': "active",
          }));
      if (response.statusCode == 200) {
        final responseError = json.decode(response.body)['error'];
        if (responseError != null) {
          String allErrors = "";
          final error = responseError as Map<String, dynamic>;
          error.forEach((k, v) {
            allErrors += v.toString() + "\n";
          });
          return ResponseModel(isSUcessfull: false, responseMessage: allErrors);
        }
        //address update Sucessfull
        final ResponseModel responseModel = ResponseModel(
            isSUcessfull: true, responseMessage: "Kid Addition Was Sucessfull");
        kidListModel.add(kidmodel);
        return responseModel;
      }
    } catch (e) {
      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }

  Future<ResponseModel> updateKid(KidModel kidmodel) async {
    try {
      final response = await http.post(AppUrl.updateKidAddress,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'kid_id': kidmodel.id,
            'firstname': kidmodel.firstname,
            'lastname': kidmodel.lastname,
            'age': kidmodel.age,
            'education': kidmodel.education,
            'school': kidmodel.school,
            'university': kidmodel.university,
            'status': kidmodel.status,
          }));
      if (response.statusCode == 200) {
        final responseError = json.decode(response.body)['error'];
        if (responseError != null) {
          String allErrors = "";
          final error = responseError as Map<String, dynamic>;
          error.forEach((k, v) {
            allErrors += v.toString() + "\n";
          });
          return ResponseModel(isSUcessfull: false, responseMessage: allErrors);
        }
        //add kid update Sucessfull
        //update kid locally
        final oldKid = kidListModel.firstWhere((x) => x.id == kidmodel.id);
        final kidIndex = kidListModel.indexOf(oldKid);
        kidListModel[kidIndex] = kidmodel;
        final ResponseModel responseModel = ResponseModel(
            isSUcessfull: true, responseMessage: "Kid Update Was Sucessfull");
        return responseModel;
      }
    } catch (e) {
      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }

  Future<ResponseModel> deleteKid(int kidId) async {
    kidListModel = [];
    try {
      String address = AppUrl.deleteKidAddress + kidId.toString();
      final response = await http.get(
        address,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final statusCode = json.decode(response.body)['status'];

        if (statusCode == 0) {
          return ResponseModel(
              isSUcessfull: false,
              responseMessage: json.decode(response.body)['msg'].toString());
        }
        //address update Sucessfull

        final ResponseModel responseModel = ResponseModel(
            isSUcessfull: true, responseMessage: "kid Deleted Sucessfull");
        return responseModel;
      }
    } catch (e) {
      print(e);
      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
    }
  }
}
