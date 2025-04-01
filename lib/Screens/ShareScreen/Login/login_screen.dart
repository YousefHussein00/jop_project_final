import 'package:flutter/material.dart';
import 'package:jop_project/Screens/Welcome/components/welcome_image.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';

import '../../../components/background.dart';
import '../../../size_config.dart';
import 'components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Background(
          height: SizeConfig.screenH! / 4.5,
          title: l10n.loginBtnTitle,
          child: const Center(
            child: Responsive(
              mobile: MobileLoginScreen(),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: WelcomeImage(
                      // imageHeight: 300,
                      imageSrc: 'assets/images/login.png',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: LoginForm(),
                        ),
                        SizedBox(height: defaultPadding / 2),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          WelcomeImage(
            // imageHeight: 150,
            imageSrc: 'assets/images/login.png',
          ),
          // LoginForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Expanded(
                flex: 14,
                child: LoginForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
