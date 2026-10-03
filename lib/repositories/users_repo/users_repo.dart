import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fr_philopater/models/user_model.dart';
import '../../core/networks/failures.dart';

abstract class UsersRepo {
  Future<Either<Failure, String?>> addNewUser({
    required UserModel data,
  });

  Future<Either<Failure, String?>> editUser({
    required UserModel data,
    required String docId,
  });

  Future<Either<Failure, String?>> deleteUser({
    required String id,
  });

  Future<Either<Failure, String?>> deleteUserImage({
    required String imageUrl,
  });

  Future<Either<Failure, String?>> updateUserConfessionDate({
    required String id,
    required DateTime date,
  });

  Future<Either<Failure, QuerySnapshot>> getUsers({
    DocumentSnapshot? lastDocument,
    required int perPage,
    String? searchKey,
    required String serviceType,
  });

  Future<Either<Failure, List<UserModel>?>> searchUsers({
    String? searchKey,
    required String serviceType,
  });

  Future<Either<Failure, List<UserModel>?>> getUnconfessedUsersSince({
    required int days,
    required String serviceType,
  });

  Future<Either<Failure, List<UserModel>?>> getUsersWithBirthdayToday();

  Future<Either<Failure, List<UserModel>?>> getUsersWithMarriageDateToday();

  Future<Either<Failure, String>> uploadUserImageToFireBase({
    required File image,
  });
}
