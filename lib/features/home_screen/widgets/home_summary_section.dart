import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSummarySection extends StatelessWidget {
  const HomeSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                          Icons.arrow_outward,
                          size: 14.sp,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Total Balance',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$7,783.00',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40.h,
                width: 1,
                color: Colors.white24,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.call_received,
                          size: 14.sp,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Total Expense',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '-\$1.187.40',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '30%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
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
                      '\$20,000.00',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
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
              Icon(Icons.check_box_outlined, size: 16.sp, color: Colors.black),
              SizedBox(width: 8.w),
              Text(
                '30% Of Your Expenses, Looks Good.',
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
