import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jop_project/Models/searcher_model.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:provider/provider.dart';
import '../../../../../../components/already_have_an_account_acheck.dart';
import '../../../../../../constants.dart';
import '../../../../Login/login_screen.dart';

class SignUpJobForm extends StatefulWidget {
  const SignUpJobForm({
    super.key,
  });

  @override
  State<SignUpJobForm> createState() => _SignUpJobFormState();
}

class _SignUpJobFormState extends State<SignUpJobForm> {
  final formKey = GlobalKey<FormState>();
  final nameCompanyController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();
  final specialController = TextEditingController();
  final educationLevelController = TextEditingController();
  final phoneController = TextEditingController();
  final bDateController = TextEditingController();

  String gendr = '';
  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final searcherProvider = Provider.of<SearcherSigninLoginProvider>(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameCompanyController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: l10n.fullname,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person, color: kBorderColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: locationController,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: kBorderColor, width: 2.0),
                ),
                hintText: l10n.locationhome,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_on_outlined, color: kBorderColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.field;
                }
                return null;
              },
            ),
          ),
          TextFormField(
            controller: ageController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2.0),
              ),
              hintText: l10n.age,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.numbers, color: kBorderColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: specialController,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: kBorderColor, width: 2.0),
                ),
                hintText: l10n.special,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.school_outlined, color: kBorderColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.special;
                }
                return null;
              },
            ),
          ),
          TextFormField(
            controller: educationLevelController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            textInputAction: TextInputAction.done,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2),
              ),
              hintText: l10n.educationLevel,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.leaderboard_outlined, color: kBorderColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: phoneController,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: kBorderColor, width: 2.0),
                ),
                hintText: l10n.phone,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.school_outlined, color: kBorderColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.field;
                }
                return null;
              },
            ),
          ),
          TextFormField(
            controller: bDateController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            cursorColor: kPrimaryColor,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: kPrimaryColor,
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                String formattedDate =
                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                setState(() {
                  bDateController.text = formattedDate;
                });
              }
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2),
              ),
              hintText: l10n.datebirth,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.calendar_today, color: kBorderColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: emailController,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: kBorderColor, width: 2.0),
                ),
                hintText: l10n.gmail,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.attach_email_outlined, color: kBorderColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.field;
                }
                return null;
              },
            ),
          ),
          TextFormField(
            controller: passwordController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            textInputAction: TextInputAction.done,
            obscureText: isShowPassword,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: kBorderColor, width: 2),
                ),
                hintText: l10n.password,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock, color: kBorderColor),
                ),
                prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    icon: Icon(isShowPassword
                        ? Icons.visibility
                        : Icons.visibility_off))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding * 2),
          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.type,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioListTile(
                        title: Text(l10n.man),
                        value: l10n.man,
                        groupValue: gendr,
                        onChanged: (value) {
                          setState(() {
                            gendr = value!;
                          });
                          log(value.toString());
                        },
                      ),
                      RadioListTile(
                        title: Text(l10n.woman),
                        value: l10n.woman,
                        groupValue: gendr,
                        onChanged: (value) {
                          setState(() {
                            gendr = value!;
                          });
                          log(value.toString());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate() &&
                  (gendr.isNotEmpty || gendr != '')) {
                if (!searcherProvider.isLoading) {
                  await showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ).timeout(
                    const Duration(seconds: 3),
                    onTimeout: () async {
                      final searcher = SearchersModel(
                        id: 0,
                        fullName: nameCompanyController.text,
                        email: emailController.text,
                        pass: passwordController.text,
                        gendr: gendr,
                        age: ageController.text,
                        bDate: bDateController.text,
                        location: locationController.text,
                        phone: phoneController.text,
                        special: specialController.text,
                        educationLevel: educationLevelController.text,
                        cv: null,
                        img: null,
                        sta: null,
                        typeWorkHours: null,
                        userId: null,
                      );
                      await searcherProvider.registerSearcher(
                          searchersModel: searcher);
                      if (!searcherProvider.isLoading) {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      }
                      if (searcherProvider.error == null) {
                        Get.snackbar(l10n.register, '',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 3),
                            icon: const Icon(Icons.check_circle),
                            margin: const EdgeInsets.all(10),
                            snackPosition: SnackPosition.BOTTOM);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  );
                }
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const EmailVerifyScreen(),
                //     ));
              }
            },
            child: searcherProvider.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Text(l10n.registration.toUpperCase()),
          ),
          if (searcherProvider.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                l10n.emailorpassworderror,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}
