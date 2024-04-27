import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';
import 'package:travel_assistant/features/auth/presentation/views/register/register_view.dart';
import 'package:travel_assistant/features/auth/presentation/views/register/verify_email/verify_email_view.dart';
import 'package:travel_assistant/navigation_menu.dart';

import '../../../../../core/util/exceptions/firebase_auth_exceptions.dart';
import '../../../../../core/util/exceptions/firebase_exceptions.dart';
import '../../../../../core/util/exceptions/format_exceptions.dart';
import '../../../../../core/util/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    // Remove splash screen
    FlutterNativeSplash.remove();
    // Redirect to screen
    screenRedirect();
  }

  /// Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if(user != null) {
      if(user.emailVerified){
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailView(email: _auth.currentUser?.email,));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      // Check if first time launching app
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginView())
          : Get.offAll(const RegisterView());
    }
  }

  /* ------------------------- Email & Password sign-in ------------------------- */

  /// [EmailAuthentication] - SignIn

  /// [EmailAuthentication] - Register
  Future<UserCredential?> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
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

  /// [EmailVerification] - Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
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

  /// [LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(e.code).message;
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