import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/core/app_strings/app_strings.dart';
import 'package:fr_philopater/core/enums.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_model.dart';
import '../../../repositories/users_repo/users_repo.dart';
import 'add_new_member_state.dart';

class AddNewMemberCubit extends Cubit<AddNewMemberState> {
  AddNewMemberCubit({required this.usersRepo}) : super(AddNewMemberInitial());
  final UsersRepo usersRepo;

  AddNewMemberCubit get(context) => BlocProvider.of(context);

  ServiceType selectedService = ServiceType.confessions;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var jobController = TextEditingController();
  var addressController = TextEditingController();
  var notesController = TextEditingController();
  var wifeNameController = TextEditingController();
  var aboutChildrenController = TextEditingController();
  var lastConfessionDateController = TextEditingController();
  var birthdayDateController = TextEditingController();
  var marriageDateController = TextEditingController();
  var addictionTypeController = TextEditingController();
  var materialTypeController = TextEditingController();
  var addictionStartDateController = TextEditingController();
  var previousSetbacksController = TextEditingController();
  var lastRecoveryDateController = TextEditingController();
  DateTime? lastConfessionDate;
  DateTime? birthdayDate;
  DateTime? marriageDate;
  DateTime? addictionStartDate;
  DateTime? lastRecoveryDate;

  String maritalStatus = AppStrings.single;
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        setState();
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
      setState();
    }
  }

  void removeImage() {
    image = null;
    setState();
  }

  void setState() {
    emit(SetState());
  }

  uploadImageToFirebase() async {
    if (image != null) {
      emit(UploadImageToFirebaseLoadingState());
      var result = await usersRepo.uploadUserImageToFireBase(image: image!);
      result.fold(
        (l) {
          emit(UploadImageToFirebaseFailureState(message: l.message));
        },
        (r) {
          emit(UploadImageToFirebaseSuccessState(imageUrl: r));
        },
      );
    }
  }

  addNewMember({required String imageUrl}) async {
    emit(AddNewMemberLoadingState());
    UserModel data = UserModel(
      image: imageUrl,
      serviceType: selectedService.name,
      name: nameController.text,
      phone: phoneController.text,
      job: jobController.text,
      address: addressController.text,
      birthdate: birthdayDate,
      birthdateDay: birthdayDate?.day,
      birthdateMonth: birthdayDate?.month,
      marriageDateDay: marriageDate?.day,
      marriageDateMonth: marriageDate?.month,
      lastConfessionDate: lastConfessionDate,
      notes: notesController.text,
      wifeName: wifeNameController.text,
      aboutChildren: aboutChildrenController.text,
      maritalStatus: maritalStatus,
      addictionType: addictionTypeController.text,
      materialType: materialTypeController.text,
      previousSetbacks: previousSetbacksController.text,
      addictionStartDate: addictionStartDate,
      lastRecoveryDate: lastRecoveryDate,
      marriageDate: marriageDate,
      createdAt: DateTime.now(),
    );
    var result = await usersRepo.addNewUser(data: data);

    result.fold(
      (l) {
        emit(AddNewMemberFailureState(message: l.message));
      },
      (r) {
        emit(AddNewMemberSuccessState());
      },
    );
  }
}
