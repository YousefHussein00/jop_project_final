import 'package:jop_project/Models/job_advertisement_model.dart';

class JobRecommendationDtoModel {
  JobAdvertisementModel? job;
  double? matchPercentage;
  SimilarityDetailsModel? similarityDetails;
  MatchingExperienceModel? matchingExperience;

  JobRecommendationDtoModel(
      {this.job,
      this.matchPercentage,
      this.similarityDetails,
      this.matchingExperience});

  JobRecommendationDtoModel.fromJson(Map<String, dynamic> json) {
    job = json['job'] != null
        ? JobAdvertisementModel.fromJson(json['job'])
        : null;
    matchPercentage = json['matchPercentage'] ?? 0.0;
    similarityDetails = json['similarityDetails'] != null
        ? SimilarityDetailsModel.fromJson(json['similarityDetails'])
        : null;
    matchingExperience = json['matchingExperience'] != null
        ? MatchingExperienceModel.fromJson(json['matchingExperience'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job'] = job?.toJson();
    data['matchPercentage'] = matchPercentage;
    data['similarityDetails'] = similarityDetails?.toJson();
    data['matchingExperience'] = matchingExperience?.toJson();
    return data;
  }
}

class MatchingExperienceModel {
  String? companyName;
  String? experienceTitle;
  String? duration;
  double? titleMatchScore;
  double? durationMatchScore;

  MatchingExperienceModel(
      {this.companyName,
      this.experienceTitle,
      this.duration,
      this.titleMatchScore,
      this.durationMatchScore});

  MatchingExperienceModel.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    experienceTitle = json['experienceTitle'];
    duration = json['duration'];
    titleMatchScore = json['titleMatchScore'];
    durationMatchScore = json['durationMatchScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyName'] = companyName;
    data['experienceTitle'] = experienceTitle;
    data['duration'] = duration;
    data['titleMatchScore'] = titleMatchScore;
    data['durationMatchScore'] = durationMatchScore;
    return data;
  }
}

class SimilarityDetailsModel {
  double? typeWork;
  double? location;
  double? special;
  double? jobTitle;
  double? experience;

  SimilarityDetailsModel(
      {this.typeWork,
      this.location,
      this.special,
      this.jobTitle,
      this.experience});

  SimilarityDetailsModel.fromJson(Map<String, dynamic> json) {
    typeWork = json['TypeWork'];
    location = json['Location'];
    special = json['Special'];
    jobTitle = json['JobTitle'];
    experience = json['Experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeWork'] = typeWork;
    data['Location'] = location;
    data['Special'] = special;
    data['JobTitle'] = jobTitle;
    data['Experience'] = experience;
    return data;
  }
}
