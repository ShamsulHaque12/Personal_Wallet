import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';
import 'package:personal_wallet/features/transactions/views/flipping_3d_list_item.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: theme.colorScheme.onSurface,
            size: 28.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),

              // Profile Image & Info (Cascading 3D)
              Flipping3DListItem(
                index: 0,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Obx(
                          () => Container(
                            width: 120.r,
                            height: 120.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.3,
                                ),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60.r),
                              child: controller.pickedImage.value != null
                                  ? Image.file(
                                      File(controller.pickedImage.value!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : controller.avatarUrl.value.isNotEmpty
                                      ? Image.network(
                                          controller.avatarUrl.value,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            color: theme.colorScheme.surface,
                                            child: Icon(
                                              Icons.broken_image_rounded,
                                              size: 44.sp,
                                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          color: theme.colorScheme.surface,
                                          child: Center(
                                            child: Icon(
                                              Icons.broken_image_rounded,
                                              size: 44.sp,
                                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: controller.pickImage,
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.scaffoldBackgroundColor,
                                  width: 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Quick Info Display
                    Obx(
                      () => Text(
                        controller.userName.value.isEmpty
                            ? 'User Name'
                            : controller.userName.value,
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Obx(
                      () => Text(
                        controller.userEmail.value.isEmpty
                            ? 'user@example.com'
                            : controller.userEmail.value,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Form Input Fields (Interactive 3D Tilt Card)
              Flipping3DListItem(
                index: 1,
                child: Tilt3DContainer(
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'PERSONAL DETAILS',
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        _buildInputField(
                          context: context,
                          label: 'Username',
                          prefixIcon: Icons.person_outline_rounded,
                          fieldController: controller.usernameController,
                          hintText: 'Enter username',
                        ),
                        SizedBox(height: 20.h),

                        _buildInputField(
                          context: context,
                          label: 'Phone Number',
                          prefixIcon: Icons.phone_outlined,
                          fieldController: controller.phoneController,
                          hintText: 'Enter phone number',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 20.h),

                        _buildInputField(
                          context: context,
                          label: 'Email Address (Fixed)',
                          prefixIcon: Icons.mail_outline_rounded,
                          fieldController: controller.emailController,
                          hintText: 'Enter email address',
                          keyboardType: TextInputType.emailAddress,
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36.h),

              // Update Profile Button
              Flipping3DListItem(
                index: 2,
                child: Obx(
                  () => GestureDetector(
                    onTap: controller.isLoading.value ? null : controller.onUpdateProfile,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.25,
                            ),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 22.r,
                                height: 22.r,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'Save Changes',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required String label,
    required IconData prefixIcon,
    required TextEditingController fieldController,
    String? hintText,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface.withValues(alpha: enabled ? 0.6 : 0.35),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: enabled
                ? theme.scaffoldBackgroundColor
                : theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: enabled ? 0.05 : 0.02),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: fieldController,
            enabled: enabled,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: enabled
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                prefixIcon,
                color: theme.colorScheme.primary.withValues(alpha: enabled ? 0.7 : 0.35),
                size: 20.sp,
              ),
              suffixIcon: enabled
                  ? null
                  : Icon(
                      Icons.lock_outline_rounded,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      size: 18.sp,
                    ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
