import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String name;
  final String type;
  final String sku;
  final String image;
  final String short_desc;
  final String long_desc;
  final String price;
  final String created_at;
  final String updated_at;
  final int tax_id;
  final int shipping_id;
  final String status;
  final TaxModel tax_class;
  final List<SubProductModel> sub_products;

  ProductModel(
      {@required this.id,
      @required this.name,
       this.type,
     this.sku,
      this.image,
   this.short_desc,
      this.long_desc,
       this.price,
      this.created_at,
      this.updated_at,
      this.tax_id,
      this.shipping_id,
       this.status,
      this.sub_products,
     this.tax_class});

  static List<ProductModel> productListFromJson(List collection) {
    List<ProductModel> productList =
        collection.map((json) => ProductModel.fromJson(json)).toList();
    return productList;
  }

  ProductModel.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.type = json['type'],
        this.sku = json['sku'],
        this.image = json['image'],
        this.short_desc = json['short_desc'],
        this.long_desc = json['long_desc'],
        this.price = json['price'],
        this.created_at = json['created_at'],
        this.updated_at = json['updated_at'],
        this.tax_id = json['tax_id'],
        this.shipping_id = json['shipping_id']??0,
        this.status = json['status'],
        this.tax_class = json['tax_class']!=null?TaxModel.fromJson(json['tax_class']):null,
        this.sub_products =
        json['sub_products']!=null?SubProductModel.subProductListFromJson(json['sub_products']):null;
}


class SubProductModel {
  final int id;
  final int product_id;
  final String name;
  final String type;
  final String sku;
  final String image;
  final String short_desc;
  final String long_desc;
  final String status;
  final String created_at;
  final String updated_at;

  SubProductModel(
      {@required this.id,
      @required this.product_id,
      @required this.name,
      @required this.type,
      @required this.sku,
      @required this.image,
      @required this.short_desc,
      @required this.long_desc,
      @required this.status,
      @required this.created_at,
      @required this.updated_at});

  static List<SubProductModel> subProductListFromJson(List collection) {
    List<SubProductModel> subProductModelList =
        collection.map((json) => SubProductModel.fromJson(json)).toList();
    return subProductModelList;
  }

  SubProductModel.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.product_id = json['product_id'],
        this.name = json['name'],
        this.type = json['type'],
        this.sku = json['sku'],
        this.image = json['image'],
        this.short_desc = json['short_desc'],
        this.long_desc = json['long_desc'],
        this.created_at = json['created_at'],
        this.updated_at = json['updated_at'],
        this.status = json['status'];
}

class TaxModel {
  final int id;
  final String tax_title;
  final String tax_percentage;
  final String created_at;
  final String updated_at;

  TaxModel(
      {@required this.id,
      @required this.tax_title,
      @required this.tax_percentage,
      @required this.created_at,
      @required this.updated_at});

  TaxModel.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.tax_title = json['tax_title'],
        this.tax_percentage = json['tax_percentage'],
        this.created_at = json['created_at'],
        this.updated_at = json['updated_at'];
}
