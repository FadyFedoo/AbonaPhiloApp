import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fr_philopater/core/app_localiziations/app_localizations.dart';

import '../app_router/routes.dart';
import '../app_strings/app_strings.dart';

BuildContext? context =
    AppRouter.router.routerDelegate.navigatorKey.currentContext;

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(AppStrings.connectionTimeOut.tr(context!));
      case DioExceptionType.sendTimeout:
        return ServerFailure(AppStrings.sendTimeOut.tr(context!));
      case DioExceptionType.receiveTimeout:
        return ServerFailure(AppStrings.receiveTimeOut.tr(context!));
      case DioExceptionType.badCertificate:
        return ServerFailure(AppStrings.badCer.tr(context!));
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(e.response!.statusCode!, e.response!);
      case DioExceptionType.cancel:
        return ServerFailure(AppStrings.requestCancelled.tr(context!));
      case DioExceptionType.connectionError:
        return ServerFailure(AppStrings.noInternetConnection.tr(context!));
      case DioExceptionType.unknown:
        return ServerFailure(AppStrings.oppsThereWasAnError.tr(context!));
    }
  }

  factory ServerFailure.fromResponse(
      int statusCode, Response<dynamic>? response) {
    if (statusCode == 404) {
      return ServerFailure(AppStrings.yourRequestNotFound.tr(context!));
    } else if (statusCode == 500) {
      return ServerFailure(AppStrings.serverProblem.tr(context!));
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      try {
        if (response!.data.toString().contains('message:') &&
            response.data.toString().contains('success:')) {
          return ServerFailure(response.data['message'].toString());
        } else {
          return ServerFailure(AppStrings.somethingWentWrong.tr(context!));
        }
      } catch (e) {
        return ServerFailure(AppStrings.somethingWentWrong.tr(context!));
      }
    } else {
      return ServerFailure(AppStrings.somethingWentWrong.tr(context!));
    }
  }


  factory ServerFailure.fromFirebaseException(FirebaseException e) {
    return ServerFailure(e.message??"Unknown Firebase Exception");
  }
}
