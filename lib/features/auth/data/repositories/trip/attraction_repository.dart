import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/exceptions/format_exceptions.dart';
import 'package:travel_assistant/core/util/exceptions/platform_exceptions.dart';

import '../../../../../core/util/exceptions/firebase_exceptions.dart';
import '../../models/attraction_model.dart';
import '../../models/day_model.dart';

class AttractionRepository extends GetxController {
  static AttractionRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save attraction data to Firestore
  Future<void> saveAttractionRecord(String tripId, String dayId, AttractionModel attraction) async {
    try {
      await _db.collection("Trips").doc(tripId).collection("Days").doc(dayId).collection("Attractions").add(attraction.toJson());
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

  /// Function match the date and return dayId from Firestore
  Future<List<DayModel>> fetchDay(String tripId, Timestamp date) async {
    try {
      final snapshot = await _db.collection("Trips").doc(tripId).collection("Days").where("Date", isEqualTo: date).get();
      return snapshot.docs.map((e) => DayModel.fromSnapshot(e)).toList();
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

  /// Function to fetch all attractions based on day ID.
  Future<List<AttractionModel>> fetchAttractionsByDayId(String tripId, String dayId) async {
    try {
      final snapshot = await _db
          .collection("Trips")
          .doc(tripId)
          .collection("Days")
          .doc(dayId)
          .collection("Attractions")
          .get();
      return snapshot.docs.map((e) => AttractionModel.fromSnapshot(e)).toList();
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

  /// Function to fetch all attractions based on day ID.
  Future<List<AttractionModel>> fetchAllAttractions(String tripId, String dayId) async {
    try {
      final snapshot = await _db
          .collection("Trips")
          .doc(tripId)
          .collection("Days")
          .doc(dayId)
          .collection("Attractions")
          .get();
      return snapshot.docs.map((e) => AttractionModel.fromSnapshot(e)).toList();
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

  /// Function to delete specific attraction.
  Future<void> deleteAttraction(String tripId, String dayId, String attractionId) async {
    try {
      await _db
          .collection("Trips")
          .doc(tripId)
          .collection("Days")
          .doc(dayId)
          .collection("Attractions")
          .doc(attractionId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}