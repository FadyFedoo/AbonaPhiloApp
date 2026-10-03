import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fr_philopater/core/styles/text_styles.dart';
import 'package:fr_philopater/generated/assets.dart';
import 'package:go_router/go_router.dart';
import '../../../core/app_router/routes.dart';
import '../../../core/styles/app_colors.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (AppCubit.get(context).locale == null) {
    //     AppCubit.get(context).saveDeviceLocale(context: context);
    //   }
    // });
    initNavigateToHomeView();
  }

  void initNavigateToHomeView() {
    Future.delayed(const Duration(seconds: 4), () async {
      GoRouter.of(context).go(AppRouter.appLayoutScreen);

      // if (await checkIsFirstTime()) {
      //   GoRouter.of(context).go(AppRouter.onBoardingScreen);
      // } else {
      //   GoRouter.of(context).go(AppRouter.appLayoutScreen);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.5),
              image: const DecorationImage(
                image: AssetImage(Assets.imagesSplashImage),
                fit: BoxFit.cover,

                // colorFilter: ColorFilter.mode(
                //   AppColors.primaryColor.withOpacity(0.6),
                //   BlendMode.dstATop,
                // ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            child: RichText(
              text: TextSpan(
                  text: 'Developed by: ',
                  style: MyTextStyles.textStyle16Bold
                      .copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                      text: 'Attia Fouad',
                      style: MyTextStyles.textStyle16Bold
                          .copyWith(color: Colors.white),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
