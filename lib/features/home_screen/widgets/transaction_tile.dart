import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;
  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: tx.iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(tx.icon, color: tx.iconColor, size: 22.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${tx.subtitle} • ${tx.date}',
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          Text(
            tx.amount,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: tx.isExpense
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
