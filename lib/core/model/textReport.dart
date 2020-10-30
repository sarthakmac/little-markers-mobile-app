class TextReport {
  int id;
  int orderId;
  int userId;
  int kidId;
  int productId;
  int subProductId;
  int subscriptionId;
  String progressType;
  String title;
  String description;
  String image;
  String videoUrl;
  String ratings;
  String createdAt;
  String updatedAt;

  TextReport(
      {this.id,
        this.orderId,
        this.userId,
        this.kidId,
        this.productId,
        this.subProductId,
        this.subscriptionId,
        this.progressType,
        this.title,
        this.description,
        this.image,
        this.videoUrl,
        this.ratings,
        this.createdAt,
        this.updatedAt});

  TextReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    kidId = json['kid_id'];
    productId = json['product_id'];
    subProductId = json['sub_product_id'];
    subscriptionId = json['subscription_id'];
    progressType = json['progress_type'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    videoUrl = json['video_url'];
    ratings = json['ratings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['kid_id'] = this.kidId;
    data['product_id'] = this.productId;
    data['sub_product_id'] = this.subProductId;
    data['subscription_id'] = this.subscriptionId;
    data['progress_type'] = this.progressType;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['video_url'] = this.videoUrl;
    data['ratings'] = this.ratings;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}