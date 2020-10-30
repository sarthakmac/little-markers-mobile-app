import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final int id;
  final String title;
  final String sku;
  final double price;
  final String description;
  final List<String> images;

  Product({
    this.id,
    this.title,
    this.sku,
    this.price,
    this.description,
    this.images,
  });

  Product copyWith({
    int id,
    String title,
    String sku,
    int price,
    String description,
    List<String> images,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': List<dynamic>.from(images.map((x) => x)),
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    double price = 0;
    try {
      price = map['price'].toDouble();
    } catch(e) {
      // TODO: handle exception
    }

    return Product(
      id: map['id'],
      title: map['title'],
      price: price,
      description: map['description'],
      images: List<String>.from(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  static Product fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => title;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Product &&
      o.id == id &&
      o.title == title &&
      o.price == price &&
      o.description == description &&
      listEquals(o.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      description.hashCode ^
      images.hashCode;
  }
}
