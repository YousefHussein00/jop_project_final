import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Providers/Companies/companies_provider.dart';
import 'package:jop_project/Providers/Orders/order_provider.dart';
import 'package:jop_project/Providers/SignUp/company_signin_login_provider.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/Providers/locale_provider.dart';
import 'package:jop_project/Screens/ChatScreen/company_chats_screen.dart';
import 'package:jop_project/Screens/ChatScreen/searcher_chats_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/applicants_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/company_dashboard_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/company_info_screen.dart';
import 'package:jop_project/Screens/CompanyScreen/company_jobs_screen.dart';
import 'package:jop_project/Screens/JopScreen/Home/home_screen.dart';
import 'package:jop_project/Screens/JopScreen/OrderScreen/order_screen.dart';
import 'package:jop_project/Screens/JopScreen/Profile/cv_screen.dart';
import 'package:jop_project/Screens/ShareScreen/Login/login_screen.dart';
import 'package:jop_project/components/statistics/presentation/screens/statistics_screen.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/size_config.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final bool isCompany;
  final String name;
  final String? imagePath;
  final int availableJobs;

  const CustomDrawer({
    super.key,
    required this.isCompany,
    required this.name,
    this.imagePath,
    this.availableJobs = 0,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final companyProvider = Provider.of<CompanySigninLoginProvider>(context);
    final searcherProvider = Provider.of<SearcherSigninLoginProvider>(context);
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF6B8CC7),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
        ),
        width: (SizeConfig.screenW! <= 750)
            ? SizeConfig.screenW! * 0.85
            : SizeConfig.screenW! * 0.5,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 40),
                // Profile Section
                InkWell(
                  onTap: isCompany
                      ? () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CompanyInfoScreen(),
                            ),
                          )
                      : null,
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
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
                          imagePath ?? '',
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
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 20),
                // Menu Items
                if (isCompany) ...[
                  _buildMenuItem(
                    context: context,
                    icon: Icons.dashboard,
                    title: l10n.controlpanel,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyDashboardScreen(
                            company:
                                Provider.of<CompanySigninLoginProvider>(context)
                                        .currentCompany ??
                                    CompanyModel(),
                          ),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.work,
                    title: l10n.postedjobs,
                    onTap: () {
                      // التنقل إلى صفحة الوظائف المنشورة
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyJobsScreen(
                              company: Provider.of<CompanySigninLoginProvider>(
                                      context)
                                  .currentCompany!),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.people,
                    title: l10n.applicants,
                    onTap: () {
                      // التنقل إلى صفحة المتقدمين
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApplicantsScreen(),
                        ),
                      );
                    },
                  ),
                ] else ...[
                  // Employee Menu Items
                  _buildMenuItem(
                    context: context,
                    icon: Icons.home,
                    title: l10n.home,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.person,
                    title: l10n.cvpreparation,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CVScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.work,
                    title: l10n.jobsapplied,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderScreen(),
                          ));
                      // التنقل إلى صفحة الوظائف المتقدم لها
                    },
                  ),
                ],
                _buildMenuItem(
                  context: context,
                  icon: Icons.message,
                  title: l10n.messages,
                  onTap: () {
                    // التنقل إلى صفحة الرسائل
                    if (!isCompany) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearcherChatsScreen(
                              searcherId: context
                                      .watch<SearcherSigninLoginProvider>()
                                      .currentSearcher
                                      ?.id
                                      .toString() ??
                                  ''),
                        ),
                      );
                    }
                    if (isCompany) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyChatsScreen(
                              companyId: context
                                      .watch<CompanySigninLoginProvider>()
                                      .currentCompany
                                      ?.id
                                      .toString() ??
                                  ''),
                        ),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.notifications,
                  title: l10n.notifications,
                  onTap: () {
                    // التنقل إلى صفحة الإشعارات
                  },
                ),
                _buildLanguageSelector(context),
                // _buildMenuItem(
                //   context: context,
                //   icon: Icons.language,
                //   title: 'اللغة',
                //   onTap: () {
                //     Navigator.pop(context);
                //     _showLanguageDialog(context);
                //   },
                // ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.settings,
                  title: l10n.settings,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: إضافة صفحة الإعدادات
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.group,
                  title: l10n.team,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: إضافة صفحة عن الفريق
                  },
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 20,
                  endIndent: 0,
                ),
                const SizedBox(height: 20),
                // Statistics Circle
                if (!isCompany) ...[
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${Provider.of<CompaniesProvider>(context).companies.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            l10n.availablecompany,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  // Company Statistics
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${Provider.of<OrderProvider>(context).orders.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            l10n.newapplicant,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                // Bottom Buttons
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildWhiteButton(
                            l10n.evaluation,
                            context,
                            isFullColor: true,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StatisticsScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildWhiteButton(
                            l10n.ourvalues,
                            context,
                            isFullColor: false,
                            onTap: () {
                              // TODO: إضافة صفحة التقييم
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StatisticsScreen(),
                                  // const StatisticsScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 20,
                      endIndent: 0,
                    ),
                    const SizedBox(height: 10),
                    _buildLogoutButton(
                      context,
                      onTap: () async {
                        await companyProvider.logout();

                        await searcherProvider.logout();
                        if (companyProvider.token == null &&
                            searcherProvider.token == null) {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
            // Close Button
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return Column(
      children: [
        const Divider(
          color: Colors.white,
          thickness: 1,
          indent: 20,
          endIndent: 0,
        ),
        ListTile(
          trailing: Icon(icon, color: Colors.white),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          onTap: onTap,
        ),
      ],
    );
  }

  Widget _buildWhiteButton(
    String text,
    BuildContext context, {
    bool isFullColor = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isFullColor ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: !isFullColor
              ? Border.all(
                  color: isFullColor ? Colors.transparent : Colors.white,
                  width: 2,
                )
              : null,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isFullColor
              ? Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.black)
              : Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, {VoidCallback? onTap}) {
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              l10n.signout,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(width: 8),
            const Icon(Icons.power_settings_new,
                color: Color.fromARGB(255, 255, 255, 255)),
          ],
        ),
      ),
    );
  }
  Widget _buildLanguageSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();

    return ListTile(
      trailing: const Icon(Icons.language, color: Colors.white),
      title: Text(
        l10n.language,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      leading: DropdownButton<String>(
        value: localeProvider.locale?.languageCode,
        items: const [
          DropdownMenuItem(
            value: 'en',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'ar',
            child: Text('العربية'),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            localeProvider.setLocale(Locale(value));
            log(value);
          }
        },
      ),
    );
  }
}
