import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/transactions/controller/transactions_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/transaction_tile.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';
import 'package:personal_wallet/features/transactions/views/flipping_3d_list_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TransactionsController controller = Get.put(TransactionsController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Transactions',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                color: theme.colorScheme.onSurface,
                size: 24.sp,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Chips Selector
          _buildFilterChips(context, controller),
          SizedBox(height: 8.h),

          // 3D Overview Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Tilt3DContainer(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'OVERVIEW',
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Obx(() => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                controller.selectedFilter.value.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Income',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Obx(() => Text(
                                    '\$${controller.totalIncome.toStringAsFixed(2)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          height: 36.h,
                          width: 1.5,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.05),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expense',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Obx(() => Text(
                                    '\$${controller.totalExpense.toStringAsFixed(2)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.error,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Transactions Log',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final list = controller.filteredTransactions;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'No transactions for ${controller.selectedFilter.value}',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.5),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 120.h,
                  ),
                  itemCount: list.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 16.h,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  ),
                  itemBuilder: (context, index) {
                    final tx = list[index];
                    return Flipping3DListItem(
                      key: ValueKey('${controller.selectedFilter.value}_$index'),
                      index: index,
                      child: TransactionTile(tx: tx),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(
    BuildContext context,
    TransactionsController controller,
  ) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Obx(
        () => Row(
          children: controller.filters.map((filter) {
            final isSelected = controller.selectedFilter.value == filter;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ChoiceChip(
                label: Text(
                  filter,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                  ),
                ),
                selected: isSelected,
                onSelected: (val) {
                  controller.changeFilter(filter);
                },
                selectedColor: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surface,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : theme.colorScheme.onSurface
                            .withValues(alpha: 0.05),
                    width: 1.5,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
