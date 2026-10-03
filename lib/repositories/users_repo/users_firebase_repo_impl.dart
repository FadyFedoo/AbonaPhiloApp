import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fr_philopater/core/constants.dart';
import 'package:fr_philopater/repositories/users_repo/users_repo.dart';
import '../../core/networks/failures.dart';
import '../../models/user_model.dart';

class UsersFirebaseRepoImpl implements UsersRepo {
  @override
  Future<Either<Failure, String?>> addNewUser({
    required UserModel data,
  }) async {
    try {
      CollectionReference users = firebaseFireStore.collection('users');
      await users.add(data.toJson());
      return right("");
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when addNewUser $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, String?>> editUser({
    required UserModel data,
    required String docId,
  }) async {
    try {
      DocumentReference users =
          firebaseFireStore.collection('users').doc(docId);
      await users.update(data.toJson());
      return right("");
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when editUser $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, String?>> deleteUser({
    required String id,
  }) async {
    try {
      // Get a reference to the user's document
      DocumentReference userDoc = firebaseFireStore.collection('users').doc(id);
      // Delete the user document
      await userDoc.delete();
      return right("");
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when deleteUser $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, String?>> deleteUserImage({
    required String imageUrl,
  }) async {
    try {
      await firebaseStorage.refFromURL(imageUrl).delete();
      return right("");
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when deleteUserImage $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, String?>> updateUserConfessionDate({
    required String id,
    required DateTime date,
  }) async {
    try {
      // Get a reference to the user's document
      DocumentReference userDoc = firebaseFireStore.collection('users').doc(id);
      // Delete the user document
      await userDoc.update({
        'lastConfessionDate': date.toIso8601String(), // Update the field
      });
      return right("");
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when deleteUser $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, QuerySnapshot>> getUsers({
    required int perPage,
    required String serviceType,
    String? searchKey,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      // Get a reference to the collection
      CollectionReference users = firebaseFireStore.collection('users');

      // Build the query with serviceType filter and ordering by createdAt
      Query query = users
          .where('serviceType', isEqualTo: serviceType)
          .orderBy('createdAt', descending: true) // Sorting by createdAt
          .limit(perPage);

      // Add search values to the query
      if (searchKey != null) {
        //   query .startAt([searchKey])
        // .endAt([searchKey + '\uf8ff']);
        query.where('name', isEqualTo: searchKey);
      }
      // Add pagination support based on createdAt value
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      // Execute the query
      QuerySnapshot querySnapshot = await query.get();

      // Convert the query snapshot to a list of UserModel
      /* List<UserModel> usersList = querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();*/

      return right(querySnapshot) /*right(usersList)*/;
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when getUsers $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, List<UserModel>?>> searchUsers({
    required String serviceType,
    String? searchKey,
  }) async {
    try {
      // Get a reference to the collection
      CollectionReference users = firebaseFireStore.collection('users');

      // Build the query with serviceType filter and ordering by createdAt
      Query query = users
          .where('serviceType', isEqualTo: serviceType)
          .orderBy('name')
          .startAt([searchKey]).endAt(['$searchKey\uf8ff']);

      // Execute the query
      QuerySnapshot querySnapshot = await query.get();
      // mapping the data
      List<UserModel> data = querySnapshot.docs.map((doc) {
        return UserModel.fromJson(
            json: doc.data() as Map<String, dynamic>, documentId: doc.id);
      }).toList();
      return right(data);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when search Users $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, List<UserModel>?>> getUnconfessedUsersSince({
    required int days,
    required String serviceType,
  }) async {
    try {
      // Get the current date and subtract days
      DateTime today = DateTime.now();
      DateTime exactlyDaysAgo = today.subtract(Duration(days: days));

      // Format the date to only include the year, month, and day (optional, if you store times as well)
      String formattedDate = DateTime(
              exactlyDaysAgo.year, exactlyDaysAgo.month, exactlyDaysAgo.day)
          .toIso8601String();

      // Get a reference to the collection
      CollectionReference users = firebaseFireStore.collection('users');

      // Build the query with serviceType filter and ordering by createdAt
      Query query = users.where('lastConfessionDate', isEqualTo: formattedDate);

      // Execute the query
      QuerySnapshot querySnapshot = await query.get();
      // mapping the data
      List<UserModel> data = querySnapshot.docs.map((doc) {
        return UserModel.fromJson(
            json: doc.data() as Map<String, dynamic>, documentId: doc.id);
      }).toList();
      return right(data);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when search Users $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, List<UserModel>?>> getUsersWithBirthdayToday() async {
    try {
      // Get today's date
      DateTime today = DateTime.now();
      int todayMonth = today.month;
      int todayDay = today.day;

      // Get a reference to the collection
      CollectionReference users = firebaseFireStore.collection('users');

      // Build the query with serviceType filter and ordering by createdAt
      Query query = users
          .where('birthdateMonth', isEqualTo: todayMonth)
          .where('birthdateDay', isEqualTo: todayDay);
      // Execute the query
      QuerySnapshot querySnapshot = await query.get();
      // mapping the data
      List<UserModel> data = querySnapshot.docs.map((doc) {
        return UserModel.fromJson(
            json: doc.data() as Map<String, dynamic>, documentId: doc.id);
      }).toList();
      return right(data);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when search Users $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }


 @override
  Future<Either<Failure, List<UserModel>?>> getUsersWithMarriageDateToday() async {
    try {
      // Get today's date
      DateTime today = DateTime.now();
      int todayMonth = today.month;
      int todayDay = today.day;

      // Get a reference to the collection
      CollectionReference users = firebaseFireStore.collection('users');

      // Build the query with serviceType filter and ordering by createdAt
      Query query = users
          .where('marriageDateMonth', isEqualTo: todayMonth)
          .where('marriageDateDay', isEqualTo: todayDay);
      // Execute the query
      QuerySnapshot querySnapshot = await query.get();
      // mapping the data
      List<UserModel> data = querySnapshot.docs.map((doc) {
        return UserModel.fromJson(
            json: doc.data() as Map<String, dynamic>, documentId: doc.id);
      }).toList();
      return right(data);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when getUsersWithMarriageDateToday  $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }

  @override
  Future<Either<Failure, String>> uploadUserImageToFireBase({
    required File image,
  }) async {
    try {
      // Create a reference to Firebase Storage
      Reference reference = firebaseStorage
          .ref()
          .child('usersImages/${Uri.file(image.path).pathSegments.last}');
      //Upload the file to firebase
      UploadTask uploadTask = reference.putFile(image);
      // Wait until the upload completes
      TaskSnapshot taskSnapshot = await uploadTask;
      // Get the download URL of the uploaded file
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      // Return the download URL
      return right(downloadUrl);
    } catch (error) {
      if (error is FirebaseException) {
        return left(ServerFailure.fromFirebaseException(error));
      }
      if (kDebugMode) {
        print("Error when uploadUserImageToFireBase $error");
      }
    }
    return left(ServerFailure('Something Went Wrong'));
  }
}
