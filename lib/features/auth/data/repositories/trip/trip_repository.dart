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
import '../../models/flight_model.dart';
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
      throw "$e. PLease try again";
    }
  }

  /// Function to save days data to Firestore
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

  /// Function to delete days data to Firestore
  Future<void> deleteDaysRecord(DayModel day) async {
    try {
      Query query = await _db.collection('Trips').doc(day.tripId).collection('Days').where('Date', isEqualTo: day.date);

      query.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
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

  Future<List<DayModel>> getDaysRecord(DayModel day) async {
    try {
      final snapshot = await _db.collection("Trips").doc(day.tripId).collection("Days").get();
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
  Future<void> updateTripDetails(TripModel trip) async {
    try {
      await _db.collection("Trips").doc(trip.tripId).update(trip.toJson());
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
  Future<void> deleteTrip(TripModel trip) async {
    try {
      await _db.collection("Trips").doc(trip.tripId).delete();
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

  Future<void> addFlightToTripDocument(String tripId, FlightModel flight) async {
    try {
      await _db.collection('Trips').doc(tripId).update(flight.toJson());
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

  Future<List<FlightModel>> getTripFlight() async {
    try {
      final snapshots = await _db.collection("Trips").where('UserId', isEqualTo: AuthenticationRepository.instance.authUser?.uid).where('Flight', isNull: false).get();
      final flights = snapshots.docs.map((snapshot) => FlightModel.fromSnapshot(snapshot)).toList();
      return flights;
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
}