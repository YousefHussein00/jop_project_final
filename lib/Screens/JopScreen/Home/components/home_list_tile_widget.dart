import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Providers/Caht-firebase_database/chat_provider_firebase_database.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/Screens/ChatScreen/chat_screen.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class HomeListTileWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String companyId;
  final CompanyModel companyModel;
  final String subtitle;
  final String phone;
  final void Function()? onTap;
  const HomeListTileWidget({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.phone,
    required this.companyModel,
    required this.companyId,
  });

  @override
  State<HomeListTileWidget> createState() => _HomeListTileWidgetState();
}

class _HomeListTileWidgetState extends State<HomeListTileWidget> {
  @override
  Widget build(BuildContext context) {
    const double size = 15;
    final l10n = AppLocalizations.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        onTap: widget.onTap,
        leading: Container(
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
              widget.companyModel.img ?? '',
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
        subtitle: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        title: Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                // if(widget.companyModel == null) return;
                // log(widget.companyId);
                // log(widget.companyModel.id.toString());
                // Provider.of<ChatProvider>(context, listen: false)
                //     .getChatsByCompanyId(widget.companyModel.id.toString());
                // Provider.of<ChatProvider>(context, listen: false)
                //     .getChatsByCompanyIdLignth(
                //         widget.companyModel.id.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      readerId:
                          Provider.of<SearcherSigninLoginProvider>(context)
                              .currentSearcher!
                              .id
                              .toString(),
                      companyModel: widget.companyModel,
                      // searchersModel: null,
                      chatId:
                          '${Provider.of<SearcherSigninLoginProvider>(context).currentSearcher?.id}_${widget.companyModel.id}',
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
                  if (Platform.isAndroid || Platform.isIOS) {
                    // رقم الهاتف - يمكنك تغييره حسب احتياجك
                    final Uri phoneUri = Uri(
                      scheme: 'tel',
                      path: widget.phone, // ضع رقم الهاتف هنا
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
                      builder: (BuildContext context) {
                        final l10n = AppLocalizations.of(context);
                        return AlertDialog(
                          title: Text(l10n.contactinformation),
                          content: Text('${l10n.phone} ${widget.phone}'),
                          actions: <Widget>[
                            TextButton(
                              child: Text(l10n.cancel),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                } catch (e) {
                  Get.snackbar(
                    l10n.error,
                    l10n.callnotmade,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
