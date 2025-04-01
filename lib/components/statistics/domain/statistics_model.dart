class StatisticsModel {
  final int acceptedApplications;
  final int totalUsers;
  final int availableCompanies;
  final int totalCompanies;

  StatisticsModel({
    required this.acceptedApplications,
    required this.totalUsers,
    required this.availableCompanies,
    required this.totalCompanies,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      acceptedApplications: json['acceptedApplications'] ?? 0,
      totalUsers: json['totalUsers'] ?? 0,
      availableCompanies: json['availableCompanies'] ?? 0,
      totalCompanies: json['totalCompanies'] ?? 0,
    );
  }
}