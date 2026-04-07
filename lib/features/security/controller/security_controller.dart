import 'package:get/get.dart';

class SecurityController extends GetxController {
  final isBiometricEnabled = false.obs;
  final isTwoFactorEnabled = false.obs;
  final isFaceIDEnabled = false.obs;

  void toggleBiometric(bool value) {
    isBiometricEnabled.value = value;
  }

  void toggleTwoFactor(bool value) {
    isTwoFactorEnabled.value = value;
  }

  void toggleFaceID(bool value) {
    isFaceIDEnabled.value = value;
  }

  void onChangePassword() {
    Get.snackbar('Security', 'Change Password flow coming soon.');
  }
}
