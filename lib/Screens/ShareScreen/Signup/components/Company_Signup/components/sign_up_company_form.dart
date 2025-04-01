import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Providers/SignUp/company_signin_login_provider.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:provider/provider.dart';
import '../../../../../../components/already_have_an_account_acheck.dart';
import '../../../../../../constants.dart';
import '../../../../Login/login_screen.dart';
import 'package:jop_project/Providers/Countries/country_provider.dart';
import 'package:jop_project/Models/country_model.dart';

class SignUpCompanyForm extends StatefulWidget {
  final bool isUpdateData;
  final CompanyModel? companyModel;
  const SignUpCompanyForm(
      {super.key, required this.isUpdateData, this.companyModel});

  @override
  State<SignUpCompanyForm> createState() => _SignUpCompanyFormState();
}

class _SignUpCompanyFormState extends State<SignUpCompanyForm> {
  File? _imageFile;
  final nameCompanyController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final specializationController = TextEditingController();
  final locationController = TextEditingController();
  final phoneOneController = TextEditingController();
  final phoneTowController = TextEditingController();
  final descController = TextEditingController();
  final sectionController = TextEditingController();
  String companyType = '';
  final TextEditingController _imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  CountryModel? selectedCountry;
  List<CountryModel> countries = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CountryProvider>(context, listen: false).fetchCountries();
    });
    if (widget.isUpdateData == true && widget.companyModel != null) {
      final company = widget.companyModel;
      _imageFile = company!.img != null ? File(company.img!) : null;
      nameCompanyController.text = company.nameCompany ?? '';
      emailController.text = company.email ?? '';
      passwordController.text = company.pass ?? '';
      specializationController.text = company.special ?? '';
      locationController.text = company.location ?? '';
      phoneOneController.text = company.phone ?? '';
      phoneTowController.text = company.phone2 ?? '';
      companyType = company.typeCompany ?? '';
      descController.text = company.desc ?? '';
      sectionController.text = company.section ?? '';
    }
  }

  Future<void> _selectImage() async {
    final l10n = AppLocalizations.of(context);
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
          _imageController.text = image.path.split('/').last;
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.image)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final companyProvider = Provider.of<CompanySigninLoginProvider>(context);
    // final countryProvider = Provider.of<CountryProvider>(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  // color: kPrimaryLightColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor, width: 2),
                ),
                child: _imageFile != null
                    ? Container(
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
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            // loadingBuilder: (context, child, loadingProgress) {
                            //   if (loadingProgress == null) return child;
                            //   return Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Text(loadingProgress.expectedTotalBytes !=
                            //               null
                            //           ? (loadingProgress.cumulativeBytesLoaded /
                            //                   loadingProgress
                            //                       .expectedTotalBytes!)
                            //               .toStringAsFixed(2)
                            //           : ''),
                            //       // const CircularProgressIndicator(),
                            //     ],
                            //   );
                            // },

                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.business,
                                  size: 50,
                                ),
                              );
                            },
                          ),
                          // : const Icon(
                          //     Icons.person,
                          //     size: 50,
                          //   ),
                        ),
                      )
                    : const Icon(
                        Icons.business,
                        size: 60,
                        color: kPrimaryColor,
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _selectImage,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: nameCompanyController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2.0),
              ),
              hintText: l10n.ompanyName,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.apartment_outlined, color: kBorderColor),
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
                  child: Icon(Icons.email, color: kBorderColor),
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
          if (widget.isUpdateData == true && widget.companyModel != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: descController,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.text,
                // maxLength: 5,
                maxLines: 5,
                minLines: 2,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (email) {},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: kBorderColor, width: 2.0),
                  ),
                  hintText: 'الوصف',
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.description, color: kBorderColor),
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
          ],
          TextFormField(
            controller: passwordController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            textInputAction: TextInputAction.done,
            obscureText: obscureText,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2),
              ),
              hintText: l10n.password,
              prefixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon:
                    Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              ),
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock, color: kBorderColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: specializationController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (typeCompany) {},
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2.0),
              ),
              hintText: l10n.special,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.apartment_outlined, color: kBorderColor),
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
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              onSaved: (location) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: kBorderColor, width: 2),
                ),
                hintText: l10n.locationcompany,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_on, color: kBorderColor),
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
            controller: phoneOneController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (phone1) {},
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2.0),
              ),
              hintText: l10n.phoneOne,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone_callback, color: kBorderColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: phoneTowController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (phone2) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.field;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: kBorderColor, width: 2.0),
              ),
              hintText: l10n.phoneTow,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone_callback, color: kBorderColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: sectionController,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              textInputAction: TextInputAction.done,
              maxLines: 5,
              minLines: 2,
              cursorColor: kPrimaryColor,
              onSaved: (location) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: kBorderColor, width: 2),
                ),
                hintText: l10n.ksection,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_on, color: kBorderColor),
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
                    l10n.companyType,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioListTile(
                        title: Text(l10n.especiallyTitle),
                        value: l10n.especiallyTitle,
                        groupValue: companyType,
                        onChanged: (value) {
                          setState(() {
                            companyType = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text(l10n.governmental),
                        value: l10n.governmental,
                        groupValue: companyType,
                        onChanged: (value) {
                          setState(() {
                            companyType = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Consumer<CountryProvider>(builder: (context, countryProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: countryProvider.isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<CountryModel>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        isExpanded: true,
                        hint: Text(l10n.selectcountry),
                        value: selectedCountry,
                        items: countryProvider.countries.map((country) {
                          return DropdownMenuItem<CountryModel>(
                            value: country,
                            child: Text(country.name),
                          );
                        }).toList(),
                        onChanged: (CountryModel? newValue) {
                          setState(() {
                            selectedCountry = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return l10n.selectcountryplaes;
                          }
                          return null;
                        },
                      ),
                    ),
            );
          }),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate() &&
                  selectedCountry != null &&
                  (companyType.isNotEmpty || companyType != '')) {
                if (widget.isUpdateData == true &&
                    widget.companyModel != null) {
                  try {
                    if (!companyProvider.isLoading) {
                      await showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ).timeout(
                        const Duration(seconds: 3),
                        onTimeout: () async {
                          final company = CompanyModel(
                            id: widget.companyModel!.id,
                            desc: descController.text,
                            section: null,
                            nameCompany: nameCompanyController.text,
                            email: emailController.text,
                            pass: passwordController.text,
                            special: specializationController.text,
                            location: locationController.text,
                            phone: phoneOneController.text,
                            phone2: phoneTowController.text,
                            typeCompany: companyType,
                            img: _imageFile?.path,
                            countryId: selectedCountry!.id,
                          );

                          await companyProvider.updateCompanyProfile(
                            companyModel: company,
                          );
                          if (!companyProvider.isLoading) {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          }
                          if (companyProvider.error == null) {
                            Get.snackbar(l10n.update, '',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.check_circle),
                                margin: const EdgeInsets.all(10),
                                snackPosition: SnackPosition.BOTTOM);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const LoginScreen(),
                            //   ),
                            //   (route) => false,
                            // );
                          }
                        },
                      );
                    }

                    if (!context.mounted) return;
                  } catch (e) {
                    // تم معالجة الخطأ في Provider
                  }
                } else {
                  try {
                    if (!companyProvider.isLoading) {
                      await showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ).timeout(
                        const Duration(seconds: 3),
                        onTimeout: () async {
                          final company = CompanyModel(
                            id: 0,
                            desc: null,
                            section: null,
                            nameCompany: nameCompanyController.text,
                            email: emailController.text,
                            pass: passwordController.text,
                            special: specializationController.text,
                            location: locationController.text,
                            phone: phoneOneController.text,
                            phone2: phoneTowController.text,
                            typeCompany: companyType,
                            img: _imageFile?.path,
                            countryId: selectedCountry!.id,
                          );

                          await companyProvider.registerCompany(
                            companyModel: company,
                          );
                          if (!companyProvider.isLoading) {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          }
                          if (companyProvider.error == null) {
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

                    if (!context.mounted) return;
                  } catch (e) {
                    // تم معالجة الخطأ في Provider
                  }
                }
              }
            },
            child: companyProvider.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Text(
                    (widget.isUpdateData == true && widget.companyModel != null)
                        ? l10n.update.toUpperCase()
                        : l10n.registration.toUpperCase()),
          ),
          if (companyProvider.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                l10n.emailorpassworderror,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: defaultPadding),
          if (!(widget.isUpdateData == true &&
              widget.companyModel != null)) ...[
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
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }
}
