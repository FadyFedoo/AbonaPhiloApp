sealed class EditMemberState {}

final class EditMemberInitial extends EditMemberState {}

final class SetState extends EditMemberState {}

final class UploadImageToFirebaseLoadingState extends EditMemberState {}

final class UploadImageToFirebaseSuccessState extends EditMemberState {
  final String imageUrl;

  UploadImageToFirebaseSuccessState({required this.imageUrl});
}

final class UploadImageToFirebaseFailureState extends EditMemberState {
  final String message;

  UploadImageToFirebaseFailureState({required this.message});
}

final class EditMemberLoadingState extends EditMemberState {}

final class EditMemberSuccessState extends EditMemberState {}

final class EditMemberFailureState extends EditMemberState {
  final String message;

  EditMemberFailureState({required this.message});
}
