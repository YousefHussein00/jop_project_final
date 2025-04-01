import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jop_project/Providers/SignUp/company_signin_login_provider.dart';
import 'package:jop_project/Screens/ShareScreen/Signup/components/Company_Signup/components/sign_up_company_form.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class CompanyInfoScreen extends StatelessWidget {
  // final CompanyModel company;

  const CompanyInfoScreen({
    super.key,
    // required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Background(
      height: SizeConfig.screenH! / 4.5,
      isCompany: true,
      userImage: Provider.of<CompanySigninLoginProvider>(context)
              .currentCompany
              ?.img ??
          '',
      userName: Provider.of<CompanySigninLoginProvider>(context)
          .currentCompany
          ?.nameCompany,
      showListNotiv: true,
      title: l10n.companyinformation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<CompanySigninLoginProvider>(
            builder: (context, companySigninLoginProvider, child) {
          return Column(
            children: [
              Container(
                height: 100,
                width: 100,
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
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    companySigninLoginProvider.currentCompany?.img ?? '',
                    fit: BoxFit.cover,
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
                          // const CircularProgressIndicator(),
                        ],
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      );
                    },
                  ),
                  // : const Icon(
                  //     Icons.person,
                  //     size: 50,
                  //   ),
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoCard([
                _buildInfoRow(
                    l10n.ompanyName,
                    companySigninLoginProvider.currentCompany?.nameCompany ??
                        ''),
                _buildInfoRow(l10n.special,
                    companySigninLoginProvider.currentCompany?.special ?? ''),
                _buildInfoRow(l10n.locationaddress,
                    companySigninLoginProvider.currentCompany!.location!),
                _buildInfoRow(
                    l10n.branch,
                    companySigninLoginProvider.currentCompany!.special
                        .toString()),
                _buildInfoRow(l10n.phone,
                    companySigninLoginProvider.currentCompany?.phone ?? ''),
                _buildInfoRow(l10n.gmail,
                    companySigninLoginProvider.currentCompany?.email ?? ''),
                _buildInfoRow(l10n.description,
                    companySigninLoginProvider.currentCompany!.desc.toString()),
                _buildInfoRow(
                    l10n.companyType,
                    companySigninLoginProvider.currentCompany?.typeCompany ??
                        ''),
              ]),
              const SizedBox(height: 24),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B3B77),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      // تعديل معلومات الشركة
                      Get.bottomSheet(BottomSheet(
                        onClosing: () {},
                        builder: (conx) => SingleChildScrollView(
                          child: SignUpCompanyForm(
                            isUpdateData: true,
                            companyModel:
                                Provider.of<CompanySigninLoginProvider>(context)
                                    .currentCompany,
                          ),
                        ),
                      ));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const SignUpCompanyForm(),
                      //     ));
                    },
                    child: Text(l10n.editinformation),
                  )),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$label:',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
