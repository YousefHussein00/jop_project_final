import 'package:flutter/material.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';

import '../../../size_config.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      height: SizeConfig.screenH! / 4.5,
      title: "استعادة كلمة المرور",
      child: Responsive(
        mobile: const ForgotPasswordForm(),
        desktop: Row(
          children: [
            Expanded(
              child: Container(),
            ),
            const Expanded(
              child: ForgotPasswordForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "أدخل بريدك الإلكتروني لاستعادة كلمة المرور",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding * 2),
            TextFormField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: kBorderColor, width: 2.0),
                ),
                hintText: l10n.gmail,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            ElevatedButton(
              onPressed: () {
                // هنا يمكنك إضافة منطق إرسال رابط إعادة تعيين كلمة المرور
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني'),
                  ),
                );
              },
              child: Text("إرسال".toUpperCase()),
            ),
            const SizedBox(height: defaultPadding),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "العودة لتسجيل الدخول",
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
