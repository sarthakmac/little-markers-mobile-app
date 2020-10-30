import 'dart:convert';
import 'package:turing_academy/models/product.dart';

class ProductRepository {

  final data = '[{"id":1, "title":"Little Markers", "price":80.01, "description": "Loren", "images": ["assets/product-img.png"]}, {"id":1, "title":"Little Markers", "price":"aaaa", "description": "", "images": ["assets/product-img.png"]}, {"id":1, "title":"Little Markers", "price":"800a", "description": "", "images": ["assets/product-img.png"]}, {"id":1, "title":"Little Markers", "price":800000, "description": "", "images": ["assets/product-img.png"]}, {"id":1, "title":"Little Markers", "price":800000, "description": "", "images": ["assets/product-img.png"]}, {"id":1, "title":"Little Markers", "price":800000, "description": "", "images": ["assets/product-img.png"]} ,{"id":1, "title":"Little Markers", "price":800000, "description": "", "images": ["assets/product-img.png"]}, {"id":1, "title":"Little Markers", "price":800000, "description": "", "images": ["assets/product-img.png"]}]';

  List<Product> parseProducts(List<dynamic> data) {

    List<Product> products = [];
    data.forEach((dynamic map) {
      try {
        products.add(Product.fromMap(map));
      } on Exception catch(e) {
         // TODO: handle exception
      }
    });

    return products;
  }
  
  // TODO: limit, offset
  Future<List<Product>> searchProducts() {
    return Future.delayed(Duration(seconds: 2), () => parseProducts(json.decode(data) as List));
  }
}