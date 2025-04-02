// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jop_project/Controller/Firebase_Services/send_notification_service.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Models/job_advertisement_model.dart';
import 'package:jop_project/Models/orders_model.dart';
import 'package:jop_project/Providers/Orders/order_provider.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/Providers/locale_provider.dart';
import 'package:jop_project/Screens/JopScreen/Profile/cv_screen.dart';
import 'package:jop_project/Screens/ShareScreen/Login/login_screen.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';
import 'package:jop_project/size_config.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class JopInfoScreen extends StatelessWidget {
  final JobAdvertisementModel jobData;
  final CompanyModel companyData;
  final OrdersModel? orderData;

  const JopInfoScreen({
    super.key,
    required this.jobData,
    required this.companyData,
    this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Background(
      height: SizeConfig.screenH! / 4.5,
      isCompany: false,
      showListNotiv: true,
      title: l10n.aboutjob,
      child: Center(
        child: SingleChildScrollView(
          child: Responsive(
            mobile: MobileHomeJopInfoScreen(
                jobData: jobData,
                companyData: companyData,
                orderData: orderData),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Center(
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
                              companyData.img ?? '',
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(loadingProgress.expectedTotalBytes !=
                                            null
                                        ? (loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!)
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
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        color: const Color(0xFF6B8CC7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              companyData.nameCompany.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              jobData.location.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 90, 90, 90),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InfoBodyWidget(
                      companyData: companyData,
                      jobData: jobData,
                      orderData: orderData,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MobileHomeJopInfoScreen extends StatelessWidget {
  final JobAdvertisementModel jobData;
  final CompanyModel companyData;
  final OrdersModel? orderData;

  const MobileHomeJopInfoScreen({
    super.key,
    required this.jobData,
    required this.companyData,
    this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: SizeConfig.screenW! / 1.2,
              child: CardMainInfoWidget(
                  jobData: jobData, companyData: companyData),
            ),
          ),
          const SizedBox(height: 16),
          InfoBodyWidget(
              jobData: jobData, orderData: orderData, companyData: companyData),
        ],
      ),
    );
  }
}

class InfoBodyWidget extends StatelessWidget {
  final CompanyModel companyData;
  final JobAdvertisementModel jobData;
  final OrdersModel? orderData;

  const InfoBodyWidget({
    super.key,
    required this.jobData,
    this.orderData,
    required this.companyData,
  });

  @override
  Widget build(BuildContext context) {
    final searcherProvider = Provider.of<SearcherSigninLoginProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final isBooking = orderProvider.orders
        .where(
          (element) =>
              element.jobAdvertisementId == jobData.id &&
              element.searcherId == searcherProvider.currentSearcher!.id,
        )
        .isNotEmpty;
    final accept = orderProvider.orders
        .where(
          (element) =>
              element.jobAdvertisementId == jobData.id &&
              element.searcherId == searcherProvider.currentSearcher!.id &&
              element.accept == 1,
        )
        .isNotEmpty;
    final unAccept = orderProvider.orders
        .where(
          (element) =>
              element.jobAdvertisementId == jobData.id &&
              element.searcherId == searcherProvider.currentSearcher!.id &&
              element.unAccept == 1,
        )
        .isNotEmpty;
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          l10n.jobinformation,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B8CC7),
          ),
        ),
        const Divider(
          color: Color(0xFF6B8CC7),
        ),
        RectanglText(description: jobData.descrip.toString()),
        const SizedBox(height: 16),
        _buildInfoItem(Icons.work, l10n.nameinformation,
            jobData.nameJob.toString(), context),
        _buildInfoItem(Icons.work, l10n.locationaddress,
            jobData.location.toString(), context),
        _buildInfoItem(Icons.school, l10n.academicqualifications,
            jobData.special.toString(), context),
        _buildInfoItem(Icons.school, l10n.experiences,
            jobData.periodExper.toString(), context),
        _buildInfoItem(Icons.access_time, l10n.typework,
            jobData.permanenceType.toString(), context),
        _buildInfoItem(Icons.location_on, l10n.area,
            jobData.typeOfPlace.toString(), context),
        _buildInfoItem(Icons.calendar_today, l10n.applperiod,
            jobData.timeWork.toString(), context),
        _buildInfoItem(
            Icons.attach_money, l10n.salary, jobData.salry.toString(), context),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: orderData == null
              ? !isBooking
                  ? ElevatedButton(
                      onPressed: () async {
                        if (searcherProvider.currentSearcher!.id == null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        } else if (searcherProvider.currentSearcher!.cv !=
                            null) {
                          log(jobData.companyId.toString(), name: 'job');
                          await orderProvider.addOrders(
                            jobData: jobData,
                            ordersModel: OrdersModel(
                              id: 0,
                              numberPresent: 0,
                              jobAdvertisementId: jobData.id,
                              searcherId: searcherProvider.currentSearcher!.id,
                              presentData: intl.DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now()),
                              receptData: intl.DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now()),
                              statuse: 1,
                              accept: 0,
                              unAccept: 0,
                              time: intl.DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now()),
                            ),
                          );
                          await SendNotificationsService
                              .sendNotificationForSingleUserUsingApi(
                                  token:
                                      companyData.tokenNotification.toString(),
                                  title: l10n.havemessage,
                                  body: "مقدم جديد للوظيفة ${jobData.nameJob}",
                                  data: {
                                "screen": 'OrderScreen',
                                "userType": 'Admin',
                                "userId": jobData.companyId
                              });
                          await SendNotificationsService
                              .sendNotificationForSingleUserUsingApi(
                                  token: searcherProvider
                                      .currentSearcher!.tokenNotification,
                                  title: l10n.havemessage,
                                  body:
                                      "تم التقديم الى وظيفة ${jobData.nameJob}",
                                  data: {
                                "screen": 'OrderScreen',
                                "userType": 'Searcher',
                                "userId": searcherProvider.currentSearcher!.id
                              });
                          if (orderProvider.error == null) {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          }
                        } else if (searcherProvider.currentSearcher!.cv ==
                            null) {
                          Get.showOverlay(
                            asyncFunction: () async {
                              await Future.delayed(const Duration(seconds: 2));
                              // Get.back();
                            },
                            loadingWidget: Center(
                              child: Material(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(l10n.createcv),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(l10n.cancel)),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CVScreen(),
                                                  ));
                                            },
                                            child: Text(l10n.create)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B3B77),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: orderProvider.isLoading
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.language, color: Colors.white),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.applyjob,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                    )
                  : InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (contextShowDialog) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  backgroundColor: Colors.grey,
                                  title: Text(
                                    l10n.submissionstatus,
                                    style: const TextStyle(
                                        fontSize: 26, color: Colors.white),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          accept
                                              ? l10n.acceptedjob
                                              : unAccept
                                                  ? l10n.notacceptedjob
                                                  : l10n.waiting,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: accept
                                                  ? const Color.fromARGB(
                                                      255, 1, 149, 68)
                                                  : unAccept
                                                      ? Colors.red
                                                      : const Color.fromARGB(
                                                          255, 250, 189, 8)),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(contextShowDialog);
                                          },
                                          child: Text(l10n.back))
                                    ],
                                  ),
                                )));
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 2,
                          color: const Color.fromARGB(255, 1, 149, 68),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                l10n.submitted,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
              : SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    color: const Color.fromARGB(255, 1, 149, 68),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          l10n.submitted,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
      IconData icon, String title, String value, BuildContext context) {
    return Directionality(
      textDirection: context.read<LocaleProvider>().locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF6B8CC7),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                child: Text(
                  value,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  border: Border.all(color: kBorderColor)),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                title,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: kBorderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6B8CC7),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RectanglText extends StatelessWidget {
  final String description;

  const RectanglText({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B8CC7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  l10n.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardMainInfoWidget extends StatelessWidget {
  final JobAdvertisementModel jobData;
  final CompanyModel companyData;

  const CardMainInfoWidget({
    super.key,
    required this.jobData,
    required this.companyData,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Flexible(
                child: Center(
                  child: Container(
                    // width: 100,
                    // height: 100,
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
                        companyData.img ?? '',
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
                              // const CircularProgressIndicator(),
                            ],
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
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
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyData.nameCompany.toString(),
                      style: const TextStyle(
                        color: kBorderColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      jobData.location.toString(),
                      style: const TextStyle(
                        color: kBorderColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
