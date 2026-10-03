import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../view/app_layout/cubit/app_cubit.dart';
import '../../app_router/routes.dart';
import '../../constants.dart';
import 'api_constances.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: const Duration(seconds: 60), //60 seconds
      // sendTimeout: const Duration(seconds: 60), //60 seconds
      // receiveTimeout: const Duration(seconds: 60),
      /*headers: {
          'Content-Type':'application/json',
        }*/
    ));

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

  }

  static Future<String> detectCurrentLocale() async {
    BuildContext? context =
        AppRouter.router.routerDelegate.navigatorKey.currentContext;
    var cubit = AppCubit.get(context);
    if (cubit.locale == null) {
      // saved locale is null so we should detect the system locale
      return detectSystemLocale();
    } else if (cubit.locale!.contains('ar')) {
      // saved locale is ar
      return 'AR';
    } else if (cubit.locale!.contains('en')) {
      // saved locale is en
      return 'EN';
    }
    // default case
    return 'EN';
  }

  static Future<String> detectSystemLocale() async {
    BuildContext? context =
        AppRouter.router.routerDelegate.navigatorKey.currentContext;
    Locale myLocale = Localizations.localeOf(context!);
    String currentLanguage = myLocale.languageCode;
    if (currentLanguage.contains('ar')) {
      return 'AR';
    } else if (currentLanguage.contains('en')) {
      return 'EN';
    }
    // default case
    return 'EN';
  }

  static getData({
    required String url,
    query,
    bool sendToken = false,
    data,
  }) async {
    dio.options.headers = {
      // 'Content-Type': 'application/json',
      'lang': await detectCurrentLocale(),
      'token': sendToken ? await getToken() : '',
    };

    return await dio.get(
      data: data,
      url,
      queryParameters: query,
    );
  }

  static postData({
    required String url,
    query,
    required data,
    bool sendToken = false,
  }) async {
    dio.options.headers = {
      'lang': await detectCurrentLocale(),
      // 'Content-Type': 'application/json',
      'token': sendToken ? await getToken() : '',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static patchData({
    required String url,
    query,
    required data,
    bool sendToken = false,
  }) async {
    dio.options.headers = {
      'lang': await detectCurrentLocale(),
      // 'Content-Type': 'application/json',
      'token': sendToken ? await getToken() : '',
    };
    return await dio.patch(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static deleteData({
    required String url,
    query,
    required data,
    bool sendToken = false,
  }) async {
    dio.options.headers = {
      'lang': await detectCurrentLocale(),
      // 'Content-Type': 'application/json',
      'token': sendToken ? await getToken() : '',
    };
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static putData({
    required String url,
    query,
    required data,
    String lang = 'en',
    bool sendToken = false,
  }) async {
    dio.options.headers = {
      'lang': await detectCurrentLocale(),
      // 'Content-Type': 'application/json',
      // 'lang': lang,
      'token': sendToken ? await getToken() : '',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
