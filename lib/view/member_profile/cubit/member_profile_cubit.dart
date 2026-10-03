import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/repositories/users_repo/users_repo.dart';

import 'member_profile_state.dart';

class MemberProfileCubit extends Cubit<MemberProfileState> {
  MemberProfileCubit({required this.usersRepo}) : super(MemberProfileInitial());
  final UsersRepo usersRepo;

  static MemberProfileCubit get(context) => BlocProvider.of(context);

  deleteUser({required String id}) async {
    emit(DeleteUserLoadingState());

    var result = await usersRepo.deleteUser(id: id);

    result.fold(
      (l) {
        emit(DeleteUserErrorState(message: l.message));
      },
      (r) {
        emit(DeleteUserSuccessState());
      },
    );
  }

  deleteUserImage({required String id,required String image}) async {
    emit(DeleteUserLoadingState());
    var result = await usersRepo.deleteUserImage(imageUrl: image);
    result.fold(
      (l) {
        emit(DeleteUserErrorState(message: l.message));
      },
      (r) {
        deleteUser(id: id);
      },
    );
  }

  updateUserConfessionDate({required String id,required DateTime date}) async {
    emit(UpdateUserConfessionDateLoadingState());

    var result = await usersRepo.updateUserConfessionDate(id: id,date: date);

    result.fold(
      (l) {
        emit(UpdateUserConfessionDateErrorState(message: l.message));
      },
      (r) {
        emit(UpdateUserConfessionDateSuccessState());
      },
    );
  }


  setState(){
    emit(SetState());
  }
}
