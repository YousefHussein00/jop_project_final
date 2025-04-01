import 'package:flutter/material.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Providers/Companies/companies_provider.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class CompanyInfoBySeasherScreen extends StatelessWidget {
  final bool isCompany;
  final CompanyModel company;

  const CompanyInfoBySeasherScreen({
    super.key,
    required this.isCompany,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Background(
      height: SizeConfig.screenH! / 4.5,
      isCompany: true,
      userImage: company.img ?? '',
      userName: company.nameCompany,
      showListNotiv: true,
      title: l10n.companyinformation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<CompaniesProvider>(
            builder: (context, companiesProvider, child) {
          final companyById = companiesProvider.getCompanyById(company.id!);
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
                    companyById?.img ?? '',
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
                _buildInfoRow(l10n.ompanyName, companyById?.nameCompany ?? ''),
                _buildInfoRow(l10n.special, companyById?.special ?? ''),
                _buildInfoRow(l10n.locationaddress, companyById!.location!),
                _buildInfoRow(l10n.branch, companyById.special.toString()),
                _buildInfoRow(l10n.phone, companyById.phone ?? ''),
                _buildInfoRow(l10n.gmail, companyById.email ?? ''),
                _buildInfoRow(l10n.description, companyById.desc.toString()),
                _buildInfoRow(l10n.companyType, companyById.typeCompany ?? ''),
              ]),
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
