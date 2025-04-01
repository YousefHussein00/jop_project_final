import 'package:flutter/material.dart';
import 'package:jop_project/Providers/Companies/companies_provider.dart';
import 'package:jop_project/Providers/Orders/order_provider.dart';
import 'package:jop_project/Providers/Searchers/searchers_provider.dart';
import 'package:provider/provider.dart';
import '../../domain/statistics_model.dart';

class StatisticsProvider extends ChangeNotifier {
  StatisticsModel? _statistics;
  bool _isLoading = false;
  String? _error;

  StatisticsModel? get statistics => _statistics;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchStatistics(BuildContext context) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 2));
      _statistics = StatisticsModel(
        acceptedApplications: context
            .read<OrderProvider>()
            .orders
            .where((order) => order.accept == 1 && order.unAccept != 1)
            .length,
        totalUsers: context.read<SearchersProvider>().searchers.length,
        availableCompanies: context.read<CompaniesProvider>().companies.length,
        totalCompanies: context.read<CompaniesProvider>().companies.length,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
