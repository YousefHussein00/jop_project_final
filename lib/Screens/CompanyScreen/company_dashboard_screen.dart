import 'package:flutter/material.dart';
import 'package:jop_project/Providers/Caht-firebase_database/chat_provider_firebase_database.dart';
import 'package:jop_project/Providers/Job/job_provider.dart';
import 'package:jop_project/Providers/Orders/order_provider.dart';
import 'package:jop_project/Providers/Searchers/searchers_provider.dart';
import 'package:jop_project/Screens/CompanyScreen/add_job_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/applicants_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/company_jobs_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/company_info_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/accepted_screen.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../ChatScreen/company_chats_screen.dart';

class CompanyDashboardScreen extends StatelessWidget {
  final CompanyModel company;

  const CompanyDashboardScreen({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Provider.of<ChatProvider>(context, listen: true)
        .getChatsByCompanyIdLignth(company.countryId.toString());
    return Background(
      height: SizeConfig.screenH! / 4.5,
      showListNotiv: true,
      title: l10n.home,
      isCompany: true,
      userImage: company.img,
      userName: company.nameCompany,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCompanyHeader(),
              const SizedBox(height: 32),
              _buildDashboardGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return Column(
      children: [
        // CircleAvatar(
        //   radius: 50,
        //   backgroundImage: company.img != null
        //       ? NetworkImage(company.img!)
        //       : const AssetImage('assets/images/profile.png'),
        // ),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:
                  //  imagePath != null && imagePath != ''
                  //     ?
                  Image.network(
                company.img ?? '',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(loadingProgress.expectedTotalBytes != null
                          ? (loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!)
                              .toStringAsFixed(2)
                          : ''),
                      const CircularProgressIndicator(),
                    ],
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 50,
                  );
                },
              ),
              // : const Icon(
              //     Icons.person,
              //     size: 50,
              //   ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          company.nameCompany!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          company.location!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardGrid(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);
    final jobs = Provider.of<JobsProvider>(context);
    final searchersProvider = Provider.of<SearchersProvider>(context);
    final job =
        jobs.jobs.where((element) => element.companyId == company.id).toList();
    final order = orders.ordersByCompany.where(
        (element) => job.any((job) => job.id == element.jobAdvertisementId));
    final countAccepted = order.where((element) => element.accept == 1);
    final searchers = searchersProvider.searchers
        .where(
          (searcharr) => order
              .where(
                  (ordr) => ordr.accept == 1 && ordr.searcherId == searcharr.id)
              .isNotEmpty,
        )
        .toList();
    final l10n = AppLocalizations.of(context);
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildDashboardCard(
            l10n.viewjobs,
            Icons.work,
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyJobsScreen(company: company),
                  ),
                ),
            context),
        _buildDashboardCard(
            l10n.addvacancy,
            Icons.add_circle,
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddJopScreen()),
                ),
            context),
        _buildDashboardCard(
            '${l10n.applicants} (${context.watch<OrderProvider>().ordersByCompany.length})',
            Icons.people, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ApplicantsScreen(
                  // job: job[0],
                  ),
            ),
          );
        }, context),
        _buildDashboardCard(
            '${l10n.accepted} (${countAccepted.length})',
            Icons.check_circle,
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AcceptedScreen(searchers: searchers),
                  ),
                ),
            context),
        _buildDashboardCard(
            '${l10n.messages} (${Provider.of<ChatProvider>(context).chats.length})',
            Icons.message,
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CompanyChatsScreen(companyId: company.id.toString()),
                    // MessagesScreen(messages: mockMessages),
                  ),
                ),
            context),
        _buildDashboardCard(
            l10n.companyinformation,
            Icons.info,
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompanyInfoScreen(),
                  ),
                ),
            context),
      ],
    );
  }

  Widget _buildDashboardCard(
      String title, IconData icon, VoidCallback onTap, BuildContext context) {
    Provider.of<ChatProvider>(context)
        .getChatsByCompanyId(company.id.toString());
    return Card(
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: const Color(0xFF6B8CC7),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
