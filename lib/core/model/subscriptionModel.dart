class Subscriptions {
  int id;
  int orderId;
  int userId;
  int kidId;
  int productId;
  String subscriptionStartDate;
  String subscriptionEndDate;
  String status;
  String createdAt;
  String updatedAt;
  Product product;
  Order order;
  Kid kid;
  User user;

  Subscriptions(
      {this.id,
        this.orderId,
        this.userId,
        this.kidId,
        this.productId,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.order,
        this.kid,
        this.user});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    kidId = json['kid_id'];
    productId = json['product_id'];
    subscriptionStartDate = json['subscription_start_date'];
    subscriptionEndDate = json['subscription_end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    kid = json['kid'] != null ? new Kid.fromJson(json['kid']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['kid_id'] = this.kidId;
    data['product_id'] = this.productId;
    data['subscription_start_date'] = this.subscriptionStartDate;
    data['subscription_end_date'] = this.subscriptionEndDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    if (this.kid != null) {
      data['kid'] = this.kid.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
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
  String duration;
  List<SubProducts> subProducts;

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
        this.duration,
        this.subProducts});

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
    if (json['sub_products'] != null) {
      subProducts = new List<SubProducts>();
      json['sub_products'].forEach((v) {
        subProducts.add(new SubProducts.fromJson(v));
      });
    }
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
    if (this.subProducts != null) {
      data['sub_products'] = this.subProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubProducts {
  int id;
  int productId;
  String name;
  String type;
  String sku;
  String image;
  String shortDesc;
  String longDesc;
  String status;
  String createdAt;
  String updatedAt;
  List<SubProductsContent> subProductsContent;

  SubProducts(
      {this.id,
        this.productId,
        this.name,
        this.type,
        this.sku,
        this.image,
        this.shortDesc,
        this.longDesc,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subProductsContent});

  SubProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    type = json['type'];
    sku = json['sku'];
    image = json['image'];
    shortDesc = json['short_desc'];
    longDesc = json['long_desc'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sub_products_content'] != null) {
      subProductsContent = new List<SubProductsContent>();
      json['sub_products_content'].forEach((v) {
        subProductsContent.add(new SubProductsContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['sku'] = this.sku;
    data['image'] = this.image;
    data['short_desc'] = this.shortDesc;
    data['long_desc'] = this.longDesc;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subProductsContent != null) {
      data['sub_products_content'] =
          this.subProductsContent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubProductsContent {
  int id;
  int productId;
  int subProductId;
  String title;
  String contentType;
  String description;
  String pdf;
  String createdAt;
  String updatedAt;

  SubProductsContent(
      {this.id,
        this.productId,
        this.subProductId,
        this.title,
        this.contentType,
        this.description,
        this.pdf,
        this.createdAt,
        this.updatedAt});

  SubProductsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    subProductId = json['sub_product_id'];
    title = json['title'];
    contentType = json['content_type'];
    description = json['description'];
    pdf = json['pdf'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['sub_product_id'] = this.subProductId;
    data['title'] = this.title;
    data['content_type'] = this.contentType;
    data['description'] = this.description;
    data['pdf'] = this.pdf;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

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
        this.updatedAt});

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
    return data;
  }
}

class Kid {
  int id;
  int userId;
  String firstname;
  String lastname;
  int age;
  String dob;
  String education;
  String school;
  String university;
  String status;
  String image;
  String createdAt;
  String updatedAt;

  Kid(
      {this.id,
        this.userId,
        this.firstname,
        this.lastname,
        this.age,
        this.dob,
        this.education,
        this.school,
        this.university,
        this.status,
        this.image,
        this.createdAt,
        this.updatedAt});

  Kid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    dob = json['dob'];
    education = json['education'];
    school = json['school'];
    university = json['university'];
    status = json['status'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['education'] = this.education;
    data['school'] = this.school;
    data['university'] = this.university;
    data['status'] = this.status;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int id;
  String firstname;
  String lastname;
  String email;
  Null emailVerifiedAt;
  String phone;
  String status;
  String image;
  String fcmToken;
  String otp;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.status,
        this.image,
        this.fcmToken,
        this.otp,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    status = json['status'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    otp = json['otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['image'] = this.image;
    data['fcm_token'] = this.fcmToken;
    data['otp'] = this.otp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}