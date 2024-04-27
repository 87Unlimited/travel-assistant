import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/exceptions/format_exceptions.dart';
import 'package:travel_assistant/core/util/exceptions/platform_exceptions.dart';

import '../../../../../common/widgets/snackbar.dart';
import '../../../../../core/util/exceptions/firebase_exceptions.dart';
import '../../../domain/entities/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  Future createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson()).whenComplete(() {
      return CustomSnackbar();
    }).catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red
      );
      print("ERROR - $error");
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e))
        .toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson()).whenComplete(() {
      Get.snackbar(
        "Success",
        "Your profile has been updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withOpacity(0.3),
        colorText: Colors.white,
      );
    }).catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red
      );
      print("ERROR - $error");
    });
  }

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

  updateSingleField(Map<String, dynamic> json, UserModel user) async {
    await _db.collection("Users").doc(user.id).update(json).whenComplete((){
      Get.snackbar(
        "Success",
        "Your profile has been updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withOpacity(0.3),
        colorText: Colors.white,
      );
    }).catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red
      );
      print("ERROR - $error");
    });
  }
}