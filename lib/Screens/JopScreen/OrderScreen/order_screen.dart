import 'package:flutter/material.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Models/job_advertisement_model.dart';
import 'package:jop_project/Models/orders_model.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/Screens/JopScreen/Jop_Info/jop_info_screen.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearcherSigninLoginProvider>(context, listen: false)
          .getSearcherById();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searcherProvider = Provider.of<SearcherSigninLoginProvider>(context);
    final l10n = AppLocalizations.of(context);
    return Background(
      height: SizeConfig.screenH! / 4.5,
      title: l10n.jobsappliedfor,
      isCompany: false,
      userImage: searcherProvider.currentSearcher?.img ?? '',
      userName: searcherProvider.currentSearcher?.fullName ?? '',
      showListNotiv: true,
      availableJobs: 50,
      child: Stack(
        children: [
          Responsive(
            mobile: MobileOrderScreen(searcherProvider: searcherProvider),
            desktop: MobileOrderScreen(searcherProvider: searcherProvider),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                tooltip: l10n.toupdate,
                onPressed: () {
                  // context.read<JobsProvider>().getJobs();
                  searcherProvider.getSearcherById();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileOrderScreen extends StatelessWidget {
  final SearcherSigninLoginProvider searcherProvider;
  const MobileOrderScreen({super.key, required this.searcherProvider});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Expanded(child: Consumer<SearcherSigninLoginProvider>(
              builder: (context, searcherSigninLoginProvider, child) {
            // final order = orderProvider.orders.where(
            //   (element) {
            //     return element.searcherId ==
            //         searcherProvider.currentSearcher?.id;
            //   },
            // ).toList();
            return searcherSigninLoginProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : searcherSigninLoginProvider.currentSearcher!.orders != null
                    ? ListView.builder(
                        itemCount: searcherSigninLoginProvider
                            .currentSearcher!.orders!.length,
                        itemBuilder: (context, index) {
                          // final jobProvider =
                          //     Provider.of<JobsProvider>(context);
                          // final companiesProvider =
                          //     Provider.of<CompaniesProvider>(context);
                          // final job = jobProvider.jobs.firstWhere((element) =>
                          //     element.id == order[index].jobAdvertisementId);
                          // final company = companiesProvider.companies
                          //     .firstWhere((element) =>
                          //         element.id ==
                          //         searcherSigninLoginProvider
                          //             .currentSearcher!
                          //             .orders![index]
                          //             .jobAdvertisement!
                          //             .companyId);
                          return OrderItem(
                              order: searcherSigninLoginProvider
                                  .currentSearcher!.orders![index],
                              job: searcherSigninLoginProvider.currentSearcher!
                                  .orders![index].jobAdvertisement!,
                              company: searcherSigninLoginProvider
                                  .currentSearcher!
                                  .orders![index]
                                  .jobAdvertisement!
                                  .company!);
                        },
                      )
                    : Center(
                        child: Text(
                          l10n.nodata,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
          })),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final OrdersModel order;
  final CompanyModel company;
  final JobAdvertisementModel job;
  const OrderItem(
      {super.key,
      required this.order,
      required this.company,
      required this.job});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(company.nameCompany.toString()),
          subtitle: Text(
            job.nameJob.toString(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: Text(
            order.accept.toString() == '1'
                ? 'مقبول'
                : order.unAccept.toString() == '1'
                    ? 'مرفوض'
                    : 'في الانتظار',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          leading: company.img != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(company.img.toString()),
                )
              : const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person),
                ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JopInfoScreen(
                          companyData: company,
                          jobData: job,
                          orderData: order,
                        )));
          },
        ),
      ),
    );
  }
}
