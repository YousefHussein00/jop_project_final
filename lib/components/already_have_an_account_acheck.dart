import 'package:flutter/material.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Expanded(
          //   child: Text(
          //     login ? "لا امتلك حساب ؟ " : "لدي حساب بالفعل ؟ ",
          //     textDirection: TextDirection.rtl,
          //     style: const TextStyle(color: kPrimaryColor),
          //   ),
          // ),
          GestureDetector(
            onTap: press as void Function()?,
            child: Text(
              login ? l10n.sinupBtnTitle : l10n.loginBtnTitle,
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
