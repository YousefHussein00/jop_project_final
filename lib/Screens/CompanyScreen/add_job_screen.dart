import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jop_project/Models/job_advertisement_model.dart';
import 'package:jop_project/Providers/Job/job_provider.dart';
import 'package:jop_project/Providers/SignUp/company_signin_login_provider.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/components/preferences_selector.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';
import 'package:jop_project/size_config.dart';
import 'package:provider/provider.dart';

class AddJopScreen extends StatefulWidget {
  const AddJopScreen({
    super.key,
  });

  @override
  State<AddJopScreen> createState() => _AddJopScreenState();
}

class _AddJopScreenState extends State<AddJopScreen> {
  final descriptionController = TextEditingController();
  final addrees = TextEditingController();
  final requiredQualifications = TextEditingController();
  final workType = TextEditingController();
  final area = TextEditingController();
  final applicationPeriod = TextEditingController();
  final salary = TextEditingController();
  final jopNameController = TextEditingController();
  final expController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final companyProvider = Provider.of<CompanySigninLoginProvider>(context);

    return Scaffold(
      body: Background(
        height: SizeConfig.screenH! / 4.5,
        showListNotiv: true,
        title: l10n.addjob,
        isCompany: true,
        userImage: companyProvider.currentCompany!.img,
        userName: companyProvider.currentCompany!.nameCompany,
        child: Center(
          child: SingleChildScrollView(
            child: Responsive(
              mobile: MobileHomeJopInfoScreen(
                expController: expController,
                jopNameController: jopNameController,
                descriptionController: descriptionController,
                addrees: addrees,
                requiredQualifications: requiredQualifications,
                workType: workType,
                area: area,
                applicationPeriod: applicationPeriod,
                salary: salary,
              ),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: companyProvider.currentCompany!.img == null
                              ? Image.asset(
                                  'assets/images/YKB.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  companyProvider.currentCompany!.img!,
                                  fit: BoxFit.fill,
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
                                companyProvider.currentCompany!.nameCompany!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                companyProvider.currentCompany!.location!,
                                style: const TextStyle(
                                  color: Colors.grey,
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
                        expController: expController,
                        jopNameController: jopNameController,
                        descriptionController: descriptionController,
                        addrees: addrees,
                        requiredQualifications: requiredQualifications,
                        workType: workType,
                        area: area,
                        applicationPeriod: applicationPeriod,
                        salary: salary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileHomeJopInfoScreen extends StatefulWidget {
  final TextEditingController descriptionController;
  final TextEditingController addrees;
  final TextEditingController requiredQualifications;
  final TextEditingController workType;
  final TextEditingController area;
  final TextEditingController applicationPeriod;
  final TextEditingController salary;
  final TextEditingController jopNameController;
  final TextEditingController expController;
  const MobileHomeJopInfoScreen({
    super.key,
    required this.descriptionController,
    required this.expController,
    required this.addrees,
    required this.requiredQualifications,
    required this.workType,
    required this.area,
    required this.applicationPeriod,
    required this.salary,
    required this.jopNameController,
  });

  @override
  State<MobileHomeJopInfoScreen> createState() =>
      _MobileHomeJopInfoScreenState();
}

class _MobileHomeJopInfoScreenState extends State<MobileHomeJopInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: SizeConfig.screenW! / 1.2,
              child: const CardMainInfoWidget(),
            ),
          ),
          const SizedBox(height: 16),
          InfoBodyWidget(
            expController: widget.expController,
            jopNameController: widget.jopNameController,
            descriptionController: widget.descriptionController,
            addrees: widget.addrees,
            requiredQualifications: widget.requiredQualifications,
            workType: widget.workType,
            area: widget.area,
            applicationPeriod: widget.applicationPeriod,
            salary: widget.salary,
          ),
        ],
      ),
    );
  }
}

class InfoBodyWidget extends StatefulWidget {
  final TextEditingController descriptionController;
  final TextEditingController addrees;
  final TextEditingController requiredQualifications;
  final TextEditingController workType;
  final TextEditingController area;
  final TextEditingController applicationPeriod;
  final TextEditingController salary;
  final TextEditingController jopNameController;
  final TextEditingController expController;
  const InfoBodyWidget({
    super.key,
    required this.expController,
    required this.descriptionController,
    required this.addrees,
    required this.requiredQualifications,
    required this.workType,
    required this.area,
    required this.applicationPeriod,
    required this.salary,
    required this.jopNameController,
  });

