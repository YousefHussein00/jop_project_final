import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jop_project/Models/experience_model.dart';
import 'package:jop_project/Models/searcher_model.dart';
import 'package:jop_project/Models/skils_model.dart';
import 'package:jop_project/Providers/Desires/desires_provider.dart';
import 'package:jop_project/Providers/Experience/experience_provider.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/Providers/skills/skills_provider.dart';
import 'package:jop_project/Screens/JopScreen/Home/home_screen.dart';
import 'package:jop_project/Screens/JopScreen/Profile/components/background_profile.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/size_config.dart';
import 'package:jop_project/components/education_level_selector.dart';
import 'package:jop_project/components/preferences_selector.dart';
import 'package:jop_project/utils/pdf_generator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart' as intl;
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class CVSettingsScreen extends StatefulWidget {
  const CVSettingsScreen({super.key});

  @override
  State<CVSettingsScreen> createState() => _CVSettingsScreenState();
}

class _CVSettingsScreenState extends State<CVSettingsScreen> {
  late SearcherSigninLoginProvider searcherProvider;

  //
  // List<String> selectedSkills = [];
  // List<String> selectedExperiences = [];
  // List<String> selectedDesires = [];
  String selectedEducationLevel = '';
  List<String> selectedPreferences = [];

  // إضافة متغيرات للمعلومات الشخصية
  // final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController currentResidenceController =
      TextEditingController();
  final TextEditingController socialStatusController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController profileImageController = TextEditingController();
  final TextEditingController specialImageController = TextEditingController();
  //
  final TextEditingController desiresController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

  String cvPath = '';

  // Experience الخبرات
  List<ExperienceModel> experiences = [];

