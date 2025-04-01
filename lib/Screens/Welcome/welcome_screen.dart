import 'package:flutter/material.dart';
import 'package:jop_project/Controller/Firebase_Services/fcm_service.dart';
import 'package:jop_project/Controller/Firebase_Services/notifications_service.dart';
import 'package:jop_project/constants.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import '../../size_config.dart';
import 'components/login_signup_btn.dart';
import 'components/welcome_image.dart';
import 'package:jop_project/l10n/l10n.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  NotificationsService notificationsService = NotificationsService();

  @override
  void initState() {
    super.initState();
    notificationsService.requestNotificationPermission();
    notificationsService.getDeviceToken();
    notificationsService.firebaseInit(context);
    notificationsService.setupInteractMessage(context);
    FcmService.firebaseInit();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Background(
      height: SizeConfig.screenH! / 4.5,
      title: l10n.welcomeTitle,
      child: const SafeArea(
        top: false,
        bottom: false,
        child: Responsive(
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: WelcomeImage(imageSrc: 'assets/images/GroupLogo.png'),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginAndSignupBtn(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          mobile: MobileWelcomeScreen(),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WelcomeImage(imageSrc: 'assets/images/GroupLogo.png'),
        Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: LoginAndSignupBtn(),
        ),
      ],
    );
  }
}
