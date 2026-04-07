import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategoryController extends GetxController {
  final List<CategoryItem> categories = [
    CategoryItem(
      name: 'Food',
      icon: Icons.restaurant_rounded,
      color: Colors.blue,
    ),
    CategoryItem(
      name: 'Transport',
      icon: Icons.directions_bus_rounded,
      color: Colors.lightBlueAccent,
    ),
    CategoryItem(
      name: 'Medicine',
      icon: Icons.medication_rounded,
      color: Colors.blue.shade300,
    ),
    CategoryItem(
      name: 'Groceries',
      icon: Icons.shopping_bag_rounded,
      color: Colors.lightBlue.shade400,
    ),
    CategoryItem(
      name: 'Rent',
      icon: Icons.vpn_key_rounded,
      color: Colors.blue.shade400,
    ),
    CategoryItem(
      name: 'Gifts',
      icon: Icons.card_giftcard_rounded,
      color: Colors.lightBlue.shade300,
    ),
    CategoryItem(
      name: 'Savings',
      icon: Icons.savings_rounded,
      color: Colors.blue.shade400,
    ),
    CategoryItem(
      name: 'Entertainment',
      icon: Icons.confirmation_number_rounded,
      color: Colors.lightBlue.shade400,
    ),
    CategoryItem(
      name: 'More',
      icon: Icons.add_rounded,
      color: Colors.blue.shade300,
    ),
  ];
}
