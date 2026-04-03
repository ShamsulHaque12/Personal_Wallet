import 'package:get/get.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/theme/app_images.dart';

class ProfileController extends GetxController {
  // Static data for now as per the design specs
  final String userName = 'MD Sujon Islam';
  final String userGmail = '25030024@gmail.com';
  final String profileImage = AppImages.track;

  // Navigation or action logic for menu items
  void onEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  void onSecurity() {
    print('Security tapped');
  }

  void onSetting() {
    print('Setting tapped');
  }

  void onHelp() {
    print('Help tapped');
  }

  void onLogout() {
    print('Logout tapped');
  }
}
