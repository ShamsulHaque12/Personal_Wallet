import 'package:get/get.dart';
import 'package:personal_wallet/features/home_screen/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:personal_wallet/features/profile_screen/screen/profile_screen.dart';

class NavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeScreen(),
    const Scaffold(body: Center(child: Text('Search Screen'))),
    const Scaffold(body: Center(child: Text('Transactions Screen'))),
    const Scaffold(body: Center(child: Text('Reports Screen'))),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
