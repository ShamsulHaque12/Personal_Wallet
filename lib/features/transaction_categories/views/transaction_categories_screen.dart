import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/transaction_categories/controller/transaction_categories_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/tilt_3d_container.dart';
import 'package:personal_wallet/features/transactions/views/flipping_3d_list_item.dart';

class TransactionCategoriesScreen extends StatelessWidget {
  TransactionCategoriesScreen({super.key});

  final TransactionCategoriesController controller =
      Get.put(TransactionCategoriesController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Select Category',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h),

          // Search Input Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                width: 1.5,
              ),
            ),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  size: 20.sp,
                ),
                hintText: 'Search categories...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Custom Filter Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: ['All', 'Expense', 'Income'].map((type) {
                return Expanded(
                  child: Obx(() {
                    final isSelected = controller.selectedType.value == type;
                    return GestureDetector(
                      onTap: () => controller.changeSelectedType(type),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : theme.colorScheme.onSurface
                                    .withValues(alpha: 0.05),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            type,
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : theme.colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20.h),

          // Categories Grid
          Expanded(
            child: Obx(() {
              final list = controller.filteredCategories;
              if (list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 48.sp,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No categories found',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 4.h,
                  bottom: 100.h,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final category = list[index];
                  return Flipping3DListItem(
                    key: ValueKey(
                      '${controller.selectedType.value}_${controller.searchQuery.value}_${category.name}',
                    ),
                    index: index,
                    child: _buildCategoryCard(context, category),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, TransactionCategory category) {
    final theme = Theme.of(context);
    final isExpense = category.type == 'Expense';

    return Tilt3DContainer(
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: () => _showAddTransactionDialog(context, category),
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        category.icon,
                        size: 20.sp,
                        color: category.color,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: isExpense
                            ? Colors.redAccent.withValues(alpha: 0.1)
                            : Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        category.type.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                          color: isExpense ? Colors.redAccent : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  category.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  category.description,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddTransactionDialog(
      BuildContext context, TransactionCategory category) {
    final theme = Theme.of(context);
    final amountController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        backgroundColor: theme.colorScheme.surface,
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      category.icon,
                      size: 24.sp,
                      color: category.color,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          category.type,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Enter Transaction Amount',
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Icon(
                        Icons.attach_money_rounded,
                        color: theme.colorScheme.primary,
                        size: 24.sp,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(),
                    hintText: '0.00',
                    hintStyle: GoogleFonts.poppins(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Obx(() {
                      final isLoading = controller.isLoading.value;
                      return GestureDetector(
                        onTap: isLoading
                            ? null
                            : () {
                                final text = amountController.text.trim();
                                final amount = double.tryParse(text);
                                if (amount != null && amount > 0) {
                                  controller.addTransaction(
                                    category: category,
                                    amount: amount,
                                  );
                                } else {
                                  Get.snackbar(
                                    'Error',
                                    'Please enter a valid amount greater than 0',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.redAccent,
                                    colorText: Colors.white,
                                  );
                                }
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.h,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Confirm',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
