import 'package:jop_project/Models/orders_model.dart';

class SearchersModel {
  int? id;
  String? fullName;
  String? age;
  String? typeWorkHours;
  String? gendr;
  String? cv;
  String? sta;
  String? location;
  String? special;
  String? educationLevel;
  String? img;
  String? phone;
  String? email;
  String? pass;
  String? bDate;
  String? tokenNotification;
  int? userId;
  List<OrdersModel>? orders;

  SearchersModel({
    this.id,
    this.fullName,
    this.age,
    this.typeWorkHours,
    this.gendr,
    this.cv,
    this.sta,
    this.location,
    this.special,
    this.educationLevel,
    this.img,
    this.phone,
    this.email,
    this.pass,
    this.bDate,
    this.tokenNotification,
    this.userId,
    this.orders,
  });

  SearchersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    age = json['age'];
    typeWorkHours = json['type_work_hours'];
    gendr = json['gendr'];
    cv = json['cv'];
    sta = json['sta'];
    location = json['location'];
    special = json['special'];
    educationLevel = json['education_level'];
    img = json['img'];
    phone = json['phone'];
    email = json['email'];
    pass = json['pass'];
    bDate = json['b_Date'];
    tokenNotification = json['tokenNotification'];
    userId = json['userId'];
    if (json['orders'] != null) {
      List<OrdersModel> om = [];
      for (var element in json['orders']) {
        om.add(OrdersModel.fromJson(element));
      }
      orders = om;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['age'] = age;
    data['type_work_hours'] = typeWorkHours;
    data['gendr'] = gendr;
    data['cv'] = cv;
    data['sta'] = sta;
    data['location'] = location;
    data['special'] = special;
    data['education_level'] = educationLevel;
    data['img'] = img;
    data['phone'] = phone;
    data['email'] = email;
    data['pass'] = pass;
    data['b_Date'] = bDate;
    data['tokenNotification'] = tokenNotification;
    data['userId'] = userId;
    data['orders'] = orders;
    return data;
  }
}
