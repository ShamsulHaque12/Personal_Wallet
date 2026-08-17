import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';

class CategoryData {
  final String name;
  final double amount;
  final double percentage; // 0.0 to 100.0
  final IconData icon;
  final Color color;

  CategoryData({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.icon,
    required this.color,
  });
}

class AnalyticsController extends GetxController {
  final isLoading = false.obs;

  // Monthly stats
  final monthlyIncome = 0.0.obs;
  final monthlyExpense = 0.0.obs;

  // Total stats for breakdown
  final totalExpenseAllTime = 0.0.obs;
  final totalIncomeAllTime = 0.0.obs;

  // Category breakdowns
  final expenseCategories = <CategoryData>[].obs;
  final incomeCategories = <CategoryData>[].obs;

  // Weekly daily expenses [Mon, Tue, Wed, Thu, Fri, Sat, Sun]
  final weeklyDailyExpenses = <double>[0, 0, 0, 0, 0, 0, 0].obs;
  final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void onInit() {
    super.onInit();
    fetchAnalytics();
  }

  Future<void> fetchAnalytics() async {
    try {
      isLoading.value = true;
      String? userId = Supabase.instance.client.auth.currentUser?.id;
      userId ??= await SharedPreferenceService.getUserId();

      if (userId != null && userId.isNotEmpty) {
        final response = await Supabase.instance.client
            .from('transactions')
            .select()
            .eq('user_id', userId);

        final now = DateTime.now();
        double mIncome = 0.0;
        double mExpense = 0.0;

        double totalExp = 0.0;
        double totalInc = 0.0;

        final Map<String, double> expenseMap = {};
        final Map<String, double> incomeMap = {};

        final currentMonday = DateTime(now.year, now.month, now.day)
            .subtract(Duration(days: now.weekday - 1));

        final List<double> dailySpend = List.filled(7, 0.0);

        for (var item in (response as List)) {
          final typeStr = (item['type'] ?? '').toString().toLowerCase();
          final isExpense = typeStr == 'expense';
          final amountNum = double.tryParse(item['amount'].toString()) ?? 0.0;
          final dateStr = (item['transaction_date'] ?? '').toString();
          final txDate = DateTime.tryParse(dateStr) ?? now;
          final categoryName = (item['category'] ?? 'Other').toString();

          if (isExpense) {
            totalExp += amountNum;
            expenseMap[categoryName] = (expenseMap[categoryName] ?? 0.0) + amountNum;
          } else {
            totalInc += amountNum;
            incomeMap[categoryName] = (incomeMap[categoryName] ?? 0.0) + amountNum;
          }

          // Calculate monthly totals
          if (txDate.year == now.year && txDate.month == now.month) {
            if (isExpense) {
              mExpense += amountNum;
            } else {
              mIncome += amountNum;
            }
          }

          // Calculate weekly daily breakdown (Mon..Sun)
          if (isExpense) {
            final txDay = DateTime(txDate.year, txDate.month, txDate.day);
            final differenceInDays = txDay.difference(currentMonday).inDays;
            if (differenceInDays >= 0 && differenceInDays < 7) {
              dailySpend[differenceInDays] += amountNum;
            }
          }
        }

        monthlyIncome.value = mIncome;
        monthlyExpense.value = mExpense;
        weeklyDailyExpenses.assignAll(dailySpend);

        totalExpenseAllTime.value = totalExp;
        totalIncomeAllTime.value = totalInc;

        // Convert expenseMap to CategoryData list
        final List<CategoryData> expList = expenseMap.entries.map((entry) {
          final amt = entry.value;
          final pct = totalExp > 0 ? (amt / totalExp * 100) : 0.0;
          return CategoryData(
            name: entry.key,
            amount: amt,
            percentage: pct,
            icon: _getCategoryIcon(entry.key, true),
            color: _getCategoryColor(entry.key, true),
          );
        }).toList();
        expList.sort((a, b) => b.amount.compareTo(a.amount));
        expenseCategories.assignAll(expList);

        // Convert incomeMap to CategoryData list
        final List<CategoryData> incList = incomeMap.entries.map((entry) {
          final amt = entry.value;
          final pct = totalInc > 0 ? (amt / totalInc * 100) : 0.0;
          return CategoryData(
            name: entry.key,
            amount: amt,
            percentage: pct,
            icon: _getCategoryIcon(entry.key, false),
            color: _getCategoryColor(entry.key, false),
          );
        }).toList();
        incList.sort((a, b) => b.amount.compareTo(a.amount));
        incomeCategories.assignAll(incList);
      }
    } catch (e) {
      debugPrint('Error fetching analytics data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  double get maxWeeklyExpense {
    final maxVal = weeklyDailyExpenses.fold(
      0.0,
      (max, val) => val > max ? val : max,
    );
    return maxVal > 0 ? maxVal : 1.0;
  }

  IconData _getCategoryIcon(String category, bool isExpense) {
    switch (category) {
      case 'Food & Dining':
        return Icons.restaurant_rounded;
      case 'Shopping':
        return Icons.shopping_bag_rounded;
      case 'Housing & Rent':
        return Icons.home_rounded;
      case 'Transportation':
        return Icons.directions_car_rounded;
      case 'Bills & Utilities':
        return Icons.receipt_long_rounded;
      case 'Health & Medicine':
        return Icons.medication_rounded;
      case 'Entertainment':
        return Icons.sports_esports_rounded;
      case 'Travel':
        return Icons.flight_rounded;
      case 'Education':
        return Icons.school_rounded;
      case 'Salary':
        return Icons.work_rounded;
      case 'Investments':
        return Icons.trending_up_rounded;
      case 'Gifts & Grants':
        return Icons.card_giftcard_rounded;
      case 'Refunds':
        return Icons.assignment_return_rounded;
      case 'Other Income':
        return Icons.more_horiz_rounded;
      default:
        return isExpense ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
    }
  }

  Color _getCategoryColor(String category, bool isExpense) {
    switch (category) {
      case 'Food & Dining':
        return Colors.orange;
      case 'Shopping':
        return Colors.purple;
      case 'Housing & Rent':
        return Colors.blue;
      case 'Transportation':
        return Colors.teal;
      case 'Bills & Utilities':
        return Colors.red;
      case 'Health & Medicine':
        return Colors.green;
      case 'Entertainment':
        return Colors.pink;
      case 'Travel':
        return Colors.indigo;
      case 'Education':
        return Colors.cyan;
      case 'Salary':
        return Colors.green;
      case 'Investments':
        return Colors.lightGreen;
      case 'Gifts & Grants':
        return Colors.deepOrange;
      case 'Refunds':
        return Colors.blueGrey;
      case 'Other Income':
        return Colors.grey;
      default:
        return isExpense ? Colors.redAccent : Colors.green;
    }
  }
}
