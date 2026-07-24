import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:personal_wallet/features/home_screen/views/home_screen.dart';
import 'package:personal_wallet/features/transactions/views/transactions_screen.dart';
import 'package:personal_wallet/features/analytics/views/analytics_screen.dart';
import 'package:personal_wallet/features/profile_screen/screen/profile_screen.dart';
import 'package:personal_wallet/features/transaction_categories/views/transaction_categories_screen.dart';

class NavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeScreen(),
    const TransactionsScreen(),
    TransactionCategoriesScreen(),
    const AnalyticsScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
