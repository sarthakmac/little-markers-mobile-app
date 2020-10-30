//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:turing_academy/constants/urls.dart';
//import 'package:turing_academy/core/model/productModel.dart';
//import 'package:turing_academy/core/model/responseModel.dart';
//import 'package:turing_academy/models/product.dart';
//import 'package:turing_academy/repositories/productRepository.dart';
//import 'package:http/http.dart' as http;
//
//import 'authProvider.dart';
//
//List<ProductModel> productListModel;
//
//class ProductProvider with ChangeNotifier {
//  ProductRepository _productRepository;
//  List<Product> _items = [];
//  List<Product> get items => List<Product>.from(_items);
//  bool isLoading = true;
//
//  getProducts() async {
//    isLoading = true;
//    notifyListeners();
//    _items = await _productRepository.searchProducts();
//    isLoading = false;
//    // TODO: remove later
//    _items.shuffle();
//    notifyListeners();
//  }
//
//  Future<ResponseModel> getAllProducts() async {
//    productListModel = [];
//    try {
//      String address = AppUrl.productsAddress;
//      final response = await http.get(
//        address,
//        headers: {
//          'Content-Type': 'application/json',
//          'Authorization': 'Bearer $token'
//        },
//      );
//      if (response.statusCode == 200) {
//        final statusCode = json.decode(response.body)['status'];
//
//        if (statusCode == 0) {
//          return ResponseModel(
//              isSUcessfull: false,
//              responseMessage: json.decode(response.body)['status'].toString());
//        }
//        //address update Sucessfull
//        final Iterable responseProductLIst =
//            json.decode(response.body)['products'];
//        if (responseProductLIst != null) {
//          productListModel =
//              ProductModel.productListFromJson(responseProductLIst);
//        }
//        final ResponseModel responseModel = ResponseModel(
//            isSUcessfull: true, responseMessage: "product Updated Sucessfull");
//        return responseModel;
//      }
//    } catch (e) {
//      print(e);
//      return ResponseModel(isSUcessfull: false, responseMessage: e.toString());
//    }
//  }
//}
