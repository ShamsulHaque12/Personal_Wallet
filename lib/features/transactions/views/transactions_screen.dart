import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/transactions/controller/transactions_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/transaction_tile.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final TransactionsController controller = Get.put(TransactionsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterChips(context, controller),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text(
              'Recent Transactions',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: 100.h,
                ),
                itemCount: controller.transactionsList.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final tx = controller.transactionsList[index];
                  return TransactionTile(tx: tx);
                },
              ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Obx(
        () => Row(
          children: controller.filters.map((filter) {
            final isSelected = controller.selectedFilter.value == filter;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: FilterChip(
                label: Text(
                  filter,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
                selected: isSelected,
                onSelected: (val) {
                  controller.changeFilter(filter);
                },
                selectedColor: const Color(0xFF00D09E),
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.grey.withValues(alpha: 0.3),
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
