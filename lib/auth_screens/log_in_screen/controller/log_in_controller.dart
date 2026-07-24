import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Get.offAllNamed('/navigation-bar');
      Get.snackbar(
        'Welcome Back!',
        'Logged in successfully.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please enter your email and password.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
