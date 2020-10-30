import 'package:turing_academy/core/model/productModel.dart';

class Order {
  int id;
  int userId;
  int kidId;
  String subTotal;
  String taxTotal;
  String shippingTotal;
  String grandTotal;
  String cartContent;
  String status;
  String paymentId;
  String dateTime;
  String createdAt;
  String updatedAt;
  List<OrderItems> orderItems;

  Order(
      {this.id,
        this.userId,
        this.kidId,
        this.subTotal,
        this.taxTotal,
        this.shippingTotal,
        this.grandTotal,
        this.cartContent,
        this.status,
        this.paymentId,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.orderItems});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    kidId = json['kid_id'];
    subTotal = json['sub_total'];
    taxTotal = json['tax_total'];
    shippingTotal = json['shipping_total'];
    grandTotal = json['grand_total'];
    cartContent = json['cartContent'];
    status = json['status'];
    paymentId = json['payment_id'];
    dateTime = json['date_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_items'] != null) {
      orderItems = new List<OrderItems>();
      json['order_items'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['kid_id'] = this.kidId;
    data['sub_total'] = this.subTotal;
    data['tax_total'] = this.taxTotal;
    data['shipping_total'] = this.shippingTotal;
    data['grand_total'] = this.grandTotal;
    data['cartContent'] = this.cartContent;
    data['status'] = this.status;
    data['payment_id'] = this.paymentId;
    data['date_time'] = this.dateTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  int id;
  int orderId;
  int userId;
  int kidId;
  int productId;
  String quantity;
  String price;
  String createdAt;
  String updatedAt;
  ProductModel product;

  OrderItems(
      {this.id,
        this.orderId,
        this.userId,
        this.kidId,
        this.productId,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.product});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    kidId = json['kid_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new ProductModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['kid_id'] = this.kidId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
//    if (this.product != null) {
//      data['product'] = this.product.toJson();
//    }
    return data;
  }
}

class Product {
  int id;
  String name;
  String type;
  String sku;
  String image;
  String shortDesc;
  String longDesc;
  String price;
  String createdAt;
  String updatedAt;
  int taxId;
  String status;
  String duration;

  Product(
      {this.id,
        this.name,
        this.type,
        this.sku,
        this.image,
        this.shortDesc,
        this.longDesc,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.taxId,
        this.status,
        this.duration});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    sku = json['sku'];
    image = json['image'];
    shortDesc = json['short_desc'];
    longDesc = json['long_desc'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    taxId = json['tax_id'];
    status = json['status'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['sku'] = this.sku;
    data['image'] = this.image;
    data['short_desc'] = this.shortDesc;
    data['long_desc'] = this.longDesc;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['tax_id'] = this.taxId;
    data['status'] = this.status;
    data['duration'] = this.duration;
    return data;
  }
}