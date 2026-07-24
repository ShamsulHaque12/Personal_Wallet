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
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: tx.iconColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Icon(tx.icon, color: tx.iconColor, size: 24.sp),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tx.title,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                tx.date,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: theme.colorScheme.primary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 20.h,
          width: 1,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          margin: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        Text(
          tx.subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Container(
          height: 20.h,
          width: 1,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          margin: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        Text(
          tx.amount,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: tx.isExpense
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
