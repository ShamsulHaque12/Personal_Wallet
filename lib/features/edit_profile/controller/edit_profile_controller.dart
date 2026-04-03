import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  // Mock data matching the design image (Updated by user)
  final String userName = 'MD Sujon Islam';
  final String userGmail = '25030024@Gmail.Com';
  final String profileImage = 'assets/images/2.png';

  // Observable for picked image
  var pickedImage = Rxn<XFile>();
  final ImagePicker _picker = ImagePicker();

  // Text Controllers
  final usernameController = TextEditingController(text: 'MD Sujon Islam');
  final phoneController = TextEditingController(text: '01928970741');
  final emailController = TextEditingController(text: 'example@example.com');

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = image;
    }
  }

  void onUpdateProfile() {
    Get.back();
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
