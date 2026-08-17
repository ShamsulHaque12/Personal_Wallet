import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';

class TransactionsController extends GetxController {
  var selectedFilter = 'Daily'.obs;
  final isLoading = false.obs;

  final filters = ['Daily', 'Weekly', 'Monthly'];

  var transactionsList = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      String? userId = Supabase.instance.client.auth.currentUser?.id;
      userId ??= await SharedPreferenceService.getUserId();

      if (userId != null && userId.isNotEmpty) {
        debugPrint('LOG: Fetching transactions from Supabase for user ID: $userId');
        final response = await Supabase.instance.client
            .from('transactions')
            .select()
            .eq('user_id', userId)
            .order('created_at', ascending: false);

        debugPrint('SUCCESS: Transactions retrieved successfully from Supabase! Count: ${(response as List).length}');

        final List<TransactionModel> fetchedList = response.map((item) {
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
            icon: isExpense ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
            iconColor: isExpense ? Colors.redAccent : Colors.green,
            isExpense: isExpense,
          );
        }).toList();

        transactionsList.assignAll(fetchedList);
      } else {
        debugPrint('WARNING: Cannot fetch transactions. User ID is null or empty.');
      }
    } catch (e) {
      debugPrint('ERROR: Exception occurred while fetching transactions from Supabase: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<TransactionModel> get filteredTransactions {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (selectedFilter.value == 'Daily') {
      return transactionsList.where((tx) {
        final txDay = DateTime(tx.dateTime.year, tx.dateTime.month, tx.dateTime.day);
        return txDay.isAtSameMomentAs(today);
      }).toList();
    } else if (selectedFilter.value == 'Weekly') {
      return transactionsList.where((tx) {
        final txDay = DateTime(tx.dateTime.year, tx.dateTime.month, tx.dateTime.day);
        final difference = today.difference(txDay).inDays;
        return difference >= 0 && difference < 7;
      }).toList();
    } else {
      // Monthly
      return transactionsList.where((tx) {
        return tx.dateTime.year == now.year && tx.dateTime.month == now.month;
      }).toList();
    }
  }

  double get totalIncome {
    return filteredTransactions
        .where((tx) => !tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.numericAmount);
  }

  double get totalExpense {
    return filteredTransactions
        .where((tx) => tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.numericAmount);
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }
}
