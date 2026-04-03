import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/edit_profile/controller/edit_profile_controller.dart';
import 'package:personal_wallet/theme/app_colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // White Body Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 420.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.bodyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Header (Fixed)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.sp,
                          color: const Color(0xFF093030),
                        ),
                      ),
                      Text(
                        'Edit My Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF093030),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 24.sp,
                          color: const Color(0xFF093030),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                // Profile Image with Camera Overlay (Fixed)
                Center(
                  child: Stack(
                    children: [
                      Obx(() => Container(
                        width: 140.r,
                        height: 140.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.6),
                            width: 0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70.r),
                          child: controller.pickedImage.value != null
                              ? Image.file(
                                  File(controller.pickedImage.value!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  controller.profileImage,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      )),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF00D09E),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // User Info (Fixed)
                Text(
                  controller.userName,
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0E3E3E),
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  controller.userGmail,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF093030).withOpacity(0.6),
                  ),
                ),

                SizedBox(height: 30.h),

                // Account Settings Section (Scrollable)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Settings',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0E3E3E),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Username Field
                          _buildFieldLabel('Username'),
                          _buildTextField(controller.usernameController),
                          SizedBox(height: 20.h),

                          // Phone Field
                          _buildFieldLabel('Phone'),
                          _buildTextField(controller.phoneController),
                          SizedBox(height: 20.h),

                          // Email Address Field
                          _buildFieldLabel('Email Address'),
                          _buildTextField(controller.emailController),

                          SizedBox(height: 40.h),

                          // Update Profile Button
                          Center(
                            child: GestureDetector(
                              onTap: controller.onUpdateProfile,
                              child: Container(
                                width: 220.w,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00D09E),
                                  borderRadius: BorderRadius.circular(40.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF00D09E,
                                      ).withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Update Profile',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF093030),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFFDFF7E2,
        ).withOpacity(0.5), // Light green background
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: const Color(0xFF093030),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
