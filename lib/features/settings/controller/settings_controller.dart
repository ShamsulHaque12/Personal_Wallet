import 'package:get/get.dart';


class SettingsController extends GetxController {
  final isNotificationsEnabled = true.obs;
  final selectedLanguage = 'English'.obs;
  final selectedCurrency = 'BDT'.obs;

  void toggleNotifications(bool value) {
    isNotificationsEnabled.value = value;
  }


  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
  }

  void changeCurrency(String curr) {
    selectedCurrency.value = curr;
  }
}
