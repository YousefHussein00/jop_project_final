import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jop_project/Providers/locale_provider.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/size_config.dart';
import 'package:provider/provider.dart';

import '../../ShareScreen/Login/login_screen.dart';
import '../../ShareScreen/Signup/signup_screen.dart';
import 'package:jop_project/l10n/l10n.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: SizeConfig.screenW! - 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
            child: Text(
              l10n.loginBtnTitle.toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 4),
        SizedBox(
          width: SizeConfig.screenW! - 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
            child: Text(
              l10n.sinupBtnTitle.toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                dropdownColor: Colors.black,
                value: localeProvider.locale?.languageCode,
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text(
                      'En',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text(
                      'Ar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    localeProvider.setLocale(Locale(value));
                    log(value);
                  }
                },
              ),
              Container(
                width: 1,
                height: SizeConfig.screenW! * 0.1,
                color: Colors.white,
              ),
              Text(
                "   ${l10n.language}".toUpperCase(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
