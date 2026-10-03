class MemberProfileState {}

final class MemberProfileInitial extends MemberProfileState {}

final class SetState extends MemberProfileState {}

final class DeleteUserLoadingState extends MemberProfileState {}

final class DeleteUserSuccessState extends MemberProfileState {}

final class DeleteUserErrorState extends MemberProfileState {
  final String message;

  DeleteUserErrorState({required this.message});
}

final class UpdateUserConfessionDateLoadingState extends MemberProfileState {}

final class UpdateUserConfessionDateSuccessState extends MemberProfileState {}

final class UpdateUserConfessionDateErrorState extends MemberProfileState {
  final String message;

  UpdateUserConfessionDateErrorState({required this.message});
}
