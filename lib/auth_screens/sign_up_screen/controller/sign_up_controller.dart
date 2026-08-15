import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
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

    if (password.length < 6) {
      Get.snackbar(
        'Weak Password',
        'Password must be at least 6 characters long.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final AuthResponse response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name},
      );

      final User? user = response.user;

      if (user != null) {
        log('================ SUCCESS: SIGN UP ================');
        log('User ID: ${user.id}');
        log('Email: ${user.email}');
        log('Full Name: $name');

        // Save User ID to SharedPreferences via SharedPreferenceService
        await SharedPreferenceService.saveUserId(user.id);
        log('Saved user_id (${user.id}) via SharedPreferenceService!');

        // Insert user profile into public.profiles
        try {
          await Supabase.instance.client.from('profiles').upsert({
            'id': user.id,
            'full_name': name,
            'email': email,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
          log('Profile inserted successfully into public.profiles!');
          log('==================================================');
        } catch (profileError) {
          log('Profile insert error: $profileError');
        }

        if (response.session != null) {
          Get.offAllNamed(AppRoutes.navigationBar);
          Get.snackbar(
            'Account Created!',
            'Welcome to Personal Wallet.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          // Email confirmation is required by Supabase auth settings
          Get.offAllNamed(AppRoutes.logInScreen);
          Get.snackbar(
            'Registration Successful!',
            'Please check your email to confirm your account before logging in.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        }
      }
    } on AuthException catch (e) {
      log('================ FAILED: SIGN UP ================');
      log('AuthException: ${e.message}');
      log('==================================================');
      Get.snackbar(
        'Sign Up Failed',
        e.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      log('================ ERROR: SIGN UP ================');
      log('Error: $e');
      log('==================================================');
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

