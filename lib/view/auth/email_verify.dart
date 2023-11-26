import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatelessWidget {
  final User? user;
  const EmailVerification({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            user!.emailVerified
                ? const Icon(Icons.check_circle_outline,
                    size: 100, color: Colors.green)
                : const Icon(Icons.error_outline, size: 100, color: Colors.red),
            const Text("Email Verification"),
            const Text("Please verify your email"),
            const Text(
                "We have sent you an email with a link to verify your account"),
            const Text(
                "If you do not receive the email within a few minutes, please check your spam folder or try again"),
            const Text(
                "If you entered an incorrect email address, you can change it and send another verification email"),
          ]),
    );
  }
}
