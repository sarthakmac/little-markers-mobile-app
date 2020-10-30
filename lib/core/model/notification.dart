class Notifications {
  int id;
  int userId;
  String title;
  String body;
  String readStatus;
  String createdAt;
  String updatedAt;
  String addedAt;

  Notifications(
      {this.id,
        this.userId,
        this.title,
        this.body,
        this.readStatus,
        this.createdAt,
        this.updatedAt,this.addedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    body = json['body'];
    readStatus = json['read_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addedAt=json['added_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['read_status'] = this.readStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['added_at']=this.addedAt;
    return data;
  }
}