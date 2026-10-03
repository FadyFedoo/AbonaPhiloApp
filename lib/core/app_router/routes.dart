import 'package:flutter/material.dart';
import 'package:fr_philopater/core/app_router/pages_animations.dart';
import 'package:fr_philopater/core/enums.dart';
import 'package:fr_philopater/view/app_layout/app_layout.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_model.dart';
import '../../view/edit_member/edit_member_screen.dart';
import '../../view/member_profile/member_profile_screen.dart';
import '../../view/refresh_app_screen/refresh_app_screen.dart';
import '../../view/search/search_screen.dart';
import '../../view/splash/splash_screen.dart';
import 'animation_type.dart';

abstract class AppRouter {
  //Start
  static const splashScreen = '/';
  static const appLayoutScreen = '/appLayoutScreen';
  static const searchScreen = '/searchScreen';
  static const memberProfileScreen = '/memberProfileScreen';
  static const editMemberScreen = '/editMemberScreen';
  static const refreshAppScreen = '/refreshAppScreen';

  static final router = GoRouter(
    routes: [
      //splashScreen
      GoRoute(
        path: splashScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const SplashScreen(),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),
      //splashScreen
      GoRoute(
        path: appLayoutScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const AppLayoutScreen(),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),
      //SearchScreen
      GoRoute(
        path: searchScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child:  SearchScreen(serviceType: state.extra as ServiceType,),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),
      //MemberProfileScreen
      GoRoute(
          path: memberProfileScreen,
          pageBuilder: (context, state) {
            UserModel? user = state.extra as UserModel?;
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: MemberProfileScreen(
                user: user,
              ),
              animationType: AnimationType.fadeTransitionAnimation,
            );
          }),
      //RefreshAppScreen
      GoRoute(
          path: refreshAppScreen,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const RefreshAppScreen(),
              animationType: AnimationType.fadeTransitionAnimation,
            );
          }),
      //EditMemberScreen
      GoRoute(
          path: editMemberScreen,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child:  EditMemberScreen(user:state.extra as UserModel,),
              animationType: AnimationType.fadeTransitionAnimation,
            );
          }),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required AnimationType animationType,
}) {
  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (animationType) {
          case AnimationType.fadeTransitionAnimation:
            return fadeTransition(animation: animation, child: child);
          case AnimationType.sideTransitionFromDownToUp:
            return sideTransitionFromDownToUp(
                animation: animation, child: child);
          case AnimationType.sideTransitionFromLtoR:
            return sideTransitionFromLtoR(child: child, animation: animation);
          case AnimationType.sideTransitionFromRtoL:
            return sideTransitionFromRtoL(child: child, animation: animation);
          case AnimationType.sideTransitionFromUpToDown:
            return sideTransitionFromUpToDown(
                child: child, animation: animation);
          case AnimationType.sideTransitionFromDownToUpWithFadeTransition:
            return sideTransitionFromDownToUpWithFadeTransition(
                child: child, animation: animation);
          default:
            return fadeTransition(animation: animation, child: child);
        }
      });
}

// void PersistentTo({required widget, required context}) =>
//     PersistentNavBarNavigator.pushNewScreen(
//       context,
//       screen: widget,
//       withNavBar: true, // OPTIONAL VALUE. True by default.
//       pageTransitionAnimation: PageTransitionAnimation.cupertino,
//     );
