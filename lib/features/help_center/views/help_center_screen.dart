import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/help_center/controller/help_center_controller.dart';

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final HelpCenterController controller = Get.put(HelpCenterController());

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
          'Help Center',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),

          // Search Bar Input
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                width: 1.5,
              ),
            ),
            child: TextField(
              onChanged: controller.onSearch,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  size: 20.sp,
                ),
                hintText: 'Search for help...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          _buildSectionHeader(context, 'Frequently Asked Questions'),

          // FAQ Expansion List
          Expanded(
            child: Obx(() {
              final list = controller.filteredFaqs;
              if (list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_outline_rounded,
                        size: 48.sp,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No matches found',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final faq = list[index];
                  return _buildFAQTile(
                    context: context,
                    question: faq['question']!,
                    answer: faq['answer']!,
                  );
                },
              );
            }),
          ),

          // Contact Card Section
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.headset_mic_rounded,
                    color: theme.colorScheme.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Still need help?',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Speak to our support team.',
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.onContactSupport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Contact',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildFAQTile({
    required BuildContext context,
    required String question,
    required String answer,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          width: 1.5,
        ),
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          title: Text(
            question,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          iconColor: theme.colorScheme.primary,
          collapsedIconColor:
              theme.colorScheme.onSurface.withValues(alpha: 0.4),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          children: [
            Text(
              answer,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                height: 1.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
