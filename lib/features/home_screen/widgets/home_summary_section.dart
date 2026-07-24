import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSummarySection extends StatelessWidget {
  const HomeSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    Text(
                      '\$7,783.00',
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
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
                    Text(
                      '-\$1,187.40',
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Budget Progress Bar
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
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '30%',
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
                      '\$20,000.00 limit',
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.5),
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
                Icons.check_circle_outline_rounded,
                size: 16.sp,
                color: theme.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '30% of your expenses used. Looking good!',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
