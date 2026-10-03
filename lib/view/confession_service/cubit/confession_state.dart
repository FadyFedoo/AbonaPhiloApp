class ConfessionState {}

final class ConfessionInitial extends ConfessionState {}

final class SetState extends ConfessionState {}

final class GetUserLoadingState extends ConfessionState {}

final class GetUserSuccessState extends ConfessionState {}

final class GetUnconfessedUserSuccessState extends ConfessionState {}

final class GetUserErrorState extends ConfessionState {
  final String message;

  GetUserErrorState({required this.message});
}
