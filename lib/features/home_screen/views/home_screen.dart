import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';
import 'package:personal_wallet/theme/app_colors.dart';

import 'package:personal_wallet/features/home_screen/widgets/home_summary_section.dart';
import 'package:personal_wallet/features/home_screen/widgets/savings_card.dart';
import 'package:personal_wallet/features/home_screen/widgets/timeframe_switcher.dart';
import 'package:personal_wallet/features/home_screen/widgets/transaction_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Teal Header Background with Content
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.backgroundColor),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // App Bar Area (Greeting + Notification)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, Welcome Back',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Good Morning',
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications_none_outlined,
                              size: 24.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Summary Section (Balance + Expense + Budget)
                    const HomeSummarySection(),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),

            // White Body Container
            Transform.translate(
              offset: Offset(0, -20.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.bodyColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 22.h),
                child: Column(
                  children: [
                    // Savings Card
                    const SavingsCard(),
                    SizedBox(height: 32.h),

                    // Timeframe Switcher
                    TimeframeSwitcher(),
                    SizedBox(height: 32.h),

                    // Transaction List
                    Obx(
                      () => ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.transactions.length,
                        separatorBuilder: (_, __) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final tx = controller.transactions[index];
                          return TransactionTile(tx: tx);
                        },
                      ),
                    ),
                    SizedBox(height: 100.h), // Extra space for persistent nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
