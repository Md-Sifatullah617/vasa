import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vasa/utils/custom_widgets/custom_toast.dart';
import 'package:vasa/utils/secured_data.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  var iscPasswordVisible = false.obs;
  RxBool obscureText = false.obs;
  var isAgreeTerms = false.obs;
  var isLoading = false.obs;
  Stream<User?>? userStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void changePasswordVisibility(bool pwd) {
    pwd
        ? isPasswordVisible.value = !isPasswordVisible.value
        : iscPasswordVisible.value = !iscPasswordVisible.value;
    obscureText.value = !obscureText.value;
    update();
  }

  void changeAgreeTerms() {
    isAgreeTerms.value = !isAgreeTerms.value;
    update();
  }

  Future<void> googleSignIn() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        Get.offAllNamed("/home");
        final userData = {
          "name": user.displayName,
          "email": user.email,
          "profilePic": user.photoURL,
          "uid": user.uid,
          "createdAt": DateTime.now().toIso8601String(),
          "lastSeen": DateTime.now().toIso8601String(),
          "phoneNumber": user.phoneNumber,
        };
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection("users").doc(user.uid).set(userData);
        }
        await SecureData.writeSecureData(key: "user", value: userData);
      }
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      customToast(msg: e.message!, isError: true);
      print("Error in google sign in $e");
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String fname,
    required String lname,
    required String phone,
  }) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        Get.offAllNamed("/home");
        if (user != null) {
          final userData = {
            "name": "$fname $lname",
            "email": user.email,
            "profilePic": user.photoURL,
            "uid": user.uid,
            "createdAt": DateTime.now().toIso8601String(),
            "lastSeen": DateTime.now().toIso8601String(),
            "phoneNumber": phone,
          };
          if (userCredential.additionalUserInfo!.isNewUser) {
            await _firestore.collection("users").doc(user.uid).set(userData);
          }
          await SecureData.writeSecureData(key: "user", value: userData);
        }
      }
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      customToast(msg: e.message!, isError: true);
      print("Error in email sign in $e");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await SecureData.deleteSecureData(key: "user");
    Get.offAllNamed("/login");
  }
}
