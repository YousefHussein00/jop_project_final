import 'package:jop_project/Models/job_advertisement_model.dart';
import 'package:jop_project/Models/searcher_model.dart';

class OrdersModel {
  int? id;
  String? receptData;
  String? presentData;
  int? numberPresent;
  int? statuse;
  int? accept;
  int? unAccept;
  String? time;
  int? jobAdvertisementId;
  int? searcherId;
  SearchersModel? searcher;
  JobAdvertisementModel? jobAdvertisement;

  OrdersModel({
    this.id,
    this.receptData,
    this.presentData,
    this.numberPresent,
    this.statuse,
    this.accept,
    this.unAccept,
    this.time,
    this.jobAdvertisementId,
    this.searcherId,
    this.searcher,
    this.jobAdvertisement,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receptData = json['recept_data'];
    presentData = json['present_data'];
    numberPresent = json['number_Present'];
    statuse = json['statuse'];
    accept = json['accept'];
    unAccept = json['un_Accept'];
    time = json['time'];
    jobAdvertisementId = json['job_advertisementId'];
    searcherId = json['searcherId'];
    if (json['searcher'] != null) {
      final data = json['searcher'];
      searcher = SearchersModel.fromJson(data);
    }
    if (json['job_advertisement'] != null) {
      final data = json['job_advertisement'];
      jobAdvertisement = JobAdvertisementModel.fromJson(data);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['recept_data'] = receptData;
    data['present_data'] = presentData;
    data['number_Present'] = numberPresent;
    data['statuse'] = statuse;
    data['accept'] = accept;
    data['un_Accept'] = unAccept;
    data['time'] = time;
    data['job_advertisementId'] = jobAdvertisementId;
    data['searcherId'] = searcherId;
    // data['searcher'] = searcher;
    // data['job_advertisement'] = jobAdvertisement;
    return data;
  }
}
