sealed class AddNewMemberState {}

final class AddNewMemberInitial extends AddNewMemberState {}

final class SetState extends AddNewMemberState {}

final class UploadImageToFirebaseLoadingState extends AddNewMemberState {}

final class UploadImageToFirebaseSuccessState extends AddNewMemberState {
  final String imageUrl;

  UploadImageToFirebaseSuccessState({required this.imageUrl});
}

final class UploadImageToFirebaseFailureState extends AddNewMemberState {
  final String message;

  UploadImageToFirebaseFailureState({required this.message});
}

final class AddNewMemberLoadingState extends AddNewMemberState {}

final class AddNewMemberSuccessState extends AddNewMemberState {}

final class AddNewMemberFailureState extends AddNewMemberState {
  final String message;

  AddNewMemberFailureState({required this.message});
}
