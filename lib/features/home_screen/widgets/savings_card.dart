import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';

class SavingsCard extends StatelessWidget {
  const SavingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final HomeScreenController controller = Get.find<HomeScreenController>();

    return Tilt3DContainer(
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Obx(() {
          final income = controller.totalIncome;
          final balance = controller.totalBalance;

          final double savingsRatio = income > 0
              ? (balance / income).clamp(0.0, 1.0)
              : 0.0;
          final int savingsPercentage = (savingsRatio * 100).round();

          final lastIncome = controller.lastIncome;
          final lastExpense = controller.lastExpense;

          return Row(
            children: [
              // Circular Savings Progress Indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 80.h,
                    width: 80.h,
                    child: CircularProgressIndicator(
                      value: savingsRatio,
                      strokeWidth: 6,
                      backgroundColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.05,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    '$savingsPercentage%',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Container(
                height: 80.h,
                width: 1.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  children: [
                    // Last Income Item
                    _buildRevenueItem(
                      theme: theme,
                      icon: lastIncome?.icon ?? Icons.arrow_upward_rounded,
                      iconColor:
                          lastIncome?.iconColor ?? theme.colorScheme.primary,
                      title: lastIncome != null
                          ? lastIncome.title
                          : 'Last Income',
                      amount: lastIncome?.amount ?? '\$0.00',
                      isPositive: true,
                    ),
                    Divider(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.05,
                      ),
                      thickness: 1.5,
                      height: 16.h,
                    ),
                    // Last Expense Item
                    _buildRevenueItem(
                      theme: theme,
                      icon: lastExpense?.icon ?? Icons.arrow_downward_rounded,
                      iconColor:
                          lastExpense?.iconColor ?? theme.colorScheme.error,
                      title: lastExpense != null
                          ? lastExpense.title
                          : 'Last Expense',
                      amount: lastExpense?.amount ?? '\$0.00',
                      isPositive: false,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildRevenueItem({
    required ThemeData theme,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String amount,
    required bool isPositive,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: iconColor, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Text(
                amount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isPositive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
