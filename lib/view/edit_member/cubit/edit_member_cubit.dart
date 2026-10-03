import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/core/app_strings/app_strings.dart';
import 'package:fr_philopater/core/enums.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../models/user_model.dart';
import '../../../repositories/users_repo/users_repo.dart';
import 'edit_member_state.dart';

class EditMemberCubit extends Cubit<EditMemberState> {
  EditMemberCubit({required this.usersRepo}) : super(EditMemberInitial());
  final UsersRepo usersRepo;

  EditMemberCubit get(context) => BlocProvider.of(context);

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

  editMember({required String imageUrl,required String docId,String? oldImage}) async {
    emit(EditMemberLoadingState());
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
      // createdAt: DateTime.now(),
    );
    var result = await usersRepo.editUser(data: data,docId: docId);

    result.fold(
      (l) {
        emit(EditMemberFailureState(message: l.message));
      },
      (r) async {
        if(oldImage!=null){
          await deleteUserImage(image: oldImage);
        }
        emit(EditMemberSuccessState());
      },
    );
  }

  deleteUserImage({required String image}) async {
    var result = await usersRepo.deleteUserImage(imageUrl: image);
  }

  resetData({required UserModel user}) {
    if (user.serviceType == ServiceType.confessions.name) {
      selectedService = ServiceType.confessions;
    } else {
      selectedService = ServiceType.addictive;
    }
    nameController.text = user.name ?? "";
    phoneController.text = user.phone ?? "";
    jobController.text = user.job ?? "";
    addressController.text = user.address ?? "";
    if (user.birthdate != null) {
      birthdayDate = user.birthdate;
      birthdayDateController.text =
          DateFormat('yyyy-MM-dd').format(user.birthdate!).toString();
    }
    if (user.lastConfessionDate != null) {
      lastConfessionDate = user.lastConfessionDate;
      lastConfessionDateController.text =
          DateFormat('yyyy-MM-dd').format(user.lastConfessionDate!).toString();
    }
    if (user.maritalStatus == AppStrings.single) {
      maritalStatus = AppStrings.single;
    } else {
      maritalStatus = AppStrings.married;
    }

    if (user.marriageDate != null) {
      marriageDate = user.marriageDate;
      marriageDateController.text =
          DateFormat('yyyy-MM-dd').format(user.marriageDate!).toString();
    }

    wifeNameController.text=user.wifeName?? "";
    aboutChildrenController.text = user.aboutChildren?? "";
    notesController.text = user.notes?? "";

    addictionTypeController.text = user.addictionType?? "";
    materialTypeController.text = user.materialType?? "";
    previousSetbacksController.text = user.previousSetbacks?? "";
    if (user.addictionStartDate != null) {
      addictionStartDate = user.addictionStartDate;
      addictionStartDateController.text =
          DateFormat('yyyy-MM-dd').format(user.addictionStartDate!).toString();
    }
    if (user.lastRecoveryDate != null) {
      lastRecoveryDate = user.lastRecoveryDate;
      lastRecoveryDateController.text =
          DateFormat('yyyy-MM-dd').format(user.lastRecoveryDate!).toString();
    }


  }
}
