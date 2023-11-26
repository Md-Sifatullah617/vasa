import 'package:get/get.dart';
import 'package:vasa/view/screen/first_screen.dart';
import 'package:vasa/view/screen/meetings_history.dart';
import 'package:vasa/view/screen/profile_page.dart';
import 'package:vasa/view/screen/settings_screen.dart';

class CheckboxController extends GetxController {
  var isCheck = false.obs;
  var currentIndex = 0.obs;
  var pages = [
    FirstScreen(),
    const MeetingsDetails(),
    const SettingsPage(),
    ProfileScreen(),
  ];
  void changeStatus() {
    isCheck.value = !isCheck.value;
  }
}
