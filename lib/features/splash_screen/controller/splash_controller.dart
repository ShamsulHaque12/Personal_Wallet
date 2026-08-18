import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkAuthAndNavigate();
  }

  Future<void> checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final currentUser = Supabase.instance.client.auth.currentUser;
    String? userId = currentUser?.id;
    userId ??= await SharedPreferenceService.getUserId();

    if (currentUser != null || (userId != null && userId.isNotEmpty)) {
      Get.offAllNamed(AppRoutes.navigationBar);
    } else {
      Get.offAllNamed(AppRoutes.onboardingScreen);
    }
  }
}