  // img
  File? _imageFile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      searcherProvider =
          Provider.of<SearcherSigninLoginProvider>(context, listen: false);
      ageController.text = searcherProvider.currentSearcher?.age ?? '';
      birthPlaceController.text = searcherProvider.currentSearcher?.bDate ?? '';
      fullNameController.text =
          searcherProvider.currentSearcher?.fullName ?? '';
      currentResidenceController.text =
          searcherProvider.currentSearcher?.location ?? '';
      socialStatusController.text = searcherProvider.currentSearcher?.sta ?? '';
      birthDateController.text = searcherProvider.currentSearcher?.bDate ?? '';
      profileImageController.text = searcherProvider.currentSearcher?.img ?? '';
      specialImageController.text =
          searcherProvider.currentSearcher?.special ?? '';
      selectedEducationLevel =
          searcherProvider.currentSearcher?.educationLevel ?? '';
    }
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<SearcherSigninLoginProvider>(context, listen: false);
    // });
    // initializeDateFormatting('ar', null);
  }

  // void _showSkillsDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => SkillsSelector(
  //       initialSelectedSkills: selectedSkills,
  //       onSkillsSelected: (skills) {
  //         setState(() {
  //           selectedSkills = skills;
  //         });
  //         // هنا يمكنك إضافة كود لحفظ المهارات في قاعدة البيانات
  //       },
  //     ),
  //   );
  // }

  // void _showExperiencesDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ExperiencesSelector(
  //       initialSelectedExperiences: selectedExperiences,
  //       onExperiencesSelected: (experiences) {
  //         setState(() {
  //           selectedExperiences = experiences;
  //         });
  //         // هنا يمكنك إضافة كود لحفظ الخبرات في قاعدة البيانات
  //       },
  //     ),
  //   );
  // }

  // void _showDesiresDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => DesiresSelector(
  //       initialSelectedDesires: selectedDesires,
  //       onDesiresSelected: (desires) {
  //         setState(() {
  //           selectedDesires = desires;
  //         });
  //         // هنا يمكنك إضافة كود لحفظ الرغبات في قاعدة البيانات
  //       },
  //     ),
  //   );
  // }

  void _showEducationLevelDialog() {
    showDialog(
      context: context,
      builder: (context) => EducationLevelSelector(
        initialSelectedLevel: selectedEducationLevel,
        onLevelSelected: (level) {
          setState(() {
            selectedEducationLevel = level;
          });
        },
      ),
    );
  }

  void _showPreferencesDialog() {
    showDialog(
      context: context,
      builder: (context) => PreferencesSelector(
        initialSelectedPreferences: selectedPreferences,
        onPreferencesSelected: (preferences) {
          setState(() {
            selectedPreferences = preferences;
          });
        },
      ),
    );
  }

  void _exportToPDF() async {
    await PDFGenerator.generateProfilePDF(
      name: fullNameController.text,
      dateOfBirth: birthDateController.text,
      age: ageController.text,
      gender: searcherProvider.currentSearcher?.gendr ?? '',
      location: currentResidenceController.text,
      phone: searcherProvider.currentSearcher?.phone ?? '',
      email: searcherProvider.currentSearcher?.email ?? '',
      educationLevel: selectedEducationLevel,
      specialization: specialImageController.text,
      skills: skillsController.text.split(',').map((e) => e.trim()).toList(),
      experiences: experiences.map((exp) => exp.nameExper ?? '').toList(),
      desires: desiresController.text.split(',').map((e) => e.trim()).toList(),
      preferences: selectedPreferences,
      typeWorkHours: selectedPreferences.join('، '),
      socialStatus: socialStatusController.text,
      profileImage: _imageFile,
      context: context,
      onPdfGenerated: (String path) {
        setState(() {
          cvPath = path;
          log(path, name: 'path'); // تخزين مسار الملف عند إنشائه
        }); // تخزين مسار الملف عند إنشائه
      },
      onExportPDF: () async {
        await newMethod(context).then(
          (value) async {
            await showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) => Container(
                      color: const Color.fromARGB(83, 255, 255, 255),
                      width: SizeConfig.screenW,
                      height: SizeConfig.screenH,
                      child: Center(
                          child: Image.asset(
                        'assets/images/sucssing.png',
                        width: 250,
                        height: 250,
                      )),
                    )).timeout(
              const Duration(seconds: 3),
              onTimeout: () {
                // // ignore: use_build_context_synchronously
                // if (Navigator.canPop(context)) {
                //   // ignore: use_build_context_synchronously
                //   Navigator.pop(context);
                // }
                // // if (Navigator.canPop(context)) {
                // // ignore: use_build_context_synchronously
                // Navigator.pop(context);
                // }
                Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomeScreen()),
                  (route) => false,
                );
              },
            );
          },
        ).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('حدث خطأ ما، حاول مجدداً'),
            ),
          );
          Navigator.pop(context);
        });
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      // locale: const Locale('ar', 'SA'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // textDirection: TextDirection.rtl,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontFamily: 'Cairo'),
              bodyMedium: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        final dateFormat = intl.DateFormat('yyyy/MM/dd', 'ar');
        birthDateController.text = dateFormat.format(picked);
      });
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
          profileImageController.text = image.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ في اختيار الصورة')),
      );
    }
  }

  void _showSocialStatusDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر الحالة الاجتماعية'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('عازب'),
                onTap: () {
                  setState(() {
                    socialStatusController.text = 'عازب';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('متزوج'),
                onTap: () {
                  setState(() {
                    socialStatusController.text = 'متزوج';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('مطلق'),
                onTap: () {
                  setState(() {
                    socialStatusController.text = 'مطلق';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('ارمل'),
                onTap: () {
                  setState(() {
                    socialStatusController.text = 'ارمل';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // تنظيف الcontrollers
    // nameController.dispose();
    ageController.dispose();
    birthPlaceController.dispose();
    fullNameController.dispose();
    currentResidenceController.dispose();
    socialStatusController.dispose();
    birthDateController.dispose();
    profileImageController.dispose();
    specialImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BackgroundProfile(
      onSave: null,
      isButtom: true,
      title: l10n.personaldata,
      isProfileImage: true,
      imageSrc: searcherProvider.currentSearcher?.img,
      actions: [
        IconButton(
          icon: const Icon(Icons.picture_as_pdf),
          onPressed: _exportToPDF,
          tooltip: 'تصدير PDF',
        ),
      ],
      onExportPDF: _exportToPDF,
      child: body(context),
    );
  }

  Future<void> newMethod(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => Container(
        color: const Color.fromARGB(83, 255, 255, 255),
        width: SizeConfig.screenW,
        height: SizeConfig.screenH,
        child: const Center(child: CircularProgressIndicator()),
      ),
    ).timeout(
      const Duration(seconds: 1),
      onTimeout: () async {
        final String typeWorkHours = selectedPreferences.join('، ');
        final searcher = SearchersModel(
          age: ageController.text,
          bDate: birthPlaceController.text,
          cv: cvPath, // استخدام مسار الملف المخزن
          educationLevel: selectedEducationLevel,
          email: searcherProvider.currentSearcher!.email,
          fullName: fullNameController.text,
          gendr: searcherProvider.currentSearcher!.gendr,
          id: searcherProvider.currentSearcher!.id,
          img: profileImageController.text,
          location: currentResidenceController.text,
          pass: searcherProvider.currentSearcher!.pass,
          phone: searcherProvider.currentSearcher!.phone,
          special: specialImageController.text,
          sta: socialStatusController.text,
          typeWorkHours: typeWorkHours,
          userId: null,
        );
        final SkilsModel skilsModel = SkilsModel(
          id: 0,
          name: skillsController.text,
        );
        final SkilsModel desiresModel = SkilsModel(
          id: 0,
          name: desiresController.text,
        );
        final List<ExperienceModel> experiencesJson = experiences
            .map((e) => ExperienceModel.fromJson(e.toJson()))
            .toList();

        await Provider.of<SkillsProvider>(context, listen: false)
            .addSkill(skilsModel: skilsModel)
            .then(
          (value) async {
            await Provider.of<DesiresProvider>(context, listen: false)
                .addDesires(desiresModel: desiresModel)
                .then(
              (value) async {
                for (var experience in experiencesJson) {
                  await Provider.of<ExperienceProvider>(context, listen: false)
                      .addExperiences(experiencesModel: experience);
                  // await Future.delayed(Duration(seconds: 2));
                  // log(experience.nameExper.toString(),
                  // name: 'experience experience experience');
                }
              },
            ).then(
              (value) async {
                await searcherProvider.updateSearchers(
                    searchersModel: searcher);
              },
            );
          },
        );
      },
    );
  }

  SizedBox body(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      width: SizeConfig.screenW! - 20,
      height: SizeConfig.screenH! / 2.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  searcherProvider.currentSearcher?.fullName ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  searcherProvider.currentSearcher?.bDate ?? '',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
          Form(
              child: Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                customTextFild(
                  readOnly: true,
                  hintText: l10n.personalinformation,
                  onTap: () {
                    showInformationTextFile(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: _showEducationLevelDialog,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            selectedEducationLevel.isEmpty
                                ? l10n.educationLevel
                                : selectedEducationLevel,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
                // المهارات
                customTextFild(
                  hintText: l10n.skills,
                  controller: skillsController,
                  // suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                //الخبرات
                customTextFild(
                  readOnly: true,
                  hintText: experiences.isEmpty
                      ? l10n.experiences
                      : '${experiences.first.nameExper}....',
                  onTap: () {
                    final formKeyExperience = GlobalKey<FormState>();
                    final TextEditingController experiencesNameController =
                        TextEditingController();
                    final TextEditingController experiencesNameCompController =
                        TextEditingController();
                    final TextEditingController experiencesTypeController =
                        TextEditingController();
                    final TextEditingController experiencesStartDateController =
                        TextEditingController();
                    final TextEditingController experiencesEndDateController =
                        TextEditingController();
                    final TextEditingController experiencesStateController =
                        TextEditingController();
                    final TextEditingController experiencesSalryController =
                        TextEditingController();
                    showDialog(
                      context: context,
                      builder: (contx) => AlertDialog(
                        title: Text(l10n.addexperiences),
                        content: SingleChildScrollView(
                          child: Form(
                            key: formKeyExperience,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                customTextFild(
                                  controller: experiencesNameController,
                                  hintText: l10n.experiencename,
                                ),
                                customTextFild(
                                  controller: experiencesNameCompController,
                                  hintText: l10n.ompanyName,
                                ),
                                customTextFild(
                                  controller: experiencesTypeController,
                                  hintText: l10n.typeexperience,
                                ),
                                customTextFild(
                                  controller: experiencesStartDateController,
                                  hintText: l10n.startdate,
                                ),
                                customTextFild(
                                  controller: experiencesEndDateController,
                                  hintText: l10n.enddate,
                                ),
                                customTextFild(
                                  controller: experiencesStateController,
                                  hintText: l10n.thecondition,
                                ),
                                customTextFild(
                                  controller: experiencesSalryController,
                                  hintText: l10n.salary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(contx);
                            },
                            child: Text(l10n.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add experience logic here
                              if (formKeyExperience.currentState!.validate()) {
                                ExperienceModel experience = ExperienceModel(
                                  id: 0,
                                  nameExper: experiencesNameController.text,
                                  nameComp: experiencesNameCompController.text,
                                  typeExper: experiencesTypeController.text,
                                  startDate:
                                      experiencesStartDateController.text,
                                  endDate: experiencesEndDateController.text,
                                  state: experiencesStateController.text,
                                  salry: int.tryParse(
                                      experiencesSalryController.text),
                                );

                                // Add to list of experiences
                                setState(() {
                                  experiences.add(experience);
                                });

                                // Clear controllers
                                experiencesNameController.clear();
                                experiencesNameCompController.clear();
                                experiencesTypeController.clear();
                                experiencesStartDateController.clear();
                                experiencesEndDateController.clear();
                                experiencesStateController.clear();
                                experiencesSalryController.clear();

                                // Show success message
                                ScaffoldMessenger.of(contx).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.experienceadded),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Text(l10n.addexperience),
                          ),
                          TextButton(
                            onPressed: () {
                              // Here you can send experiences list to API
                              // TODO: Add API call to save experiences
                              // Add experience logic here
                              if (formKeyExperience.currentState!.validate()) {
                                ExperienceModel experience = ExperienceModel(
                                  nameExper: experiencesNameController.text,
                                  nameComp: experiencesNameCompController.text,
                                  typeExper: experiencesTypeController.text,
                                  startDate:
                                      experiencesStartDateController.text,
                                  endDate: experiencesEndDateController.text,
                                  state: experiencesStateController.text,
                                  salry: int.tryParse(
                                      experiencesSalryController.text),
                                );

                                // Add to list of experiences
                                setState(() {
                                  experiences.add(experience);
                                });

                                // Clear controllers
                                experiencesNameController.clear();
                                experiencesNameCompController.clear();
                                experiencesTypeController.clear();
                                experiencesStartDateController.clear();
                                experiencesEndDateController.clear();
                                experiencesStateController.clear();
                                experiencesSalryController.clear();

                                // Show success message
                                ScaffoldMessenger.of(contx).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.experienceadded),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                                print(
                                    'Experiences to save: ${experiences.length}');
                                for (var exp in experiences) {
                                  print(exp.toJson());
                                }
                                Navigator.pop(contx);
                              } else {
                                print(
                                    'Experiences to save: ${experiences.length}');
                                for (var exp in experiences) {
                                  print(exp.toJson());
                                }
                                Navigator.pop(contx);
                              }
                            },
                            child: Text(l10n.sava),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // الرغبات
                customTextFild(
                  hintText: l10n.desires,
                  controller: desiresController,
                  // suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: GestureDetector(
                //     onTap: _showSkillsDialog,
                //     child: Container(
                //       padding: const EdgeInsets.all(16),
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           if (selectedSkills.isEmpty)
                //             Text(
                //               'المهارات',
                //               style: Theme.of(context).textTheme.bodyLarge,
                //             ),
                //           if (selectedSkills.isNotEmpty)
                //             Expanded(
                //               child: Wrap(
                //                 spacing: 8,
                //                 runSpacing: 8,
                //                 children: selectedSkills
                //                     .map((skill) => Chip(
                //                           label: Text(skill),
                //                         ))
                //                     .toList(),
                //               ),
                //             ),
                //           const Icon(Icons.arrow_drop_down),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: GestureDetector(
                //     onTap: _showExperiencesDialog,
                //     child: Container(
                //       padding: const EdgeInsets.all(16),
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           if (selectedExperiences.isEmpty)
                //             Text(
                //               'الخبرات',
                //               style: Theme.of(context).textTheme.bodyLarge,
                //             ),
                //           if (selectedExperiences.isNotEmpty)
                //             Expanded(
                //               child: Wrap(
                //                 spacing: 8,
                //                 runSpacing: 8,
                //                 children: selectedExperiences
                //                     .map((experience) => Chip(
                //                           label: Text(experience),
                //                         ))
                //                     .toList(),
                //               ),
                //             ),
                //           const Icon(Icons.arrow_drop_down),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: GestureDetector(
                //     onTap: _showDesiresDialog,
                //     child: Container(
                //       padding: const EdgeInsets.all(16),
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           if (selectedDesires.isEmpty)
                //             Text(
                //               'الرغبات',
                //               style: Theme.of(context).textTheme.bodyLarge,
                //             ),
                //           if (selectedDesires.isNotEmpty)
                //             Expanded(
                //               child: Wrap(
                //                 spacing: 8,
                //                 runSpacing: 8,
                //                 children: selectedDesires
                //                     .map((desire) => Chip(
                //                           label: Text(desire),
                //                         ))
                //                     .toList(),
                //               ),
                //             ),
                //           const Icon(Icons.arrow_drop_down),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: _showPreferencesDialog,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (selectedPreferences.isEmpty)
                            Text(
                              l10n.preferences,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          if (selectedPreferences.isNotEmpty)
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: selectedPreferences
                                    .map((preference) => Chip(
                                          label: Text(preference),
                                        ))
                                    .toList(),
                              ),
                            ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_imageFile != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        _imageFile!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Future<dynamic> showInformationTextFile(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return showDialog(
      context: context,
      builder: (cntx) => StatefulBuilder(builder: (context, setState) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                height: SizeConfig.screenH! / 1.5,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 252, 252, 252),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultPadding),
                      topRight: Radius.circular(defaultPadding),
                      bottomLeft: Radius.circular(defaultPadding),
                      bottomRight: Radius.circular(defaultPadding),
                    )),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            searcherProvider.currentSearcher?.fullName ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            searcherProvider.currentSearcher?.bDate ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.personalinformation,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                const Icon(Icons.report),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Form(
                      child: Material(
                        child: Column(
                          children: [
                            customTextFild(
                              hintText: l10n.fullname,
                              controller: fullNameController,
                            ),
                            customTextFild(
                              hintText: l10n.age,
                              controller: ageController,
                            ),
                            customTextFild(
                              hintText: "مكان الميلاد",
                              controller: birthPlaceController,
                            ),
                            customTextFild(
                              hintText: "السكن الحالي",
                              controller: currentResidenceController,
                            ),
                            customTextFild(
                              hintText: l10n.special,
                              controller: specialImageController,
                            ),
                            InkWell(
                              onTap: _showSocialStatusDialog,
                              child: AbsorbPointer(
                                child: customTextFild(
                                  onTap: _showSocialStatusDialog,
                                  hintText: "الحالة الاجتماعية",
                                  controller: socialStatusController,
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: customTextFild(
                                  hintText: l10n.datebirth,
                                  controller: birthDateController,
                                ),
                              ),
                            ),
                            if (searcherProvider.currentSearcher?.img != null)
                              // Image.network(
                              //     searcherProvider.currentSearcher!.img!),
                              if (profileImageController.text.isEmpty ||
                                  _imageFile == null) ...[
                                InkWell(
                                  onTap: _selectImage,
                                  child: Center(
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
                                          searcherProvider
                                                  .currentSearcher!.img ??
                                              '',
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
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
                                                const CircularProgressIndicator(),
                                              ],
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
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

                                  //  AbsorbPointer(
                                  //   child: customTextFild(
                                  //     hintText: "الصورة الشخصية",
                                  //     controller: profileImageController,
                                  //     suffixIcon: const Icon(Icons.image),
                                  //   ),
                                  // ),
                                )
                              ] else ...[
                                InkWell(
                                  onTap: _selectImage,
                                  child: Center(
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
                                        child: Image.file(
                                          _imageFile ??
                                              File(profileImageController.text),
                                          fit: BoxFit.contain,
                                          // filterQuality: FilterQuality.high,
                                          // errorBuilder:
                                          //     (context, error, stackTrace) {
                                          //   return const Icon(
                                          //     Icons.person,
                                          //     size: 50,
                                          //   );
                                          // },
                                        ),
                                        // : const Icon(
                                        //     Icons.person,
                                        //     size: 50,
                                        //   ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            SizedBox(
                              width: SizeConfig.screenW! / 2,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (Navigator.canPop(cntx)) {
                                      Navigator.pop(cntx);
                                    }
                                  },
                                  child: Text(l10n.sava)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            // Positioned(
            //     top: 0,
            //     left: 0,
            //     right: 0,
            //     child: Container(
            //       width: SizeConfig.screenW! / 2,
            //       height: SizeConfig.screenH! / 6,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //         image: searcherProvider.currentSearcher?.img != null
            //             ? NetworkImage(searcherProvider.currentSearcher!.img!)
            //             : AssetImage(
            //                 'assets/images/profile.png',
            //               ),
            //       )),
            //     )),
          ],
        );
      }),
    );
  }

  Padding customTextFild({
    required String hintText,
    void Function()? onTap,
    bool readOnly = false,
    TextEditingController? controller,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.newline,
        cursorColor: kPrimaryColor,
        onSaved: (email) {},
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: kBorderColor, width: 2.0),
          ),
          hintText: hintText,
          // prefixIcon: const Padding(
          //   padding: EdgeInsets.all(defaultPadding),
          //   child: Icon(Icons.arrow_back_rounded),
          // ),
          suffixIcon: suffixIcon,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الحقل مطلوب';
          }
          return null;
        },
      ),
    );
  }
}
