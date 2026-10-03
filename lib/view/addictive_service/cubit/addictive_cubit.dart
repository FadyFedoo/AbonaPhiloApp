import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/models/user_model.dart';
import 'package:fr_philopater/repositories/users_repo/users_repo.dart';

import 'addictive_state.dart';

class AddictiveCubit extends Cubit<AddictiveState> {
  AddictiveCubit({required this.usersRepo}) : super(AddictiveInitial());
  final UsersRepo usersRepo;

  static AddictiveCubit get(context) => BlocProvider.of(context);


  var scrollController = ScrollController();

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
        return UserModel.fromJson (  json:  doc.data() as Map<String, dynamic>,documentId: doc.id);
      }).toList();
      if (data.isNotEmpty) {
        if(isFirstTime){
          users=data;
        }else{
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
        getUsers(isFirstTime: false, serviceType: serviceType);
      }
    });
  }
}