  @override
  State<InfoBodyWidget> createState() => _InfoBodyWidgetState();
}

class _InfoBodyWidgetState extends State<InfoBodyWidget> {
  final keyForm = GlobalKey<FormState>();
  List<String> selectedPreferences = [];
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final jopProvider = Provider.of<JobsProvider>(context);
    final companyProvider = Provider.of<CompanySigninLoginProvider>(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Form(
        key: keyForm,
        child: Column(
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
            _buildInfoItem(Icons.work, l10n.nameinformation, //----
                controller: widget.jopNameController),
            RectanglText(descriptionController: widget.descriptionController),
            const SizedBox(height: 16),
            _buildInfoItem(
              Icons.add_location,
              l10n.locationaddress, //----
              controller: widget.addrees,
            ),
            _buildInfoItem(Icons.school, l10n.academicqualifications, //----
                controller: widget.requiredQualifications),
            _buildInfoItem(
                Icons.domain_verification_rounded, l10n.mdexperiences,
                controller: widget.expController), //----
            InkWell(
              onTap: _showPreferencesDialog,
              child: _buildInfoItem(Icons.access_time, l10n.typework,
                  enabled: false, controller: widget.workType),
            ), //----
            _buildInfoItem(Icons.location_on, l10n.area,
                controller: widget.area), //--------******
            _buildInfoItem(Icons.calendar_today, l10n.applperiod, //----
                controller: widget.applicationPeriod),
            _buildInfoItem(Icons.attach_money, l10n.salary,
                controller: widget.salary), //----

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.salary.text.isEmpty) {
                    widget.salary.text = 'يتم التحديد بعد المقابلة';
                  }
                  if (keyForm.currentState!.validate()) {
                    // log('العنوان: ${addrees.text}المؤهلات المطلوبة: ${requiredQualifications.text}نوع الدوام: ${workType.text}المنطقة: ${area.text}مدة التقديم: ${applicationPeriod.text}الراتب: ${salary.text}');
                    final jobAdvertisementModel = JobAdvertisementModel(
                      id: 0, //----
                      descrip: widget.descriptionController.text, //----
                      companyId: companyProvider.currentCompany!.id, //----
                      countryId:
                          companyProvider.currentCompany!.countryId, //----
                      location: widget.addrees.text, // الموقع المطلوب //----
                      nameJob:
                          widget.jopNameController.text, // اسم الوظيفة//----
                      periodExper:
                          widget.expController.text, //فترة الخبرة //----
                      periodWork: null, //فترة العمل
                      permanenceType:
                          widget.workType.text, //النوع الدائم //----
                      salry: widget.salary.text, // الراتب //----
                      special:
                          widget.requiredQualifications.text, // تخصص //----
                      timeWork:
                          widget.applicationPeriod.text, //نوع الوقت //----
                      typeOfPlace:
                          widget.area.text, //نوع المكان //--------******
                      worksFileId: 2,
                    );
                    await jopProvider.addJobs(
                      jobAdvertisementModel: jobAdvertisementModel,
                    );
                    if (jopProvider.error != null) {
                      Get.snackbar('خطأ', jopProvider.error!,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          icon: const Icon(Icons.error, color: Colors.white),
                          duration: const Duration(seconds: 3),
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      Get.snackbar('تمت الإضافة بنجاح', 'تمت الإضافة بنجاح',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          icon: const Icon(Icons.check, color: Colors.white),
                          duration: const Duration(seconds: 3),
                          snackPosition: SnackPosition.TOP);
                      // ignore: use_build_context_synchronously
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3B77),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: jopProvider.isLoading
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            l10n.addjob,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const Icon(Icons.add, color: Colors.white),
                        ],
                      ),
              ),
            ),
          ],
        ),
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
            widget.workType.text = selectedPreferences.join(',');
          });
        },
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title,
      {required TextEditingController controller, bool enabled = true}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: (SizeConfig.screenW! <= 750) ? 35 : 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  enabled: enabled,
                  // autofocus: true,
                  textDirection: TextDirection.rtl,
                  //style: const TextStyle(fontSize: 20),
                  controller: controller,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    isDense: true,
                    // suffixIcon: const Icon(
                    //   Icons.edit,
                    //   color: Colors.black,
                    //   size: 11,
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 6.0),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25))),
                    hintText: title,
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(90, 0, 0, 0),
                      fontSize: 22,
                    ),
                    errorStyle: const TextStyle(
                      fontSize: 5,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الحقل مطلوب *';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Container(
              width: defaultPadding * 7,
              decoration: const BoxDecoration(
                color: Color(0xFF6B8CC7),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              padding:
                  const EdgeInsets.only(bottom: 7, top: 7, left: 3, right: 5),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                title,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
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
  final TextEditingController descriptionController;

  const RectanglText({
    super.key,
    required this.descriptionController,
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
                  child: TextFormField(
                    // autofocus: true,
                    controller: descriptionController,
                    maxLines: 3,
                    textAlign: TextAlign.right,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الحقل مطلوب *';
                      }
                      return null;
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class CardMainInfoWidget extends StatelessWidget {
  const CardMainInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<CompanySigninLoginProvider>(context);
    return SingleChildScrollView(
      child: Card(
        color: const Color(0xFF6B8CC7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
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
                  child: Image.network(
                    companyProvider.currentCompany!.img ?? '',
                    fit: BoxFit.cover,
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
                      return const Center(
                        child: Icon(
                          Icons.person,
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
              ),
              // Flexible(
              //   child: Container(
              //     width: 50,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         fit: BoxFit.fill,
              //         image: companyProvider.currentCompany!.img == null
              //             ? const AssetImage('assets/images/YKB.png')
              //             : NetworkImage(companyProvider.currentCompany!.img!),
              //       ),
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //   ),
              // ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyProvider.currentCompany!.nameCompany!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      companyProvider.currentCompany!.location!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 68, 68, 68),
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
