import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/onboarding_screen/controller/onboarding_controller.dart';
import 'package:personal_wallet/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          /// PageView
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.onboardingList.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (context, index) {
              final item = controller.onboardingList[index];
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(item.image, height: 300.h),
                    SizedBox(height: 24.h),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          /// Skip Button (hide on last page)
          Positioned(
            top: 80.h,
            right: 24,
            child: Obx(() {
              if (controller.currentIndex.value ==
                  controller.onboardingList.length - 1) {
                return const SizedBox();
              }
              return GestureDetector(
                onTap: controller.skip,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),
          ),

          /// Bottom Indicator + Button
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                /// Indicator
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.onboardingList.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.currentIndex.value == index ? 24 : 8,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == index
                              ? Colors.black
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                /// Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        controller.currentIndex.value ==
                                controller.onboardingList.length - 1
                            ? 'Get Started'
                            : 'Continue',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
