import 'package:get/get.dart';

class CheckboxController extends GetxController {
  var isCheck = false.obs;
  void changeStatus() {
    isCheck.value = !isCheck.value;
  }
}
