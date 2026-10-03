import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/core/app_strings/app_strings.dart';
import 'package:fr_philopater/core/styles/app_colors.dart';
import 'package:fr_philopater/generated/assets.dart';
import 'package:fr_philopater/view/add_new_member/add_new_member_screen.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import '../../core/notification_helper/fcm_helper.dart';
import '../../core/notification_helper/notification_controller.dart';
import 'cubit/app_cubit.dart';

class AppLayoutScreen extends StatefulWidget {
  const AppLayoutScreen({super.key});

  @override
  State<AppLayoutScreen> createState() => _AppLayoutScreenState();
}

class _AppLayoutScreenState extends State<AppLayoutScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AwesomeNotifications().setListeners(
          onActionReceivedMethod:
              NotificationsController.onActionReceivedMethod,
          onNotificationCreatedMethod:
              NotificationsController.onNotificationCreatedMethod,
          onNotificationDisplayedMethod:
              NotificationsController.onNotificationDisplayedMethod,
          onDismissActionReceivedMethod:
              NotificationsController.onDismissActionReceivedMethod);
      FCMHelper.initialMessageHandler(context: context);
      FCMHelper.onMessageOpenedAppHandler(context: context);
      // HomeCubit.get(context).initHome();
      // FavoritesCubit.get(context).initFavorites();
      // AppCubit.get(context).getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddNewMemberScreen(),));
              // cubit.changeBottomNavBar(1);
            },
            elevation: 0.0,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ), // Add this line to make it circular
          ),
          // This trailing comma makes auto-formatting nicer for build methods.

          body: LazyLoadIndexedStack(
            index: cubit.currentIndex,
            children: cubit.screens,
          ) ,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.whiteColor,
            type: BottomNavigationBarType.fixed,
            iconSize: 20,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            elevation: 5,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage(Assets.imageIconsConfession),
                  color: cubit.currentIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.greyTextColor,
                ),
                label: AppStrings.confessions,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage(Assets.imageIconsAddictive),
                  color: cubit.currentIndex == 1
                      ? AppColors.primaryColor
                      : AppColors.greyTextColor,
                ),
                label: AppStrings.addictive,
              ),
            ],
          ),
        );
      },
    );
  }
}
