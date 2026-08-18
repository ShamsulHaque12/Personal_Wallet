import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';

class LogInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final AuthResponse response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      final User? user = response.user;

      if (user != null) {
        log('================ SUCCESS: LOG IN ================');
        log('User ID: ${user.id}');
        log('Email: ${user.email}');

        // Save User ID via SharedPreferenceService
        await SharedPreferenceService.saveUserId(user.id);
        log('Saved user_id (${user.id}) via SharedPreferenceService!');
        log('=================================================');

        Get.offAllNamed(AppRoutes.navigationBar);
        Get.snackbar(
          'Welcome Back!',
          'Logged in successfully.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on AuthException catch (e) {
      log('================ FAILED: LOG IN ================');
      log('AuthException: ${e.message}');
      log('================================================');
      Get.snackbar(
        'Login Failed',
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      log('================ ERROR: LOG IN ================');
      log('Error: $e');
      log('================================================');
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
