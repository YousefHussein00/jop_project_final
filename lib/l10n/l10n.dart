import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Jop Shop',
      'welcomeTitle': "Welcome",
      'loginBtnTitle': "Login",
      'sinupBtnTitle': "Regestar",
      "language": "language",
      "validatorGmail": "Please enter your email address",
      "gmail": "Gmail",
      "validatorPassword": "Please enter your password ",
      "password": "Password",
      "forgotPassword": "ForgotPassword",
      "jobseeker": "job Seeker",
      "employeeSeeker": "Employee Seeker",
      "back": "back",
      "Onboardingtitle1": "Find the right job",
      "Onboardingtitle2": "Apply for any job you like",
      "Onboardingtitle3": "Grow your career with us",
      "Onboardingdesc1":
          "We post thousands of jobs daily on our app, you can find your dream job here.",
      "Onboardingdesc2":
          "You can work from anywhere with the advantage of remote work.",
      "Onboardingdesc3":
          "With us, it's very easy to continue growing and building your career.",
      "startnow": "Start now",
      "skip": "Skip",
      "employee": "Employee",
      "fullname": "The full name",
      "field": "Required field",
      "locationhome": " Current residence",
      "age": "Age",
      "special": "Specialization",
      "educationLevel": "educational level",
      "phone": "phone number",
      "datebirth": "date of birth",
      "type": "Type",
      "man": "Man",
      "woman": "Woman",
      "register": "Registration successful",
      "registration": "Registration",
      "emailorpassworderror": "Email or password error",
      "company": "A company",
      "image": "Error selecting image",
      "ompanyName": "Company Name",
      "locationcompany": "Company Location",
      "phoneOne": "Contact number 1",
      "phoneTow": "Contact number 2",
      "especiallyTitle": " Private",
      "governmental": "Governmental",
      "selectcountry": "Select country",
      "selectcountryplaes": "Plaes Select country",
      "companyType": "Company Type",
      "cv": "CV",
      "personalinformation": "Personal information",
      "name": "Name",
      "socialstatus": "SocialStatus",
      "locationaddress": "Address",
      "typeWorkHours": "TypeWorkHours",
      "skills": "Skills",
      "experiences": "Experiences",
      "mdexperiences": "Md Experiences",
      "desires": "Desires",
      "preferences": "Preferences",
      "manageExternalStorage": "ManageExternalStorage",
      "academicqualifications": "Academic qualifications",
      "downloadsfoldernotfound": "Downloads folder not found'",
      "filesaved": "The file has been saved in",
      "cancel": "Cancel",
      "ok": "OK",
      "havemessage": "You have a message",
      "chats": "Chats",
      "accepted": "Accepted",
      "toupdate": "To update",
      "jobinformation": "Job Information",
      "nameinformation": "Name Information",
      "description": "Description",
      "companyinformation": "Company Information",
      "branch": "Branch",
      "editinformation": "Edit information",
      "jobs": "Jobs",
      "edit": "Edit",
      "delete": "Delete",
      "notjobs": "There are no jobs",
      "typework": "Type of work",
      "area": "The area",
      "applperiod": "Application period",
      "salary": "Salary",
      "error": "Error",
      "modifyjob": "Modify the job",
      "messages": "Messages",
      "availablejobs": "Available jobs",
      "findjob": "Find the job that suits you",
      "contactinformation": "Contact information",
      "callnotmade.": "The call could not be made.",
      "createcv": "First you must either attach or create a CV.",
      "create": "Create",
      "applyjob": "Apply for the job",
      "submissionstatus": "Submission status",
      "acceptedjob.": "You have been accepted for the job.",
      "notacceptedjob": "Not have been accepted for the job.",
      "waiting": "In case of waiting",
      "submitted": "Submitted",
      "home": "Home",
      "viewjobs": "View jobs offered",
      "addvacancy": "Add a vacancy",
      "applicants": "Applicants",
      "addjob": "Add a job",
      "controlpanel": "Control panel",
      "postedjobs": "Posted jobs",
      "cvpreparation": "CV preparation",
      "jobsapplied": "Jobs applied for",
      "notifications": "Notifications",
      "settings": "Settings",
      "team": "About the team",
      "availablecompany": "Available company",
      "newapplicant": "New applicant",
      "evaluation": "More statistics and evaluation",
      "ourvalues": "Our values",
      "signout": "Sign out",
      "thelanguage": "language",
      "personaldata": "Personal data",
      "manuallyresume": "Manually enter your resume",
      "uploadcv": "Upload CV",
      "experienceadded": "Experience added successfully",
      "addexperience": "Add more experience",
      "sava": "Sava",
      "addexperiences": "Add experience",
      "experiencename": "Experience name",
      "typeexperience": "Type of experience",
      "startdate": "Start date",
      "enddate": "End date",
      "thecondition": "The condition",
      "aboutjob": "About the job",
      "jobsappliedfor": "Jobs applied for",
      "nodata": "No data",
      "search": "Search",
      "nothing": "Nothing",
      "jobapplicants": "Job applicants",
      "applicationstatistics": "Application statistics",
      "acceptedapplication": "Those accepted the application",
      "users": "Users",
      "havehired": "We have been hired",
      "usersapplication": "Current users of the application",
      "companiesapplication": "Companies participating in the application",
      "update": "Update Don",
      "applicantInformation": "Applicant information",
      "ksection": "Section ",
    },
    'ar': {
      'appName': 'متجر DIM',
      'welcomeTitle': 'مرحباً بك',
      'loginBtnTitle': "تسجيل الدخول",
      'sinupBtnTitle': "إنشاء حساب",
      "language": "الغة",
      "validatorGmail": "الرجاء إدخال البريد الإلكتروني",
      "gmail": "البريد الالكتروني",
      'validatorPassword': 'الرجاء إدخال كلمة المرور',
      "password": "كلمة المرور",
      "forgotPassword": "نسيت كلمة المرور؟",
      "jobseeker": "باحث عن وظيفة شاغرة  ",
      "employeeSeeker": "باحث عن موظفين  ",
      "back": "رجوع",
      "Onboardingtitle1": "ابحث عن الوظيفة الأنسب",
      "Onboardingtitle2": "قدّم على أي وظيفة تعجبك",
      "Onboardingtitle3": "نمِ مهنتك معنا",
      "Onboardingdesc1":
          "نقوم بنشر آلاف الوظائف يومياً في تطبيقنا، يمكنك العثور على وظيفة أحلامك هنا",
      "Onboardingdesc2": "تستطيع العمل من أي مكان ميزة العمل عن بعد",
      "Onboardingdesc3":
          "معنا ، أصبح من السهل جداً الاستمرار في النمو وبناء مهنتك",
      "startnow": "أبدا الان",
      "skip": "تخطي",
      "employee": "موظف",
      "fullname": "الأسم الرباعي",
      "field": "الحقل مطلوب",
      "locationhome": "مكان السكن حالياً ",
      "age": "العمر",
      "special": "التخصص",
      "educationLevel": "المستوى التعليمي",
      "phone": "رقم الهاتف",
      "datebirth": "تاريخ الميلاد",
      "type": "الجنس",
      "man": "ذكر",
      "woman": "انثى",
      "register": "تم التسجيل بنجاح",
      "registration": "تسجيل",
      "emailorpassworderror": "خطاء في الإميل او كلمة المرور",
      "company": "شركة",
      "image": "حدث خطأ في اختيار الصورة",
      "ompanyName": "أسم الشركة",
      "locationcompany": "موقع الشركة",
      "phoneOne": "رقم التواصل 1",
      "phoneTow": "رقم التواصل 2",
      "especiallyTitle": "خاص",
      "governmental": "حكومي",
      "selectcountry": "اختر الدولة",
      "selectcountryplaes": "الرجاءاختر الدولة",
      "companyType": "نوع الشركة",
      "cv": "السيرة الذاتية",
      "personalinformation": "المعلومات الشخصية",
      "name": "الاسم",
      "socialstatus": "الحالة الاجتماعية",
      "locationaddress": "العنوان",
      "typeWorkHours": "نوع العمل المفضل",
      "skills": "المهارات",
      "experiences": "الخبرات",
      "mdexperiences": "مدا الخبرات ",
      "desires": "الرغبات",
      "preferences": "التفضيلات",
      "manageExternalStorage": "تم رفض إذن الوصول إلى التخزين ",
      "academicqualifications": "المؤهلات العلمية",
      "downloadsfoldernotfound": "مجلد التنزيلات غير موجود",
      "filesaved": "تم حفظ الملف في",
      "cancel": "إلغاء",
      "havemessage": "لديك رسالة",
      "chats": "الدردشات",
      "accepted": "المقبولين",
      "toupdate": "تحديث",
      "jobinformation": "معلومات الوظيفة",
      "nameinformation": "أسم الوظيفة",
      "description": "الوصف",
      "companyinformation": "معلومات الشركة",
      "branch": "الفرع",
      "editinformation": "تعديل المعلومات",
      "jobs": "الوظائف",
      "edit": "تعديل",
      "delete": "حذف",
      "notjobs": "لا توجد اي وظائف",
      "typework": "نوع الدوام",
      "area": "المنطقة",
      "applperiod": "مدة التقديم",
      "salary": "الراتب",
      "error": "خطأ",
      "modifyjob": "تعديل الوظيفة",
      "messages": "الرسائل",
      "availablejobs": "الوظائف المتاحة",
      "findjob": "قم بالبحث عن الوظيفة التي تناسبك",
      "contactinformation": "معلومات الاتصال",
      "callnotmade": "لا يمكن إجراء المكالمة",
      "createcv": "يجب عليك اما إرفاق او إنشاء السيرة الذاتية أولا",
      "create": "إنشاء",
      "applyjob": "تقديم على الوظيفة",
      "submissionstatus": "حالة التقديم",
      "acceptedjob": "تم قبولك في الوظيفة",
      "notacceptedjob": "لم يتم قبولك في الوظيفة",
      "waiting": "في حالة الإنتضار",
      "submitted": "تم التقديم",
      "home": "الرئيسية",
      "viewjobs": "عرض الوظائف المقدمة",
      "addvacancy": "اضافة وظيفة شاغرة",
      "applicants": "المتقدمين",
      "addjob": "إضافة وظيفة",
      "controlpanel": "لوحة التحكم",
      "postedjobs": "الوظائف المنشورة",
      "cvpreparation": "اعدادت السيرة الذاتيه",
      "jobsapplied": "الوظائف المتقدم لها",
      "notifications": "الاشعارات",
      "settings": "الاعدادات",
      "team": "عن الفريق",
      "availablecompany": "شركة متاحة",
      "newapplicant": "متقدم جديد",
      "evaluation": "المزيد من الاحصائيات والتقييم",
      "ourvalues": "قيمنا",
      "signout": "تسجيل الخروج",
      "thelanguage": "اللغة",
      "personaldata": "البيانات الشخصية",
      "manuallyresume": "إدخال السيرة الذاتية يدوياً",
      "uploadcv": "رفع ملف السيرة الذاتية",
      "experienceadded": "تمت إضافة الخبرة بنجاح",
      "addexperience": "إضافة خبرة أخرى",
      "sava": "حفظ",
      "addexperiences": "إضافة خبرة",
      "experiencename": "اسم الخبرة",
      "typeexperience": "نوع الخبرة",
      "startdate": "تاريخ البداية",
      "enddate": "تاريخ النهاية",
      "thecondition": "الحالة",
      "aboutjob": "عن الوظيفة",
      "jobsappliedfor": "الوظائف المتقدم لها",
      "nodata": "لا توجد اي بيانات",
      "search": "البحث",
      "nothing": "لا يوجد",
      "jobapplicants": "المتقدمين للوظائف",
      "applicationstatistics": "احصائيات التطبيق",
      "acceptedapplication": "المقبولين عبر التطبيق",
      "users": "المستخدمين",
      "havehired": "لقد تم توظيف عبرنا",
      "usersapplication": "المستخدمين الحاليين للتطبيق",
      "companiesapplication": "الشركات المشاركة في التطبيق",
      "update": "تم التحديث",
      "applicantInformation": "معلومات المتقدم",
      "ok": "تم",
      "ksection": "<قسم < فرع",
    },
  };

  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get welcomeTitle =>
      _localizedValues[locale.languageCode]!['welcomeTitle']!;
  String get loginBtnTitle =>
      _localizedValues[locale.languageCode]!['loginBtnTitle']!;
  String get sinupBtnTitle =>
      _localizedValues[locale.languageCode]!['sinupBtnTitle']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get validatorGmail =>
      _localizedValues[locale.languageCode]!['validatorGmail']!;
  String get gmail => _localizedValues[locale.languageCode]!['gmail']!;
  String get validatorPassword =>
      _localizedValues[locale.languageCode]!['validatorPassword']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get forgotPassword =>
      _localizedValues[locale.languageCode]!['forgotPassword']!;
  String get jobseeker => _localizedValues[locale.languageCode]!['jobseeker']!;
  String get employeeSeeker =>
      _localizedValues[locale.languageCode]!['employeeSeeker']!;
  String get back => _localizedValues[locale.languageCode]!['back']!;
  String get o => _localizedValues[locale.languageCode]!['Onboardingtitle1']!;
  String get onboardingtitle2 =>
      _localizedValues[locale.languageCode]!['Onboardingtitle2']!;
  String get onboardingtitle3 =>
      _localizedValues[locale.languageCode]!['Onboardingtitle3']!;
  String get onboardingdesc1 =>
      _localizedValues[locale.languageCode]!['Onboardingdesc1']!;
  String get onboardingdesc2 =>
      _localizedValues[locale.languageCode]!['Onboardingdesc2']!;
  String get onboardingdesc3 =>
      _localizedValues[locale.languageCode]!['Onboardingdesc3']!;
  String get startnow => _localizedValues[locale.languageCode]!['startnow']!;
  String get skip => _localizedValues[locale.languageCode]!['skip']!;
  String get employee => _localizedValues[locale.languageCode]!['employee']!;
  String get fullname => _localizedValues[locale.languageCode]!['fullname']!;
  String get field => _localizedValues[locale.languageCode]!['field']!;
  String get ksection => _localizedValues[locale.languageCode]!['ksection']!;
  String get locationhome =>
      _localizedValues[locale.languageCode]!['locationhome']!;
  String get age => _localizedValues[locale.languageCode]!['age']!;
  String get special => _localizedValues[locale.languageCode]!['special']!;
  String get educationLevel =>
      _localizedValues[locale.languageCode]!['educationLevel']!;
  String get phone => _localizedValues[locale.languageCode]!['phone']!;
  String get datebirth => _localizedValues[locale.languageCode]!['datebirth']!;
  String get type => _localizedValues[locale.languageCode]!['type']!;
  String get man => _localizedValues[locale.languageCode]!['man']!;
  String get woman => _localizedValues[locale.languageCode]!['woman']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get update => _localizedValues[locale.languageCode]!['update']!;
  String get registration =>
      _localizedValues[locale.languageCode]!['registration']!;
  String get emailorpassworderror =>
      _localizedValues[locale.languageCode]!['emailorpassworderror']!;
  String get company => _localizedValues[locale.languageCode]!['company']!;
  String get image => _localizedValues[locale.languageCode]!['image']!;
  String get ompanyName =>
      _localizedValues[locale.languageCode]!['ompanyName']!;
  String get locationcompany =>
      _localizedValues[locale.languageCode]!['locationcompany']!;
  String get phoneOne => _localizedValues[locale.languageCode]!['phoneOne']!;
  String get phoneTow => _localizedValues[locale.languageCode]!['phoneTow']!;
  String get especiallyTitle =>
      _localizedValues[locale.languageCode]!['especiallyTitle']!;

  String get governmental =>
      _localizedValues[locale.languageCode]!['governmental']!;
  String get selectcountry =>
      _localizedValues[locale.languageCode]!['selectcountry']!;
  String get selectcountryplaes =>
      _localizedValues[locale.languageCode]!['selectcountryplaes']!;
  String get companyType =>
      _localizedValues[locale.languageCode]!['companyType']!;
  String get cv => _localizedValues[locale.languageCode]!['cv']!;
  String get personalinformation =>
      _localizedValues[locale.languageCode]!['personalinformation']!;
  String get name => _localizedValues[locale.languageCode]!['name']!;
  String get socialstatus =>
      _localizedValues[locale.languageCode]!['socialstatus']!;
  String get locationaddress =>
      _localizedValues[locale.languageCode]!['locationaddress']!;
  String get typeWorkHours =>
      _localizedValues[locale.languageCode]!['typeWorkHours']!;
  String get skills => _localizedValues[locale.languageCode]!['skills']!;
  String get experiences =>
      _localizedValues[locale.languageCode]!['experiences']!;
  String get desires => _localizedValues[locale.languageCode]!['desires']!;
  String get preferences =>
      _localizedValues[locale.languageCode]!['preferences']!;
  String get manageExternalStorage =>
      _localizedValues[locale.languageCode]!['manageExternalStorage']!;
  String get academicqualifications =>
      _localizedValues[locale.languageCode]!['academicqualifications']!;
  String get downloadsfoldernotfound =>
      _localizedValues[locale.languageCode]!['downloadsfoldernotfound']!;
  String get filesaved => _localizedValues[locale.languageCode]!['filesaved']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get havemessage =>
      _localizedValues[locale.languageCode]!['havemessage']!;
  String get chats => _localizedValues[locale.languageCode]!['chats']!;
  String get accepted => _localizedValues[locale.languageCode]!['accepted']!;
  String get toupdate => _localizedValues[locale.languageCode]!['toupdate']!;
  String get jobinformation =>
      _localizedValues[locale.languageCode]!['jobinformation']!;
  String get nameinformation =>
      _localizedValues[locale.languageCode]!['nameinformation']!;
  String get description =>
      _localizedValues[locale.languageCode]!['description']!;
  String get companyinformation =>
      _localizedValues[locale.languageCode]!['companyinformation']!;
  String get branch => _localizedValues[locale.languageCode]!['branch']!;
  String get editinformation =>
      _localizedValues[locale.languageCode]!['editinformation']!;
  String get jobs => _localizedValues[locale.languageCode]!['jobs']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get notjobs => _localizedValues[locale.languageCode]!['notjobs']!;
  String get typework => _localizedValues[locale.languageCode]!['typework']!;
  String get area => _localizedValues[locale.languageCode]!['area']!;
  String get applperiod =>
      _localizedValues[locale.languageCode]!['applperiod']!;
  String get salary => _localizedValues[locale.languageCode]!['salary']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get modifyjob => _localizedValues[locale.languageCode]!['modifyjob']!;
  String get messages => _localizedValues[locale.languageCode]!['messages']!;
  String get availablejobs =>
      _localizedValues[locale.languageCode]!['availablejobs']!;
  String get findjob => _localizedValues[locale.languageCode]!['findjob']!;
  String get contactinformation =>
      _localizedValues[locale.languageCode]!['contactinformation']!;
  String get callnotmade =>
      _localizedValues[locale.languageCode]!['callnotmade']!;
  String get createcv => _localizedValues[locale.languageCode]!['createcv']!;
  String get create => _localizedValues[locale.languageCode]!['create']!;
  String get applyjob => _localizedValues[locale.languageCode]!['applyjob']!;
  String get submissionstatus =>
      _localizedValues[locale.languageCode]!['submissionstatus']!;
  String get acceptedjob =>
      _localizedValues[locale.languageCode]!['acceptedjob']!;
  String get notacceptedjob =>
      _localizedValues[locale.languageCode]!['notacceptedjob']!;
  String get waiting => _localizedValues[locale.languageCode]!['waiting']!;
  String get submitted => _localizedValues[locale.languageCode]!['submitted']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get viewjobs => _localizedValues[locale.languageCode]!['viewjobs']!;
  String get addvacancy =>
      _localizedValues[locale.languageCode]!['addvacancy']!;
  String get applicants =>
      _localizedValues[locale.languageCode]!['applicants']!;
  String get addjob => _localizedValues[locale.languageCode]!['addjob']!;
  String get controlpanel =>
      _localizedValues[locale.languageCode]!['controlpanel']!;
  String get postedjobs =>
      _localizedValues[locale.languageCode]!['postedjobs']!;
  String get cvpreparation =>
      _localizedValues[locale.languageCode]!['cvpreparation']!;
  String get jobsapplied =>
      _localizedValues[locale.languageCode]!['jobsapplied']!;
  String get notifications =>
      _localizedValues[locale.languageCode]!['notifications']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get team => _localizedValues[locale.languageCode]!['team']!;
  String get availablecompany =>
      _localizedValues[locale.languageCode]!['availablecompany']!;
  String get newapplicant =>
      _localizedValues[locale.languageCode]!['newapplicant']!;
  String get evaluation =>
      _localizedValues[locale.languageCode]!['evaluation']!;
  String get ourvalues => _localizedValues[locale.languageCode]!['ourvalues']!;
  String get signout => _localizedValues[locale.languageCode]!['signout']!;
  String get thelanguage =>
      _localizedValues[locale.languageCode]!['thelanguage']!;
  String get personaldata =>
      _localizedValues[locale.languageCode]!['personaldata']!;
  String get manuallyresume =>
      _localizedValues[locale.languageCode]!['manuallyresume']!;
  String get uploadcv => _localizedValues[locale.languageCode]!['uploadcv']!;
  String get experienceadded =>
      _localizedValues[locale.languageCode]!['experienceadded']!;
  String get addexperience =>
      _localizedValues[locale.languageCode]!['addexperience']!;
  String get sava => _localizedValues[locale.languageCode]!['sava']!;
  String get addexperiences =>
      _localizedValues[locale.languageCode]!['addexperiences']!;
  String get experiencename =>
      _localizedValues[locale.languageCode]!['experiencename']!;
  String get typeexperience =>
      _localizedValues[locale.languageCode]!['typeexperience']!;
  String get startdate => _localizedValues[locale.languageCode]!['startdate']!;
  String get enddate => _localizedValues[locale.languageCode]!['enddate']!;
  String get thecondition =>
      _localizedValues[locale.languageCode]!['thecondition']!;
  String get aboutjob => _localizedValues[locale.languageCode]!['aboutjob']!;
  String get jobsappliedfor =>
      _localizedValues[locale.languageCode]!['jobsappliedfor']!;
  String get nodata => _localizedValues[locale.languageCode]!['nodata']!;
  String get search => _localizedValues[locale.languageCode]!['search']!;
  String get nothing => _localizedValues[locale.languageCode]!['nothing']!;
  String get jobapplicants =>
      _localizedValues[locale.languageCode]!['jobapplicants']!;
  String get applicationstatistics =>
      _localizedValues[locale.languageCode]!['applicationstatistics']!;
  String get acceptedapplication =>
      _localizedValues[locale.languageCode]!['acceptedapplication']!;
  String get users => _localizedValues[locale.languageCode]!['users']!;
  String get havehired => _localizedValues[locale.languageCode]!['havehired']!;
  String get usersapplication =>
      _localizedValues[locale.languageCode]!['usersapplication']!;
  String get companiesapplication =>
      _localizedValues[locale.languageCode]!['companiesapplication']!;
  String get applicantInformation =>
      _localizedValues[locale.languageCode]!['applicantInformation']!;
  String get mdexperiences =>
      _localizedValues[locale.languageCode]!['mdexperiences']!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
