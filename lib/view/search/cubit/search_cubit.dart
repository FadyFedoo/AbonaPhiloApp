import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/models/user_model.dart';
import 'package:fr_philopater/repositories/users_repo/users_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.usersRepo}) : super(SearchInitial());
  final UsersRepo usersRepo;

  static SearchCubit get(context) => BlocProvider.of(context);

  var scrollController = ScrollController();
  var searchController = TextEditingController();

  List<UserModel>? users;

  Future<void> searchUsers({
    required String serviceType,
  }) async {
    emit(GetUserLoadingState());
    var result = await usersRepo.searchUsers(
        serviceType: serviceType, searchKey: searchController.text);
    result.fold((failure) {
      emit(GetUserErrorState(message: failure.message));
    }, (r) {
      users = r;
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
        // getUsers(serviceType: serviceType,);
      }
    });
  }
}
