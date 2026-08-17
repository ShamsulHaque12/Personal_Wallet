import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';

class HomeSummarySection extends StatelessWidget {
  const HomeSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final HomeScreenController controller = Get.find<HomeScreenController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_upward_rounded,
                          size: 14.sp,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Total Balance',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Obx(() {
                      final balance = controller.totalBalance;
                      final balanceStr = balance >= 0
                          ? '\$${balance.toStringAsFixed(2)}'
                          : '-\$${balance.abs().toStringAsFixed(2)}';
                      return Text(
                        balanceStr,
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                height: 40.h,
                width: 1.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_downward_rounded,
                          size: 14.sp,
                          color: theme.colorScheme.error,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Total Expense',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Obx(() {
                      final expense = controller.totalExpense;
                      return Text(
                        '-\$${expense.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Budget Progress Bar
          Obx(() {
            final income = controller.totalIncome;
            final expense = controller.totalExpense;

            final double limit = income > 0 ? income : (expense > 0 ? expense : 1.0);
            final double ratio = (expense / limit).clamp(0.0, 1.0);
            final int percentage = (ratio * 100).round();

            // Set minimum width factor so percentage text fits neatly on one line
            final double visualWidthFactor = ratio == 0.0 
                ? 0.12 
                : (ratio < 0.12 ? 0.12 : ratio);

            return Column(
              children: [
                Container(
                  height: 32.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.02),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      AnimatedFractionallySizedBox(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        widthFactor: visualWidthFactor,
                        child: Container(
                          decoration: BoxDecoration(
                            color: percentage > 85
                                ? Colors.redAccent
                                : theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$percentage%',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 12.w,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Text(
                            '\$${limit.toStringAsFixed(2)} total',
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(
                      percentage > 85
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle_outline_rounded,
                      size: 16.sp,
                      color: percentage > 85
                          ? Colors.redAccent
                          : theme.colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        percentage > 85
                            ? '$percentage% of your total income spent. Careful!'
                            : '$percentage% of your total income spent. Looking good!',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
