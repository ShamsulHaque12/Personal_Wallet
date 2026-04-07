import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/route/app_routes.dart';

import 'package:personal_wallet/theme/app_images.dart';

class ProfileController extends GetxController {
  // Static data for now as per the design specs
  final String userName = 'MD Sujon Islam';
  final String userGmail = '25030024@gmail.com';
  final String profileImage = AppImages.track;

  // Reactive Stats for a professional feel
  final totalBalance = '\$12,480.00'.obs;
  final monthlySavings = '\$1,250.00'.obs;

  final accountStatus = 'Pro Member'.obs;

  // Navigation or action logic for menu items
  void onEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  void onSecurity() {
    Get.toNamed(AppRoutes.securityScreen);
  }

  void onSetting() {
    Get.toNamed(AppRoutes.settingsScreen);
  }

  void onHelp() {
    Get.toNamed(AppRoutes.helpCenter);
  }


  void onLogout() {
    final context = Get.context!;
    final theme = Theme.of(context);
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: theme.colorScheme.primary,
      onConfirm: () {
        Get.back(); // Close dialog
        Get.offAllNamed(AppRoutes.logInScreen);
      },
    );
  }

}

