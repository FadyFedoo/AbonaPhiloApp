import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:fr_philopater/core/styles/app_colors.dart';
import 'package:intl/intl.dart' as intl;
import '../view/app_layout/cubit/app_cubit.dart';
import 'networks/local/cache_helper.dart';
import 'networks/local/secure_cache_helper.dart';
import 'notification_helper/fcm_helper.dart';

var policyPrivacyUrl = "https://elbroker-app.web.app/privacy-policy";
var arabicPolicyPrivacyUrl = "https://elbroker-app.web.app/privacy-policyAr";
var termsUrl = "https://elbroker-app.web.app/";
var arabicTermsUrl = "https://elbroker-app.web.app/Ar";

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;// UserModel? userData;
var primaryColor = AppColors.primaryColor;

const String heroTag = 'unitDetailsHeroTag';
TextDirection arabicDirectionality = TextDirection.rtl;
TextDirection englishDirectionality = TextDirection.ltr;
late bool isLoggedIn;

Future<String?> getToken() async {
  return await SecureCacheHelper.getData(key: 'token');
}

Future<void> saveToken({required String token}) async {
  await SecureCacheHelper.saveData(key: 'token', value: token);
  await checkLoginStatus();
}

Future<void> removeToken() async {
  await SecureCacheHelper.removeData(key: 'token');
  await checkLoginStatus();
}

Future<void> checkLoginStatus() async {
  isLoggedIn = await getToken() != null ? true : false;
}

Future<void> checkSubscribedTopics() async {
  // check if is it null that means it is first time and should subscribe to topic
  if (await CacheHelper.getData(key: 'saleTopic') == null) {
    FCMHelper.subscribeToTopic(topic: 'saleTopic');
    await CacheHelper.saveData(key: 'saleTopic', value: true);
  }

  if (await CacheHelper.getData(key: 'resaleTopic') == null) {
    FCMHelper.subscribeToTopic(topic: 'resaleTopic');
    await CacheHelper.saveData(key: 'resaleTopic', value: true);
  }

  if (await CacheHelper.getData(key: 'rentalTopic') == null) {
    FCMHelper.subscribeToTopic(topic: 'rentalTopic');
    await CacheHelper.saveData(key: 'rentalTopic', value: true);
  }

  // check if is subscribed or not

  FCMHelper.subscribedSaleTopic = await CacheHelper.getData(key: 'saleTopic');
  FCMHelper.subscribedResaleTopic =
      await CacheHelper.getData(key: 'resaleTopic');
  FCMHelper.subscribedRentalTopic =
      await CacheHelper.getData(key: 'rentalTopic');
}

Future<bool> checkIsFirstTime() async {
  return await CacheHelper.getData(key: 'isFirstTime') == null ? true : false;
}

const double appPadding = 15;

String priceFormat({required BuildContext context, required String price}) {
  late String priceFormat;
  if (AppCubit.get(context).locale!.contains('ar')) {
    priceFormat = 'ar_EG';
  } else {
    priceFormat = 'en_US';
  }
  return intl.NumberFormat('#,###', priceFormat).format(double.parse(price));
}

String dateFormat({required DateTime date, required BuildContext context}) {
  late String dateLocal = 'ar_EG';

  return intl.DateFormat.yMMMd(dateLocal).format(date);
}

Future<void> showIOSDatePicker(
    {required BuildContext ctx,
    dynamic Function(DateTime)? onConfirm,
    required DateTime nowDateTime}) async {
  await DatePickerBdaya.showDatePicker(ctx,
      showTitleActions: true,
      minTime: DateTime(nowDateTime.year - 120),
      maxTime: DateTime(nowDateTime.year + 10),
      currentTime: DateTime.now(),
      theme: DatePickerThemeBdaya(
          // headerColor: primaryColor,
          doneStyle: TextStyle(
        color: primaryColor,
      )),
      onChanged: (date) {}, onConfirm: (date) {
    onConfirm!(date);
  }, locale: LocaleType.ar);



}

int daysBetween({ required DateTime startDate, required DateTime endDate}) {
  // Ensure startDate is before endDate
  if (startDate.isAfter(endDate)) {
    return 0;
  }

  // Calculate the difference between the two dates
  Duration difference = endDate.difference(startDate);

  // Convert the difference to days
  return difference.inDays;
}

