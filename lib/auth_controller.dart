import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  User? get user => firebaseUser.value;

  // ---------------- GOOGLE LOGIN ----------------
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.snackbar(
        backgroundColor: Colors.green,
        "Login Successful",
        "You have logged in with Google",
        colorText: Colors.white,
      );
    } catch (e) {
      print("Error during Google sign-in: $e");
      // Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.snackbar(
          "Login Successful ",
          "You have logged in with Facebook",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Login Failed",
          result.message ?? "Unknown error",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("error = $e");
      // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      Get.snackbar(
        "Login Successful",
        "You have logged in with Facebook",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  // ---------------- SIGN OUT ----------------
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut().then(
      (value) => Get.snackbar(
        backgroundColor: Colors.green,
        "Logout Successful",
        "You have logged out",
        colorText: Colors.white,
      ),
    );
    await FacebookAuth.instance.logOut();
  }
}
