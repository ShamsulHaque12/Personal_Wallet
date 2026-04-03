import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/profile_screen/controller/profile_controller.dart';
import 'package:personal_wallet/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // White Body Container (The bottom part)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400.h,
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
                // Top Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 40.w),
                      Text(
                        'Profile',
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

                // SizedBox(height: 10.h),

                // Profile Image with Overlap
                Center(
                  child: Container(
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
                      child: Image.asset(
                        'assets/images/2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // User Name and ID
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
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF093030).withOpacity(0.6),
                  ),
                ),

                SizedBox(height: 30.h),

                // Menu Items
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildMenuItem(
                          icon: Icons.person_2_outlined,
                          label: 'Edit Profile',
                          color: const Color(0xFF6DB6FE),
                          onTap: controller.onEditProfile,
                        ),
                        _buildMenuItem(
                          icon: Icons.shield_outlined,
                          label: 'Security',
                          color: const Color(0xFF3299FF),
                          onTap: controller.onSecurity,
                        ),
                        _buildMenuItem(
                          icon: Icons.settings_outlined,
                          label: 'Setting',
                          color: const Color(0xFF0068FF),
                          onTap: controller.onSetting,
                        ),
                        _buildMenuItem(
                          icon: Icons.help_outline_rounded,
                          label: 'Help',
                          color: const Color(0xFF6DB6FE),
                          onTap: controller.onHelp,
                        ),
                        _buildMenuItem(
                          icon: Icons.logout_rounded,
                          label: 'Logout',
                          color: const Color(0xFF3299FF),
                          onTap: controller.onLogout,
                        ),
                        SizedBox(
                          height: 100.h,
                        ), // Bottom padding for navigation bar
                      ],
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

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28.sp),
            ),
            SizedBox(width: 18.w),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF093030),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
