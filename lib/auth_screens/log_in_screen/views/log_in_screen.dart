import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:personal_wallet/auth_screens/log_in_screen/controller/log_in_controller.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final LogInController controller = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}