import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';

class ProfileController extends GetxController {
  final userName = ''.obs;
  final userGmail = ''.obs;
  final avatarUrl = ''.obs;
  final isLoading = false.obs;

  // Reactive Stats for a professional feel
  final totalBalance = '\$12,480.00'.obs;
  final monthlySavings = '\$1,250.00'.obs;
  final accountStatus = 'Pro Member'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        userGmail.value = user.email ?? '';
        try {
          final data = await Supabase.instance.client
              .from('profiles')
              .select()
              .eq('id', user.id)
              .maybeSingle();

          if (data != null) {
            userName.value = data['full_name'] ?? (user.userMetadata?['full_name'] ?? '');
            avatarUrl.value = data['avatar_url'] ?? '';
          } else {
            userName.value = user.userMetadata?['full_name'] ?? '';
          }
        } catch (e) {
          userName.value = user.userMetadata?['full_name'] ?? '';
        }
      } else {
        final savedUserId = await SharedPreferenceService.getUserId();
        if (savedUserId != null) {
          try {
            final data = await Supabase.instance.client
                .from('profiles')
                .select()
                .eq('id', savedUserId)
                .maybeSingle();

            if (data != null) {
              userName.value = data['full_name'] ?? '';
              userGmail.value = data['email'] ?? '';
              avatarUrl.value = data['avatar_url'] ?? '';
            }
          } catch (e) {
            debugPrint('Error fetching profile: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching user profile in ProfileController: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation or action logic for menu items
  void onEditProfile() {
    Get.toNamed(AppRoutes.editProfile)?.then((_) => fetchUserProfile());
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
      onConfirm: () async {
        Get.back(); // Close dialog
        await Supabase.instance.client.auth.signOut();
        await SharedPreferenceService.clearAll();
        Get.offAllNamed(AppRoutes.logInScreen);
      },
    );
  }
}


