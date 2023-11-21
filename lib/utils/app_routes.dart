import 'package:get/get.dart';
import 'package:vasa/view/auth/login_screen.dart';
import 'package:vasa/view/auth/reset_pass.dart';
import 'package:vasa/view/auth/sign_up_screen.dart';
import 'package:vasa/view/dashboard/homepage.dart';

import '../view/splash/splash_screen.dart';

class AppPageroutes {
  static List<GetPage> getPages = [
    GetPage(
      name: "/",
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: "/login",
      page: () => LoginScreen(),
    ),
    GetPage(
      name: "/signup",
      page: () => SignupScreen(),
    ),
    GetPage(
      name: "/resetpass",
      page: () => const ResetPwdWithEmailPhone(),
    ),
    GetPage(
      name: "/home",
      page: () => MyHomePage(),
    ),
  ];
}
