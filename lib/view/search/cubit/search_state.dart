class SearchState {}

final class SearchInitial extends SearchState {}

final class SetState extends SearchState {}

final class GetUserLoadingState extends SearchState {}

final class GetUserSuccessState extends SearchState {}

final class GetUserErrorState extends SearchState {
  final String message;

  GetUserErrorState({required this.message});
}
