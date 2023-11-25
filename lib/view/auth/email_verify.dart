import 'package:flutter/material.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Text("Email Verification"),
          Text("Please verify your email"),
          Text("We have sent you an email with a link to verify your account"),
          Text(
              "If you do not receive the email within a few minutes, please check your spam folder or try again"),
          Text(
              "If you entered an incorrect email address, you can change it and send another verification email"),
        ]),
      ),
    );
  }
}
