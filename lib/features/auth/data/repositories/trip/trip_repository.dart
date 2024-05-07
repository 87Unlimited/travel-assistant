import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/exceptions/format_exceptions.dart';
import 'package:travel_assistant/core/util/exceptions/platform_exceptions.dart';
import 'package:travel_assistant/features/auth/data/repositories/authentication/authentication_repository.dart';

import '../../../../../core/util/exceptions/firebase_exceptions.dart';
import '../../models/day_model.dart';
import '../../models/trip_model.dart';
import '../../models/user_model.dart';

class TripRepository extends GetxController {
  static TripRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save trip data to Firestore
  Future<String> saveTripRecordAndReturnId(TripModel trip) async {
    try {
      DocumentReference docRef = await _db.collection("Trips").add(trip.toJson());
      String documentId = docRef.id;
      return documentId;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. PLease try again";
    }
  }

  /// Function to save trip data to Firestore
  Future<void> saveDaysRecord(DayModel day) async {
    try {
      await _db.collection("Trips").doc(day.tripId).collection("Days").add(day.toJson());
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. PLease try again";
    }
  }

  /// Function to fetch trip details based on user ID.
  Future<List<TripModel>> getHomeViewTrips() async {
    try {
      final snapshot = await _db.collection("Trips").where('UserId', isEqualTo: AuthenticationRepository.instance.authUser?.uid).get();
      return snapshot.docs.map((e) => TripModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. PLease try again";
    }
  }

  // Function to update data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. PLease try again";
    }
  }

  // Update any field in specific Users collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. PLease try again";
    }
  }

  // Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CustomFormatException();
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. PLease try again";
    }
  }

  // Upload any Image
  Future<String?> uploadImage(XFile image) async {
    const path = "assets/images";
    final ref = FirebaseStorage.instance.ref(path).child(image.name);
    try {
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<UserModel>> allUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e))
        .toList();
    return userData;
  }
}