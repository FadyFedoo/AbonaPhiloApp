import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fr_philopater/models/user_model.dart';
import 'package:go_router/go_router.dart';
import '../app_router/routes.dart';

void notificationOnTap(
    {required String? type, required String? info, BuildContext? ctx}) async {
  BuildContext? context =
      ctx ?? AppRouter.router.routerDelegate.navigatorKey.currentContext!;
  if (type == null || type.isEmpty) {
    return;
  }
  switch (type) {
    case 'user':
      Map<String, dynamic> userMap = jsonDecode(info.toString());
      UserModel userModel = UserModel.fromJson(json: userMap);
      GoRouter.of(context).push(AppRouter.memberProfileScreen,
          extra: userModel);
      break;
    default:
      print('unhandled type: $type');
  }
}
