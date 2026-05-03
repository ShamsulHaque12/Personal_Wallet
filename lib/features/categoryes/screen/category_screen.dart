import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_wallet/features/categoryes/controller/category_controller.dart';
import 'package:personal_wallet/features/home_screen/widgets/home_summary_section.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Teal Header Background
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: theme.colorScheme.surface),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // App Bar Area (Title + Notification)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 0.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40), // Spacer for balance
                          Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications_none_outlined,
                              size: 24.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Summary Section
                    const HomeSummarySection(),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),

            // Body Container (Grid)
            Transform.translate(
              offset: Offset(0, -20.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 24.h,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return _buildCategoryCard(context, category);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryItem category) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(category.icon, size: 40.sp, color: Colors.white),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          category.name,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
