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
  RxBool obscureText1 = true.obs;
  var obscureText2 = true.obs;
  var isAgreeTerms = false.obs;
  var isLoading = false.obs;
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController cpwdController = TextEditingController();
  User? verifyUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    pwdController.dispose();
    cpwdController.dispose();
    obscureText1.close();
    obscureText2.close();
    super.dispose();
  }

  void changePasswordVisibility(bool pwd) {
    pwd
        ? isPasswordVisible.value = !isPasswordVisible.value
        : iscPasswordVisible.value = !iscPasswordVisible.value;
    !pwd
        ? obscureText2.value = !obscureText2.value
        : obscureText1.value = !obscureText1.value;
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

  Future<void> signUpWithEmailAndPassword() async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: pwdController.text);
      User? user = userCredential.user;
      if (user != null && userCredential.additionalUserInfo!.isNewUser) {
        verifyUser = user;
        final userData = {
          "name": "${fnameController.text} ${lnameController.text}",
          "email": emailController.text,
          "profilePic": verifyUser!.photoURL,
          "uid": verifyUser!.uid,
          "createdAt": DateTime.now().toIso8601String(),
          "lastSeen": DateTime.now().toIso8601String(),
          "phoneNumber": "+880${phoneController.text}",
          "password": pwdController.text,
        };
        await _firestore
            .collection("users")
            .doc(verifyUser!.uid)
            .set(userData)
            .then((value) async {
          await SecureData.writeSecureData(key: "user", value: userData);
          isLoading.value = false;
        });
        Get.offAllNamed("/verify");
      }
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      customToast(msg: e.message!, isError: true);
      print("Error in email sign in $e");
    }
  }

  Future<void> verifyEmail() async {
    try {
      isLoading.value = true;
      await verifyUser!.sendEmailVerification();
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
