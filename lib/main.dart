import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fr_philopater/view/app_layout/cubit/app_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_localiziations/app_localizations.dart';
import 'core/app_router/routes.dart';
import 'core/bloc_helper/my_bloc_observer.dart';
import 'core/networks/local/cache_helper.dart';
import 'core/networks/local/secure_cache_helper.dart';
import 'core/networks/remote/dio_helper.dart';
import 'core/notification_helper/fcm_helper.dart';
import 'core/notification_helper/notification_service.dart';
import 'core/services/services_locator.dart';
import 'core/styles/themes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ServicesLocator().init();
  FCMHelper.init();
  FCMHelper.subscribeToTopic();
  FCMHelper.onMessageListener();
  FCMHelper.onBackgroundListener();
  SecureCacheHelper.init();
  await NotificationsService.initializeNotifications();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<AppCubit>()
              ..getSavedLocale()
              ..scheduleDailyNotification()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = AppCubit.get(context);
          return ScreenUtilInit(
            designSize: const Size(390, 825),
            builder: (context, child) {
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                ],
                localizationsDelegates: const [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                locale: /*cubit.locale == null ? null : Locale(cubit.locale!)*/
                    const Locale('ar'),
                color: Colors.white,
                themeMode: ThemeMode.light,
                theme: lightTheme,
              );
            },
          );
        },
      ),
    );
  }
}
