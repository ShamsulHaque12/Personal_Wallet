import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/onboarding_screen/model/onboarding_model.dart';
import 'package:personal_wallet/route/app_routes.dart';
import 'package:personal_wallet/theme/app_images.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final currentIndex = 0.obs;

  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: AppImages.wallet1,
      title: 'Track Your Expenses',
      description:
          'Easily record and categorize your daily expenses to understand your spending habits.',
    ),
    OnboardingModel(
      image: AppImages.wallet2,
      title: 'Plan Your Budget',
      description:
          'Set monthly budgets and stay in control of your money with smart planning.',
    ),
    OnboardingModel(
      image: AppImages.wallet3,
      title: 'Achieve Financial Goals',
      description:
          'Save smarter and reach your financial goals with clear insights.',
    ),
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < onboardingList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed(AppRoutes.logInScreen);
    }
  }

  void skip() {
    Get.offNamed(AppRoutes.logInScreen);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}