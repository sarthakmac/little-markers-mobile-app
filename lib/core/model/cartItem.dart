class CartItem {
  var status;
  var msg;
  var cartEmpty;
  List<CartCollection> cartCollection;
  var cartCount;
  var cartSubTotal;
  var cartTaxTotal;
  var cartShippingTotal;
  var cartGrandTotal;

  CartItem(
      {this.status,
        this.msg,
        this.cartEmpty,
        this.cartCollection,
        this.cartCount,
        this.cartSubTotal,
        this.cartTaxTotal,
        this.cartShippingTotal,
        this.cartGrandTotal});

  CartItem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    cartEmpty = json['cartEmpty'];
    if (json['cartCollection'] != null) {
      cartCollection = new List<CartCollection>();
      json['cartCollection'].forEach((v) {
        cartCollection.add(new CartCollection.fromJson(v));
      });
    }
    cartCount = json['cartCount'];
    cartSubTotal = json['cartSubTotal'];
    cartTaxTotal = json['cartTaxTotal'];
    cartShippingTotal = json['cartShippingTotal'];
    cartGrandTotal = json['cartGrandTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['cartEmpty'] = this.cartEmpty;
    if (this.cartCollection != null) {
      data['cartCollection'] =
          this.cartCollection.map((v) => v.toJson()).toList();
    }
    data['cartCount'] = this.cartCount;
    data['cartSubTotal'] = this.cartSubTotal;
    data['cartTaxTotal'] = this.cartTaxTotal;
    data['cartShippingTotal'] = this.cartShippingTotal;
    data['cartGrandTotal'] = this.cartGrandTotal;
    return data;
  }
}

class CartCollection {
  int id;
  int cartId;
  int userId;
  int productId;
  int taxClassId;
  String quantity;
  String price;
  String createdAt;
  String updatedAt;
  Product product;
  TaxClass taxClass;

  CartCollection(
      {this.id,
        this.cartId,
        this.userId,
        this.productId,
        this.taxClassId,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.taxClass});

  CartCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    taxClassId = json['tax_class_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    taxClass = json['tax_class'] != null
        ? new TaxClass.fromJson(json['tax_class'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['tax_class_id'] = this.taxClassId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.taxClass != null) {
      data['tax_class'] = this.taxClass.toJson();
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

class TaxClass {
  int id;
  String taxTitle;
  String taxPercentage;
  String createdAt;
  String updatedAt;

  TaxClass(
      {this.id,
        this.taxTitle,
        this.taxPercentage,
        this.createdAt,
        this.updatedAt});

  TaxClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxTitle = json['tax_title'];
    taxPercentage = json['tax_percentage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_title'] = this.taxTitle;
    data['tax_percentage'] = this.taxPercentage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}