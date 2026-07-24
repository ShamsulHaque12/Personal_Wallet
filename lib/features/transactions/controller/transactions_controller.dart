import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_wallet/features/home_screen/controller/home_screen_controller.dart';

class TransactionsController extends GetxController {
  var selectedFilter = 'Daily'.obs;

  final filters = ['Daily', 'Monthly', 'Yearly', 'Categories'];

  var transactionsList = <TransactionModel>[
    TransactionModel(
      title: 'Salary',
      subtitle: 'Income',
      date: '10:00 AM - May 1',
      amount: '+\$5,000.00',
      icon: Icons.account_balance_wallet,
      iconColor: Colors.green,
      isExpense: false,
    ),
    TransactionModel(
      title: 'Coffee Shop',
      subtitle: 'Food & Drink',
      date: '08:30 AM - May 1',
      amount: '-\$4.50',
      icon: Icons.local_cafe_rounded,
      iconColor: Colors.brown,
      isExpense: true,
    ),
    TransactionModel(
      title: 'Grocery Store',
      subtitle: 'Groceries',
      date: '06:00 PM - April 30',
      amount: '-\$120.40',
      icon: Icons.shopping_cart_rounded,
      iconColor: Colors.orange,
      isExpense: true,
    ),
    TransactionModel(
      title: 'Netflix Subscription',
      subtitle: 'Entertainment',
      date: '12:00 AM - April 29',
      amount: '-\$15.99',
      icon: Icons.movie_creation_rounded,
      iconColor: Colors.redAccent,
      isExpense: true,
    ),
    TransactionModel(
      title: 'Freelance Work',
      subtitle: 'Income',
      date: '03:00 PM - April 28',
      amount: '+\$850.00',
      icon: Icons.work_rounded,
      iconColor: Colors.blueAccent,
      isExpense: false,
    ),
    TransactionModel(
      title: 'Electric Bill',
      subtitle: 'Utilities',
      date: '09:00 AM - April 25',
      amount: '-\$95.00',
      icon: Icons.electrical_services_rounded,
      iconColor: Colors.amber,
      isExpense: true,
    ),
  ].obs;

  double get totalIncome {
    return transactionsList
        .where((tx) => !tx.isExpense)
        .fold(0.0, (sum, tx) => sum + _parseAmount(tx.amount));
  }

  double get totalExpense {
    return transactionsList
        .where((tx) => tx.isExpense)
        .fold(0.0, (sum, tx) => sum + _parseAmount(tx.amount));
  }

  double _parseAmount(String amountStr) {
    final clean = amountStr.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(clean) ?? 0.0;
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }
}
