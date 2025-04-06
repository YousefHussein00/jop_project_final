import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jop_project/Controller/Firebase_Services/notifications_service.dart';
import 'package:jop_project/Controller/Firebase_Services/send_notification_service.dart';
import 'package:jop_project/Controller/api_controller.dart';
import 'package:jop_project/Models/company_model.dart';
import 'package:jop_project/Controller/image_uplode_controller.dart';
import 'package:jop_project/Models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanySigninLoginProvider extends ChangeNotifier {
  final ApiController _apiController = ApiController();
  final ImageUploadController _imageUploadController = ImageUploadController();
  CompanyModel? _currentCompany;
  bool _isLoading = false;
  String? _error;
  String? _token;

  // Getters
  CompanyModel? get currentCompany => _currentCompany;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;

  // تهيئة البيانات عند بدء التطبيق
  Future<void> initializeApp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userType = prefs.getString('userType');
      final userId = prefs.getInt('userId');

      if (token != null && userType == "Admin" && userId != null) {
        // محاولة جلب الدول من التخزين المحلي أولاً
        // final prefs = await SharedPreferences.getInstance();
        final cachedData = prefs.getString('Companies');

        if (cachedData != null) {
          final dynamic decodedData = json.decode(cachedData);
          log(decodedData.toString(), name: 'decodedData');
          _currentCompany = CompanyModel.fromJson(decodedData);

          // notifyListeners();
        }
        // جلب بيانات الشركة
        final companyData = await _apiController.get<CompanyModel>(
          endpoint: 'Companies/$userId',
          fromJson: (json) =>
              CompanyModel.fromJson(json as Map<String, dynamic>),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        _token = token;
        NotificationsService notificationsService = NotificationsService();
        String tokenNotificationsDevice =
            (await notificationsService.getDeviceToken())!;
        if (companyData.tokenNotification == null ||
            companyData.tokenNotification != tokenNotificationsDevice) {
          final addTokenNotificationcomany = companyData;
          addTokenNotificationcomany.tokenNotification =
              tokenNotificationsDevice;
          final response = await _apiController.put(
            endpoint: 'Companies/$userId',
            data: addTokenNotificationcomany.toJson(),
            fromJson: CompanyModel.fromJson,
          );
          _currentCompany = response;
          if (response.id != null) {
            log(response.tokenNotification.toString(),
                name: 'response.tokenNotification');
          }
        } else {
          _currentCompany = companyData;
          log(companyData.tokenNotification.toString(),
              name: 'companyData.tokenNotification');
        }

        if (companyData.id != null) {
          _currentCompany = companyData;
          // تخزين البيانات محلياً
          await prefs.setString('Companies', json.encode(_currentCompany));
        }
        notifyListeners();
      }
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userType = prefs.getString('userType');
      final userId = prefs.getInt('userId');

      if (token != null && userType == "Admin" && userId != null) {
        final prefs = await SharedPreferences.getInstance();
        final cachedData = prefs.getString('Companies');

        if (cachedData != null) {
          final dynamic decodedData = json.decode(cachedData);
          _currentCompany = CompanyModel.fromJson(decodedData);
          _token = token;
          notifyListeners();
        } else {
          log('خطأ في تهيئة التطبيق: $e');
          _error = e.toString();
          notifyListeners();
          await logout(); // تسجيل الخروج في حالة حدوث خطأ
        }
      } else {
        log('خطأ في تهيئة التطبيق: $e');
        _error = e.toString();
        notifyListeners();
        await logout(); // تسجيل الخروج في حالة حدوث خطأ
      }
    }
  }

  // تسجيل شركة جديدة
  Future<void> registerCompany({
    required CompanyModel companyModel,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // إذا كان هناك صورة، قم برفعها أولاً
      if (companyModel.img != null && companyModel.img!.isNotEmpty) {
        log(companyModel.img.toString());
        final imageFile = File(companyModel.img!);
        final imageUrl = await _imageUploadController.uploadImage(imageFile);
        if (imageUrl != null) {
          companyModel.img = imageUrl;
        } else {
          throw Exception('فشل في رفع الصورة');
        }
      }
      NotificationsService notificationsService = NotificationsService();
      String tokenNotificationsDevice =
          (await notificationsService.getDeviceToken())!;
      companyModel.tokenNotification = tokenNotificationsDevice;
      final response = await _apiController.post<CompanyModel>(
        endpoint: 'Companies',
        data: companyModel.toJson(),
        fromJson: CompanyModel.fromJson,
        headers: {
          // 'Authorization': 'Bearer $_token',
        },
      );

      // ignore: unnecessary_null_comparison
      if (response != null) {
        _currentCompany = response;
      } else {
        throw Exception('فشل إنشاء الحساب حاول مجدداً');
      }
    } catch (e) {
      _error = 'فشل إنشاء الحساب: ${e.toString()}';

      throw Exception('فشل إنشاء الحساب حاول مجدداً');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // تسجيل الدخول
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiController.post<LoginResponseModel>(
        endpoint: 'Users/Userlogin',
        data: {
          'email': email,
          'password': password,
        },
        fromJson: LoginResponseModel.fromJson,
      );

      // حفظ بيانات الجلسة
      if (response.token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token);
        await prefs.setString('userType', response.userType);
        await prefs.setInt('userId', response.id);
        _token = response.token;
      }

      // جلب بيانات الشركة إذا كان المستخدم شركة
      if (response.userType == "Admin") {
        try {
          final companyData = await _apiController.get<CompanyModel>(
            endpoint: 'Companies/${response.id}',
            fromJson: (json) =>
                CompanyModel.fromJson(json as Map<String, dynamic>),
            headers: {
              'Authorization': 'Bearer ${response.token}',
            },
          );

          NotificationsService notificationsService = NotificationsService();
          await notificationsService.requestNotificationPermission();
          String tokenNotificationsDevice =
              (await notificationsService.getDeviceToken())!;
          log(tokenNotificationsDevice,
              name: 'tokenNotificationsDevice Company');

          if (companyData.tokenNotification == null ||
              companyData.tokenNotification != tokenNotificationsDevice) {
            final addTokenNotificationcomany = companyData;
            addTokenNotificationcomany.tokenNotification =
                tokenNotificationsDevice;
            final responsePut = await _apiController.put(
              endpoint: 'Companies/${response.id}',
              data: addTokenNotificationcomany.toJson(),
              fromJson: CompanyModel.fromJson,
            );
            if (responsePut.id != null) {
              _currentCompany = responsePut;
            }
          } else {
            _currentCompany = companyData;
          }

          // حفظ بيانات الشركة
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('Companies', jsonEncode(companyData.toJson()));
          log(prefs.getString('Companies') ?? 'No data found');
          await SendNotificationsService.sendNotificationForSingleUserUsingApi(
              token: _currentCompany?.tokenNotification,
              title: "مرحباً شركة ${_currentCompany?.nameCompany}",
              body: "تم تسجيل دخولك بنجاح",
              data: {"screen": 'Notifications'});
        } catch (e) {
          log('خطأ في جلب بيانات الشركة: $e');
        }
      }

      return response;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // تحديث بيانات الشركة
  Future<void> updateCompanyProfile(
      {required CompanyModel companyModel}) async {
    try {
      if (_currentCompany == null) {
        throw Exception('لم يتم تسجيل الدخول');
      }

      _isLoading = true;
      _error = null;
      notifyListeners();

      // إذا كان هناك صورة جديدة، قم بتحميلها أولاً
      if ((companyModel.img != null && companyModel.img!.isNotEmpty) &&
          (companyModel.img != _currentCompany!.img)) {
        log(companyModel.img.toString(), name: 'Image');
        final imageFile = File(companyModel.img!);
        final imageUrl = await _imageUploadController.uploadImage(imageFile);
        if (imageUrl != null) {
          companyModel.img = imageUrl;
        } else {
          // throw Exception('فشل في رفع الصورة');
        }
      }

      final response = await _apiController.put<CompanyModel>(
        endpoint: 'companies/${companyModel.id}',
        data: companyModel.toJson(),
        fromJson: CompanyModel.fromJson,
      );

      if (response.id != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Companies', jsonEncode(response.toJson()));
        log(prefs.getString('Companies') ?? 'No data found');
        await SendNotificationsService.sendNotificationForSingleUserUsingApi(
            token: _currentCompany?.tokenNotification,
            title: "تم تعديل بيانات ${_currentCompany?.nameCompany}",
            body: "تم تعديل البيانات بنجاح",
            data: {"screen": 'Notifications'});
        _currentCompany = response;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // حذف جميع البيانات المحفوظة
      _currentCompany = null;
      _token = null;
      notifyListeners();
    } catch (e) {
      log('خطأ في تسجيل الخروج: $e');
      rethrow;
    }
  }

  // إعادة تعيين كلمة المرور
  Future<void> resetPassword({required String email}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _apiController.post<void>(
        endpoint: 'companies/reset-password',
        data: {'email': email},
        fromJson: (_) {},
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
