import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionModel {
  final String title;
  final String subtitle;
  final String date;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final bool isExpense;

  TransactionModel({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.isExpense,
  });
}

class HomeScreenController extends GetxController {
  var selectedTab = 'Monthly'.obs;

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

  
  var transactions = <TransactionModel>[
    TransactionModel(
      title: 'Salary',
      subtitle: 'Monthly',
      date: '18:27 - April 30',
      amount: '\$4.000,00',
      icon: Icons.account_balance_wallet_outlined,
      iconColor: Colors.blue.shade300,
      isExpense: false,
    ),
    TransactionModel(
      title: 'Groceries',
      subtitle: 'Pantry',
      date: '17:00 - April 24',
      amount: '-\$100,00',
      icon: Icons.shopping_basket_outlined,
      iconColor: Colors.blue.shade400,
      isExpense: true,
    ),
    TransactionModel(
      title: 'Rent',
      subtitle: 'Rent',
      date: '8:30 - April 15',
      amount: '-\$674,40',
      icon: Icons.vpn_key_outlined,
      iconColor: Colors.blue.shade600,
      isExpense: true,
    ),
  ].obs;

  void changeTab(String tab) {
    selectedTab.value = tab;
  }
}