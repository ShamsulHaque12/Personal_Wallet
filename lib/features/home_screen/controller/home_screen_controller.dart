import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';

class TransactionModel {
  final String title;
  final String subtitle;
  final String date;
  final DateTime dateTime;
  final double numericAmount;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final bool isExpense;

  TransactionModel({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.dateTime,
    required this.numericAmount,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.isExpense,
  });
}

class HomeScreenController extends GetxController {
  var selectedTab = 'Monthly'.obs;
  var isLoading = false.obs;
  var allTransactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      String? userId = Supabase.instance.client.auth.currentUser?.id;
      userId ??= await SharedPreferenceService.getUserId();

      if (userId != null && userId.isNotEmpty) {
        debugPrint('LOG: [HomeScreenController] Fetching transactions from Supabase for user: $userId');
        final response = await Supabase.instance.client
            .from('transactions')
            .select()
            .eq('user_id', userId)
            .order('created_at', ascending: false);

        debugPrint('SUCCESS: [HomeScreenController] Fetched ${(response as List).length} transactions from Supabase');

        final List<TransactionModel> list = response.map((item) {
          final typeStr = (item['type'] ?? '').toString().toLowerCase();
          final isExpense = typeStr == 'expense';
          final amountNum = double.tryParse(item['amount'].toString()) ?? 0.0;
          final amountStr = isExpense
              ? '-\$${amountNum.toStringAsFixed(2)}'
              : '+\$${amountNum.toStringAsFixed(2)}';

          final dateStr = (item['transaction_date'] ?? '').toString();
          final parsedDate = DateTime.tryParse(dateStr) ?? DateTime.now();

          return TransactionModel(
            title: item['category'] ?? 'Transaction',
            subtitle: typeStr.toUpperCase(),
            date: dateStr,
            dateTime: parsedDate,
            numericAmount: amountNum,
            amount: amountStr,
            icon: _getCategoryIcon(item['category'] as String?, isExpense),
            iconColor: _getCategoryColor(item['category'] as String?, isExpense),
            isExpense: isExpense,
          );
        }).toList();

        allTransactions.assignAll(list);
      } else {
        debugPrint('WARNING: [HomeScreenController] User ID is null or empty.');
      }
    } catch (e) {
      debugPrint('ERROR: [HomeScreenController] Exception while fetching transactions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<TransactionModel> get filteredTransactions {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (selectedTab.value == 'Daily') {
      return allTransactions.where((tx) {
        final txDay = DateTime(tx.dateTime.year, tx.dateTime.month, tx.dateTime.day);
        return txDay.isAtSameMomentAs(today);
      }).toList();
    } else if (selectedTab.value == 'Weekly') {
      return allTransactions.where((tx) {
        final txDay = DateTime(tx.dateTime.year, tx.dateTime.month, tx.dateTime.day);
        final difference = today.difference(txDay).inDays;
        return difference >= 0 && difference < 7;
      }).toList();
    } else {
      // Monthly
      return allTransactions.where((tx) {
        return tx.dateTime.year == now.year && tx.dateTime.month == now.month;
      }).toList();
    }
  }

  double get totalIncome {
    return allTransactions
        .where((tx) => !tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.numericAmount);
  }

  double get totalExpense {
    return allTransactions
        .where((tx) => tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.numericAmount);
  }

  double get totalBalance => totalIncome - totalExpense;

  TransactionModel? get lastIncome {
    try {
      return allTransactions.firstWhere((tx) => !tx.isExpense);
    } catch (_) {
      return null;
    }
  }

  TransactionModel? get lastExpense {
    try {
      return allTransactions.firstWhere((tx) => tx.isExpense);
    } catch (_) {
      return null;
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  IconData _getCategoryIcon(String? category, bool isExpense) {
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
      default:
        return isExpense ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
    }
  }

  Color _getCategoryColor(String? category, bool isExpense) {
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
      default:
        return isExpense ? Colors.redAccent : Colors.green;
    }
  }
}