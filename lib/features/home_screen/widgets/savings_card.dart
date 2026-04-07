import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SavingsCard extends StatelessWidget {
  const SavingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Savings Progress
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 90.h,
                width: 90.h,
                child: CircularProgressIndicator(
                  value: 0.7,
                  strokeWidth: 6,
                  backgroundColor: theme.colorScheme.onSurface.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ),
              Text(
                '70%',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Container(
            height: 100.h,
            width: 1.5,
            color: theme.colorScheme.onSurface.withOpacity(0.1),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              children: [
                _buildRevenueItem(
                  theme: theme,
                  icon: Icons.payments_outlined,
                  title: 'Revenue Last Week',
                  amount: '\$4.000.00',
                  isPositive: true,
                ),
                Divider(
                  color: theme.colorScheme.onSurface.withOpacity(0.1),
                  thickness: 1.5,
                ),
                _buildRevenueItem(
                  theme: theme,
                  icon: Icons.restaurant_outlined,
                  title: 'Food Last Week',
                  amount: '-\$100.00',
                  isPositive: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueItem({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String amount,
    required bool isPositive,
  }) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSurface, size: 28.sp),
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
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                amount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? theme.colorScheme.primary : Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
