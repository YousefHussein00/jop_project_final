import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Models/orders_model.dart';

class JobAdvertisementModel {
  int? id;
  String? nameJob;
  String? permanenceType;
  String? typeOfPlace;
  String? location;
  String? descrip;
  String? special;
  String? salry;
  String? periodExper;
  String? periodWork;
  String? timeWork;
  int? companyId;
  int? worksFileId;
  int? countryId;
  List<OrdersModel>? orders;
  CompanyModel? company;
  JobAdvertisementModel({
    this.id,
    this.nameJob,
    this.permanenceType,
    this.typeOfPlace,
    this.location,
    this.descrip,
    this.special,
    this.salry,
    this.periodExper,
    this.periodWork,
    this.timeWork,
    this.companyId,
    this.worksFileId,
    this.countryId,
    this.orders,
    this.company,
  });

  JobAdvertisementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameJob = json['name_job'];
    permanenceType = json['permanence_type'];
    typeOfPlace = json['type_of_place'];
    location = json['location'];
    descrip = json['descrip'];
    special = json['special'];
    salry = json['salry'];
    periodExper = json['period_Exper'];
    periodWork = json['period_work'];
    timeWork = json['time_work'];
    companyId = json['companyId'];
    worksFileId = json['works_FileId'];
    countryId = json['countryId'];
    if (json['orders'] != null) {
      List<OrdersModel> om = [];
      for (var element in json['orders']) {
        om.add(OrdersModel.fromJson(element));
      }
      orders = om;
    } else {
      orders = [];
    }
    if (json['company'] != null) {
      final data = json['company'];
      company = CompanyModel.fromJson(data);
    } else {
      company = CompanyModel();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_job'] = nameJob;
    data['permanence_type'] = permanenceType;
    data['type_of_place'] = typeOfPlace;
    data['location'] = location;
    data['descrip'] = descrip;
    data['special'] = special;
    data['salry'] = salry;
    data['period_Exper'] = periodExper;
    data['period_work'] = periodWork;
    data['time_work'] = timeWork;
    data['companyId'] = companyId;
    data['works_FileId'] = worksFileId;
    data['countryId'] = countryId;
    // data['orders'] = orders ?? [];
    // data['company'] = company ?? CompanyModel();
    return data;
  }
}
