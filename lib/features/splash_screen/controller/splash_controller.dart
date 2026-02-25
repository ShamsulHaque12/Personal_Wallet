import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:personal_wallet/route/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToOnboardingScreen();
  }
  void navigateToOnboardingScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.onboardingScreen);
    });
  }
}