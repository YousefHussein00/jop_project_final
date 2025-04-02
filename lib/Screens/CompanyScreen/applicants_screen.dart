// import 'dart:developer';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jop_project/Models/job_advertisement_model.dart';
import 'package:jop_project/Models/orders_model.dart';
import 'package:jop_project/Models/searcher_model.dart';
import 'package:jop_project/Providers/Orders/order_provider.dart';
import 'package:jop_project/Providers/Searchers/searchers_provider.dart';
import 'package:jop_project/Providers/SignUp/company_signin_login_provider.dart';
import 'package:jop_project/Screens/CompanyScreen/applicant_details_screen.dart';
import 'package:jop_project/Screens/ChatScreen/chat_screen.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../size_config.dart';

class ApplicantsScreen extends StatefulWidget {
  final JobAdvertisementModel? job;
  final List<SearchersModel>? searchers;
  const ApplicantsScreen({super.key, this.job, this.searchers});

  @override
  State<ApplicantsScreen> createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchersProvider>(context, listen: false).getAllSearchers();
      Provider.of<OrderProvider>(context, listen: false).getOrdersByCompanyId(
          companyId:
              context.read<CompanySigninLoginProvider>().currentCompany!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final searchersProvider = Provider.of<SearchersProvider>(context);
    final companySigninLoginProvider =
        Provider.of<CompanySigninLoginProvider>(context);
    // final orders = Provider.of<OrderProvider>(context);

    final l10n = AppLocalizations.of(context);

    // final order = widget.job != null
    //     ? orders.orders
    //         .where((element) => element.jobAdvertisementId == widget.job?.id)
    //         .toList()
    //     : orders.orders;
    // log(widget.job!.orders!.length.toString(), name: "order");
    // final searcher = widget.job != null
    //     ? searchersProvider.searchers
    //         .where((element) => widget.job!.orders!
    //             .where((order) =>
    //                 order.searcherId == element.id &&
    //                 order.jobAdvertisementId == widget.job?.id)
    //             .isNotEmpty)
    //         .toList()
    //     : searchersProvider.searchers
    //         .where((element) => widget.job!.orders!
    //             .where((order) => order.searcherId == element.id)
    //             .isNotEmpty)
    //         .toList();
    // log(widget.job!.orders!.length.toString(), name: "searcher");

    return Background(
      height: SizeConfig.screenH! / 4.5,
      isCompany: true,
      showListNotiv: true,
      userImage: companySigninLoginProvider.currentCompany?.img,
      userName: companySigninLoginProvider.currentCompany?.nameCompany,
      title: l10n.jobapplicants,
      child: Responsive(
        mobile: Stack(
          children: [
            ApplicantsList(
              // searchers: searcher,
              job: widget.job,
              orderCount: widget.job != null
                  ? (widget.job!.orders as List<OrdersModel>)
                  : context.read<OrderProvider>().ordersByCompany,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  tooltip: l10n.toupdate,
                  onPressed: () {
                    context.read<OrderProvider>().getOrdersByCompanyId(
                        companyId:
                            companySigninLoginProvider.currentCompany!.id!);
                    // searchersProvider.getAllSearchers();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: ApplicantsList(
                // searchers: searcher,
                job: widget.job,
                orderCount: context.watch<OrderProvider>().ordersByCompany,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicantsList extends StatelessWidget {
  final JobAdvertisementModel? job;
  // final List<SearchersModel>? searchers;
  final List<OrdersModel> orderCount;
  final bool? accept;

  const ApplicantsList({
    super.key,
    // this.searchers,
    this.job,
    required this.orderCount,
    this.accept,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 20;
    log("${orderCount.length}");
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
              flex: 6,
              child: TextField(
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  // filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: l10n.jobapplicants,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 72, 131),
                  borderRadius: BorderRadius.circular(7)),
              child: const Icon(
                Icons.list,
                color: Colors.white,
                size: defaultPadding * 2 + 5,
              ),
            ),
          ],
        ),
        Expanded(
          child: context.read<OrderProvider>().isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : orderCount.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(defaultPadding),
                      itemCount: orderCount.length,
                      itemBuilder: (context, index) {
                        if (orderCount[index].searcher != null) {
                          final searcher = orderCount[index].searcher;
                          final countOrder = accept == null
                              ? orderCount
                                  .where(
                                    (element) =>
                                        element.searcherId == searcher?.id,
                                  )
                                  .length
                              : accept == true
                                  ? orderCount
                                      .where(
                                        (element) =>
                                            element.searcherId ==
                                                searcher?.id &&
                                            element.accept == 1,
                                      )
                                      .length
                                  : orderCount
                                      .where(
                                        (element) =>
                                            element.searcherId ==
                                                searcher?.id &&
                                            element.unAccept == 1,
                                      )
                                      .length;
                          return Card(
                            margin:
                                const EdgeInsets.only(bottom: defaultPadding),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 247, 247, 247),
                                  leading: Container(
                                    // width: 50,
                                    // height: 50,
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
                                        searcher?.img ?? '',
                                        fit: BoxFit.contain,
                                        filterQuality: FilterQuality.high,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }

                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? (loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!)
                                                      .toStringAsFixed(2)
                                                  : ''),
                                              // const CircularProgressIndicator(),
                                            ],
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.person,
                                            size: 40,
                                          );
                                        },
                                      ),
                                      // : const Icon(
                                      //     Icons.person,
                                      //     size: 50,
                                      //   ),
                                    ),
                                  ),
                                  title: Text(
                                    '${searcher?.fullName}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: kPrimaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.integration_instructions_outlined,
                                        color: Colors.red,
                                        size: size,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(2),
                                        width: 1,
                                        height: defaultPadding * 0.8,
                                        color: Colors.black,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                searchersModel: searcher,
                                                chatId:
                                                    '${searcher?.id}_${Provider.of<CompanySigninLoginProvider>(context).currentCompany?.id}',
                                                readerId: context
                                                    .read<
                                                        CompanySigninLoginProvider>()
                                                    .currentCompany!
                                                    .id
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.chat_rounded,
                                          color: kPrimaryLightColor,
                                          size: size,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          try {
                                            // تحقق مما إذا كان الجهاز محمولاً أم لا
                                            if (Platform.isAndroid ||
                                                Platform.isIOS) {
                                              var state =
                                                  await Permission.phone.status;
                                              if (!state.isGranted) {
                                                state = await Permission.phone
                                                    .request();
                                                if (!state.isGranted) {
                                                  throw 'لا يمكن إجراء المكالمة';
                                                }
                                              }
                                              // رقم الهاتف - يمكنك تغييره حسب احتياجك
                                              final Uri phoneUri = Uri(
                                                scheme: 'tel',
                                                path: searcher?.phone ??
                                                    '', // ضع رقم الهاتف هنا
                                              );
                                              // if (await canLaunchUrl(phoneUri)) {
                                              await launchUrl(phoneUri);
                                              // } else {
                                              //   throw 'Could not launch phone call';
                                              // }
                                            } else {
                                              // في حالة سطح المكتب
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'معلومات الاتصال'),
                                                    content: Text(
                                                        '${l10n.phone} ${searcher?.phone}'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            Text(l10n.cancel),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          } catch (e) {
                                            Get.snackbar(
                                              'خطأ',
                                              'لا يمكن إجراء المكالمة',
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          }
                                        },
                                        child: const Icon(
                                          Icons.phone,
                                          color: kPrimaryLightColor,
                                          size: size,
                                        ),
                                      ),
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.report,
                                            color: kPrimaryLightColor,
                                            size: size,
                                          ),
                                          Text(
                                            '3s ago',
                                            style: TextStyle(
                                              color: kPrimaryLightColor,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: CircleAvatar(
                                    backgroundColor: kJobCirclarTextColor,
                                    radius: 10,
                                    child: Text(
                                      '$countOrder',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ApplicantDetailsScreen(
                                          job: job,
                                          searcher: orderCount[index].searcher!,
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          );
                        } else {
                          if (index == 0) {
                            return const Center(
                              child: Text('تاكد من الاتصال من الانترنت'),
                            );
                          } else {
                            return Container();
                          }
                        }
                      },
                    )
                  : const Center(
                      child: Text('لا توجد بيانات'),
                    ),
        ),
      ],
    );
  }
}
