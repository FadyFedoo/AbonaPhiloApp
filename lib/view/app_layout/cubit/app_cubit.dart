import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/view/addictive_service/addictive_service_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../core/constants.dart';
import '../../../core/networks/local/cache_helper.dart';
import '../../confession_service/confession_service_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
 /* AuthRepo repo;*/

  AppCubit(/*{required this.repo}*/) : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const ConfessionServiceScreen(),
    const AddictiveServiceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  void scheduleDailyNotification() {

    // schedule notification for 08:00 AM
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'firebase key',
        title: 'لا تنسى فتح التطبيق',
        body: 'لمتابعة اخر التحديثات',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: 8,
        minute: 0,
        second: 0,
        repeats: true,
      ),
    );

    // schedule notification for 8:00 PM
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 11,
        channelKey: 'firebase key',
        title: 'لا تنسى فتح التطبيق',
        body: 'لمتابعة اخر التحديثات',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: 20,
        minute: 0,
        second: 0,
        repeats: true,
      ),
    );

  }
  String? locale;

  Future<void> getSavedLocale() async {
    locale = await CacheHelper.getData(key: 'locale');
    emit(ChangeLocaleState());
  }

  Future<void> saveDeviceLocale({required BuildContext context}) async {
    Locale myLocale = Localizations.localeOf(context);
    String currentLanguage = myLocale.languageCode;
    if (kDebugMode) {
      print('device locale is $currentLanguage');
    }
    await CacheHelper.saveData(key: 'locale', value: currentLanguage);
    await getSavedLocale();
  }

  Future<void> changeLocale({required String languageCode}) async {
    await CacheHelper.saveData(key: 'locale', value: languageCode);
    await getSavedLocale();
  }

  Future<void> logOut() async {
    await removeToken();
    isLoggedIn = false; //I know it's in the remove token but I am testing smth
    // userData = null;

    emit(LogoutState());
  }

  Future<void> launchLink(String link) async {
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  Future<void> launchCall(String phoneNumber) async {
    Uri telephoneUrl = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(telephoneUrl)) {
      await launchUrl(telephoneUrl);
    } else {
      throw "Error occured trying to call that number.";
    }
  }

  Future<void> launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      //query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw "Error occured trying to call that number.";
    }
  }
}
