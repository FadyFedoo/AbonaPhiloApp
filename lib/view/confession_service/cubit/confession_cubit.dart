import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/models/user_model.dart';
import 'package:fr_philopater/repositories/users_repo/users_repo.dart';

import '../../../core/enums.dart';
import '../../../core/notification_helper/notification_service.dart';
import 'confession_state.dart';

class ConfessionCubit extends Cubit<ConfessionState> {
  ConfessionCubit({required this.usersRepo}) : super(ConfessionInitial());
  final UsersRepo usersRepo;

  static ConfessionCubit get(context) => BlocProvider.of(context);

  var scrollController = ScrollController();
  Period selectedPeriod = Period.all;

  List<UserModel>? users;

  DocumentSnapshot? lastDocument;
  int perPage = 10;
  bool gettingMoreUsers = false;
  bool hasMore = true;

  Future<void> getUsers({
    bool isFirstTime = true,
    required String serviceType,
  }) async {
    if (gettingMoreUsers) return;
    if (isFirstTime) {
      users = null;
      lastDocument = null;
      hasMore = true;
    }
    if (!hasMore) return;

    gettingMoreUsers = true;
    emit(GetUserLoadingState());

    var result = await usersRepo.getUsers(
        perPage: perPage, serviceType: serviceType, lastDocument: lastDocument);
    result.fold((failure) {
      gettingMoreUsers = false;
      emit(GetUserErrorState(message: failure.message));
    }, (r) {
      List<UserModel> data = r.docs.map((doc) {
        return UserModel.fromJson(
            json: doc.data() as Map<String, dynamic>, documentId: doc.id);
      }).toList();
      if (data.isNotEmpty) {
        if (isFirstTime) {
          users = data;
        } else {
          users?.addAll(data);
        }
        lastDocument = r.docs[r.docs.length - 1];
        hasMore = data.length == perPage;
      } else {
        users=[];
        hasMore = false;
      }

      gettingMoreUsers = false;
      emit(GetUserSuccessState());
    });
  }

  void startScrollingListener({
    required String serviceType,
  }) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.8 &&
          users != null) {
        if (selectedPeriod == Period.all) {
          getUsers(isFirstTime: false, serviceType: serviceType);
        }
      }
    });
  }

  List<UserModel>? usersWithFortyDaysPeriod;

  getUsersWithFortyDaysPeriod({
    required String serviceType,
  }) async {
    var result = await usersRepo.getUnconfessedUsersSince(
      days: 40,
      serviceType: serviceType,
    );
    result.fold((failure) {
      emit(GetUserErrorState(message: failure.message));
    }, (r) {
      usersWithFortyDaysPeriod = r;
      showLocalNotificationForUnconfessedUser(data: r!,days: 40);
      emit(GetUnconfessedUserSuccessState());
    });
  }

  List<UserModel>? usersWithSixtyDaysPeriod;

  getUsersWithSixtyDaysPeriod({
    required String serviceType,
  }) async {
    var result = await usersRepo.getUnconfessedUsersSince(
      days: 60,
      serviceType: serviceType,
    );
    result.fold((failure) {
      emit(GetUserErrorState(message: failure.message));
    }, (r) {
      usersWithSixtyDaysPeriod = r;
      showLocalNotificationForUnconfessedUser(data: r!,days: 60);
      emit(GetUnconfessedUserSuccessState());
    });
  }

  List<UserModel>? usersWithHundredDaysPeriod;

  getUsersWithHundredDaysPeriod({
    required String serviceType,
  }) async {
    var result = await usersRepo.getUnconfessedUsersSince(
      days: 100,
      serviceType: serviceType,
    );
    result.fold((failure) {
      emit(GetUserErrorState(message: failure.message));
    }, (r) {
      usersWithHundredDaysPeriod = r;
      showLocalNotificationForUnconfessedUser(data: r!,days: 100);
      emit(GetUnconfessedUserSuccessState());
    });
  }

  getUsersWithBirthdayToday() async {
    var result = await usersRepo.getUsersWithBirthdayToday();
    result.fold((failure) {
      emit(GetUserErrorState(message: failure.message));
    }, (r) {
      showLocalNotificationForUserHaveBirthday(data: r!);
    });
  }

  getUsersWithMarriageDateToday() async {
    var result = await usersRepo.getUsersWithMarriageDateToday();
    result.fold((failure) {
      emit(GetUserErrorState(message: failure.message));
    }, (r) {
      showLocalNotificationForUserHaveMarriageDateToday(data: r!);
    });
  }

  showLocalNotificationForUnconfessedUser(
      {required List<UserModel> data, required int days}) {
    for (var user in data) {
      NotificationsService.showNotification(
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: user.image,
        channelKey: 'firebase key',
        title: user.name,
        body: "$days يوم مر منذ اخر اعتراف ",
        payload: {
          'case': "user",
          'info': jsonEncode(user),
        },
      );
    }
  }

  showLocalNotificationForUserHaveBirthday(
      {required List<UserModel> data}) {
    for (var user in data) {
      NotificationsService.showNotification(
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: user.image,
        channelKey: 'firebase key',
        title: user.name,
        body: "اليوم عيد ميلاد ",
        payload: {
          'case': "user",
          'info': jsonEncode(user),
        },
      );
    }
  }

  showLocalNotificationForUserHaveMarriageDateToday(
      {required List<UserModel> data}) {
    for (var user in data) {
      NotificationsService.showNotification(
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: user.image,
        channelKey: 'firebase key',
        title: user.name,
        body: "اليوم عيد زواج ",
        payload: {
          'case': "user",
          'info': jsonEncode(user),
        },
      );
    }
  }

  void setState() {
    emit(SetState());
  }
}
