class AddictiveState {}

final class AddictiveInitial extends AddictiveState {}

final class SetState extends AddictiveState {}

final class GetUserLoadingState extends AddictiveState {}

final class GetUserSuccessState extends AddictiveState {}

final class GetUserErrorState extends AddictiveState {
  final String message;

  GetUserErrorState({required this.message});
}
