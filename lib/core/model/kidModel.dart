


class KidModel {
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

  KidModel(
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
  static List<KidModel> kidstListFromJson(List collection) {
    List<KidModel> kidsList =
    collection.map((json) => KidModel.fromJson(json)).toList();
    return kidsList;
  }

  KidModel.fromJson(Map<String, dynamic> json) {
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