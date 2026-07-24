import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Budgets & Analytics',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Budget',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            _buildBudgetCard(context),
            SizedBox(height: 24.h),
            Text(
              'Spend Patterns',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            _buildAnalyticsChartPlaceholder(context),
            SizedBox(height: 100.h), // Spacing for floating bottom bar
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context) {
    final theme = Theme.of(context);
    return Tilt3DContainer(
      child: Container(
        padding: EdgeInsets.all(20.r),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Spend Limit',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                Text(
                  '\$1,250 / \$2,000',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Stack(
              children: [
                Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      height: 8.h,
                      width: constraints.maxWidth * (1250 / 2000),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsChartPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    final List<double> values = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 0.3];
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Tilt3DContainer(
      child: Container(
        padding: EdgeInsets.all(20.r),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Spend Analysis',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 120.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(values.length, (index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final maxHeight = constraints.maxHeight;
                            return Container(
                              width: 16.w,
                              height: maxHeight * values[index],
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    theme.colorScheme.primary.withValues(
                                      alpha: 0.6,
                                    ),
                                    theme.colorScheme.primary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        days[index],
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
