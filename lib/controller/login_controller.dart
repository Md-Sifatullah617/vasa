import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  RxBool obscureText = false.obs;
  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
    obscureText.value = !obscureText.value;
  }
}
