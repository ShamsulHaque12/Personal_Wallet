import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/theme/app_colors.dart';

class SavingsCard extends StatelessWidget {
  const SavingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(30.r),
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
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Text(
                '70%',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Container(height: 100.h, width: 1.5, color: Colors.white30),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              children: [
                _buildRevenueItem(
                  Icons.payments_outlined,
                  'Revenue Last Week',
                  '\$4.000.00',
                  true,
                ),
                const Divider(color: Colors.white30, thickness: 1.5),
                _buildRevenueItem(
                  Icons.restaurant_outlined,
                  'Food Last Week',
                  '-\$100.00',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueItem(
    IconData icon,
    String title,
    String amount,
    bool isPositive,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 28.sp),
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
                  color: Colors.black87,
                ),
              ),
              Text(
                amount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.black : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
