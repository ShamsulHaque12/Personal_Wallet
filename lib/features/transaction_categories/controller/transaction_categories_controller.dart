import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';
import 'package:personal_wallet/features/navigation_bar/controller/navigation_bar_controller.dart';
import 'package:personal_wallet/features/transactions/controller/transactions_controller.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';
import 'package:personal_wallet/features/profile_screen/controller/profile_controller.dart';
import 'package:personal_wallet/features/analytics/controller/analytics_controller.dart';

class TransactionCategory {
  final String name;
  final IconData icon;
  final Color color;
  final String type; // 'Expense' or 'Income'
  final String description;

  TransactionCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
    required this.description,
  });
}

class TransactionCategoriesController extends GetxController {
  final searchQuery = ''.obs;
  final selectedType = 'All'.obs;
  final isLoading = false.obs;

  final List<TransactionCategory> categories = [
    TransactionCategory(
      name: 'Food & Dining',
      icon: Icons.restaurant_rounded,
      color: Colors.orange,
      type: 'Expense',
      description: 'Restaurants, fast food, cafes',
    ),
    TransactionCategory(
      name: 'Shopping',
      icon: Icons.shopping_bag_rounded,
      color: Colors.purple,
      type: 'Expense',
      description: 'Apparel, electronics, items',
    ),
    TransactionCategory(
      name: 'Housing & Rent',
      icon: Icons.home_rounded,
      color: Colors.blue,
      type: 'Expense',
      description: 'Rent, mortgage, repairs',
    ),
    TransactionCategory(
      name: 'Transportation',
      icon: Icons.directions_car_rounded,
      color: Colors.teal,
      type: 'Expense',
      description: 'Fuel, bus, train, taxi',
    ),
    TransactionCategory(
      name: 'Bills & Utilities',
      icon: Icons.receipt_long_rounded,
      color: Colors.red,
      type: 'Expense',
      description: 'Electricity, water, internet',
    ),
    TransactionCategory(
      name: 'Health & Medicine',
      icon: Icons.medication_rounded,
      color: Colors.green,
      type: 'Expense',
      description: 'Doctors, pharmacies, insurance',
    ),
    TransactionCategory(
      name: 'Entertainment',
      icon: Icons.sports_esports_rounded,
      color: Colors.pink,
      type: 'Expense',
      description: 'Movies, games, concerts',
    ),
    TransactionCategory(
      name: 'Travel',
      icon: Icons.flight_rounded,
      color: Colors.indigo,
      type: 'Expense',
      description: 'Flights, hotels, vacations',
    ),
    TransactionCategory(
      name: 'Education',
      icon: Icons.school_rounded,
      color: Colors.cyan,
      type: 'Expense',
      description: 'Courses, books, tuition',
    ),
    TransactionCategory(
      name: 'Salary',
      icon: Icons.work_rounded,
      color: Colors.green,
      type: 'Income',
      description: 'Monthly payroll, bonuses',
    ),
    TransactionCategory(
      name: 'Investments',
      icon: Icons.trending_up_rounded,
      color: Colors.lightGreen,
      type: 'Income',
      description: 'Stocks, crypto, real estate',
    ),
    TransactionCategory(
      name: 'Gifts & Grants',
      icon: Icons.card_giftcard_rounded,
      color: Colors.deepOrange,
      type: 'Income',
      description: 'Received funds, awards',
    ),
    TransactionCategory(
      name: 'Refunds',
      icon: Icons.assignment_return_rounded,
      color: Colors.blueGrey,
      type: 'Income',
      description: 'Returned item cashback',
    ),
    TransactionCategory(
      name: 'Other Income',
      icon: Icons.more_horiz_rounded,
      color: Colors.grey,
      type: 'Income',
      description: 'Miscellaneous earnings',
    ),
  ];

  List<TransactionCategory> get filteredCategories {
    return categories.where((cat) {
      final matchesSearch =
          cat.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesType =
          selectedType.value == 'All' || cat.type == selectedType.value;
      return matchesSearch && matchesType;
    }).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void changeSelectedType(String type) {
    selectedType.value = type;
  }

  Future<void> addTransaction({
    required TransactionCategory category,
    required double amount,
  }) async {
    try {
      isLoading.value = true;

      // 1. Retrieve current authenticated user ID
      String? userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null || userId.isEmpty) {
        userId = await SharedPreferenceService.getUserId();
      }

      if (userId == null || userId.isEmpty) {
        debugPrint('ERROR: Cannot add transaction. No authenticated user found.');
        Get.snackbar(
          'Error',
          'User is not authenticated. Please log in to add transactions.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }

      final String type = category.type.toLowerCase(); // 'income' or 'expense'
      final String transactionDate = DateTime.now().toIso8601String().split('T')[0];

      final Map<String, dynamic> transactionData = {
        'user_id': userId,
        'category': category.name,
        'type': type,
        'amount': amount,
        'transaction_date': transactionDate,
      };

      debugPrint('LOG: Submitting transaction to Supabase... Payload: $transactionData');

      final response = await Supabase.instance.client
          .from('transactions')
          .insert(transactionData)
          .select();

      debugPrint('SUCCESS: Transaction logged successfully to Supabase! Data: $response');

      Get.back(); // Close dialog

      if (Get.isRegistered<NavigationBarController>()) {
        Get.find<NavigationBarController>().changeIndex(0);
      }

      if (Get.isRegistered<HomeScreenController>()) {
        Get.find<HomeScreenController>().fetchTransactions();
      }

      if (Get.isRegistered<TransactionsController>()) {
        Get.find<TransactionsController>().fetchTransactions();
      }

      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().fetchUserProfile();
      }

      if (Get.isRegistered<AnalyticsController>()) {
        Get.find<AnalyticsController>().fetchAnalytics();
      }

      Get.snackbar(
        'Transaction Added',
        'Successfully logged ${category.type.toLowerCase()} of BDT ${amount.toStringAsFixed(2)} for ${category.name}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('ERROR: Exception occurred while logging transaction to Supabase: $e');
      Get.snackbar(
        'Error',
        'Failed to log transaction: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
