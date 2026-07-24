import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/onboarding_screen/controller/onboarding_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          /// PageView with 3D Fold Transition
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.onboardingList.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (context, index) {
              final item = controller.onboardingList[index];
              return Obx(() {
                final pageOffset = index - controller.scrollPosition.value;
                // Calculate 3D book-fold page turn rotation and scaling
                final double rotateY = pageOffset * -0.35;
                final double scale = (1.0 - pageOffset.abs() * 0.15).clamp(0.85, 1.0);
                final double opacity = (1.0 - pageOffset.abs() * 0.8).clamp(0.0, 1.0);

                return Transform.scale(
                  scale: scale,
                  child: Transform(
                    alignment: pageOffset < 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // perspective
                      ..rotateY(rotateY),
                    child: Opacity(
                      opacity: opacity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tilt3DContainer(
                            child: Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.03),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Image.asset(item.image, height: 280.h),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            item.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          },
          ),

          /// Skip Button (hide on last page)
          Positioned(
            top: kToolbarHeight + 10.h,
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
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              );
            }),
          ),

          /// Bottom Indicator + Button
          Positioned(
            bottom: 40.h,
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
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withValues(
                                  alpha: 0.15,
                                ),
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
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        controller.currentIndex.value ==
                                controller.onboardingList.length - 1
                            ? 'Get Started'
                            : 'Continue',
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
