import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/analytics/controller/analytics_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AnalyticsController controller = Get.put(AnalyticsController());

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
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
              _buildBudgetCard(context, controller),
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
              _buildAnalyticsChartPlaceholder(context, controller),
              SizedBox(height: 24.h),

              // Expense Categories Breakdown (Horizontal Bar Chart)
              _buildCategoryHorizontalBarChart(
                context: context,
                title: 'Expense Categories',
                categories: controller.expenseCategories,
                isExpense: true,
              ),
              SizedBox(height: 24.h),

              // Income Categories Breakdown (Horizontal Bar Chart)
              _buildCategoryHorizontalBarChart(
                context: context,
                title: 'Income Categories',
                categories: controller.incomeCategories,
                isExpense: false,
              ),

              SizedBox(height: 100.h), // Spacing for floating bottom bar
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBudgetCard(
    BuildContext context,
    AnalyticsController controller,
  ) {
    final theme = Theme.of(context);
    final expense = controller.monthlyExpense.value;
    final income = controller.monthlyIncome.value;
    final limit = income > 0 ? income : (expense > 0 ? expense : 1.0);
    final ratio = (expense / limit).clamp(0.0, 1.0);

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
                Expanded(
                  child: Text(
                    'Monthly Spend Limit',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '\$${expense.toStringAsFixed(2)} / \$${limit.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
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
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 8.h,
                      width: constraints.maxWidth * ratio,
                      decoration: BoxDecoration(
                        color: ratio > 0.85
                            ? Colors.redAccent
                            : theme.colorScheme.primary,
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

  Widget _buildAnalyticsChartPlaceholder(
    BuildContext context,
    AnalyticsController controller,
  ) {
    final theme = Theme.of(context);
    final values = controller.weeklyDailyExpenses;
    final maxExpense = controller.maxWeeklyExpense;
    final days = controller.daysOfWeek;

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
                Expanded(
                  child: Text(
                    'Weekly Spend Analysis',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    'This Week',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 140.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(values.length, (index) {
                  final dayExpense = values[index];
                  final double rawRatio = maxExpense > 0
                      ? (dayExpense / maxExpense)
                      : 0.0;
                  final double heightRatio = dayExpense > 0
                      ? (rawRatio < 0.15 ? 0.15 : rawRatio)
                      : 0.05;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (dayExpense > 0)
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Text(
                            '\$${dayExpense.toStringAsFixed(0)}',
                            style: GoogleFonts.poppins(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final maxHeight = constraints.maxHeight;
                            return Container(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 16.w,
                                height: maxHeight * heightRatio,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      theme.colorScheme.primary.withValues(
                                        alpha: dayExpense > 0 ? 0.6 : 0.2,
                                      ),
                                      dayExpense > 0
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurface
                                                .withValues(alpha: 0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
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

  Widget _buildCategoryHorizontalBarChart({
    required BuildContext context,
    required String title,
    required List<CategoryData> categories,
    required bool isExpense,
  }) {
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
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color:
                        (isExpense
                                ? Colors.redAccent
                                : theme.colorScheme.primary)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${categories.length} Categories',
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: isExpense
                          ? Colors.redAccent
                          : theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (categories.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: Text(
                    isExpense
                        ? 'No expense transactions yet'
                        : 'No income transactions yet',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final ratio = (item.percentage / 100.0).clamp(0.0, 1.0);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: item.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              item.icon,
                              size: 16.sp,
                              color: item.color,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    item.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '• ${item.percentage.toStringAsFixed(1)}%',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            isExpense
                                ? '-\$${item.amount.toStringAsFixed(2)}'
                                : '+\$${item.amount.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: isExpense
                                  ? theme.colorScheme.error
                                  : theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Horizontal Bar
                      Stack(
                        children: [
                          Container(
                            height: 6.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: item.color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: ratio < 0.03 ? 0.03 : ratio,
                            child: Container(
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: item.color,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: item.color.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
