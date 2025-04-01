import 'package:flutter/material.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:provider/provider.dart';
import '../provider/statistics_provider.dart';
import '../widgets/statistic_bar.dart';
import '../widgets/circular_indicator.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<StatisticsProvider>().fetchStatistics(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applicationstatistics,
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[300],
      ),
      body: Consumer<StatisticsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          final stats = provider.statistics;
          if (stats == null) {
            return const Center(child: Text('No data available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircularIndicator(
                  value: stats.acceptedApplications.toString(),
                  label: l10n.acceptedapplication,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularIndicator(
                      value: stats.availableCompanies.toString(),
                      label: l10n.availablecompany,
                      color: Colors.blue,
                    ),
                    CircularIndicator(
                      value: stats.totalUsers.toString(),
                      label: l10n.users,
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                StatisticBar(
                  label: l10n.havehired,
                  value: stats.acceptedApplications,
                  total: stats.acceptedApplications,
                ),
                StatisticBar(
                  label: l10n.usersapplication,
                  value: stats.totalUsers,
                  total: stats.totalUsers,
                ),
                StatisticBar(
                  label: l10n.companiesapplication,
                  value: stats.availableCompanies,
                  total: stats.totalCompanies,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
