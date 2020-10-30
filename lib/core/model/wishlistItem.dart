class WishlistItem {
  int id;
  int userId;
  int productId;
  String createdAt;
  String updatedAt;
  Product product;

  WishlistItem(
      {this.id,
        this.userId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.product});

  WishlistItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
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
        this.status});

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
    return data;
  }
}