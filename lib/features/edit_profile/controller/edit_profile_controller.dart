import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_wallet/services/shared_preference_service.dart';

class EditProfileController extends GetxController {
  final userName = ''.obs;
  final userEmail = ''.obs;
  final avatarUrl = ''.obs;
  final isLoading = false.obs;

  // Observable for picked image
  var pickedImage = Rxn<XFile>();
  final ImagePicker _picker = ImagePicker();

  // Text Controllers
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        userEmail.value = user.email ?? '';
        emailController.text = userEmail.value;

        // Fetch user profile row from Supabase
        try {
          final data = await Supabase.instance.client
              .from('profiles')
              .select()
              .eq('id', user.id)
              .maybeSingle();

          if (data != null) {
            userName.value = data['full_name'] ?? (user.userMetadata?['full_name'] ?? '');
            avatarUrl.value = data['avatar_url'] ?? '';
            phoneController.text = data['phone'] ?? '';
          } else {
            userName.value = user.userMetadata?['full_name'] ?? '';
            phoneController.text = '';
          }
        } catch (e) {
          userName.value = user.userMetadata?['full_name'] ?? '';
        }

        usernameController.text = userName.value;
      } else {
        // Fallback to SharedPreferences if currentUser session is pending
        final savedUserId = await SharedPreferenceService.getUserId();
        if (savedUserId != null) {
          try {
            final data = await Supabase.instance.client
                .from('profiles')
                .select()
                .eq('id', savedUserId)
                .maybeSingle();

            if (data != null) {
              userName.value = data['full_name'] ?? '';
              userEmail.value = data['email'] ?? '';
              avatarUrl.value = data['avatar_url'] ?? '';
              phoneController.text = data['phone'] ?? '';

              usernameController.text = userName.value;
              emailController.text = userEmail.value;
            }
          } catch (e) {
            debugPrint('Error fetching profile from DB: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = image;
    }
  }

  Future<void> onUpdateProfile() async {
    try {
      isLoading.value = true;
      final user = Supabase.instance.client.auth.currentUser;
      // ignore: avoid_print
      print("USER ID: ${user?.id}");

      if (user != null) {
        // 1. Upload avatar image if a new image was picked
        if (pickedImage.value != null) {
          final imageFile = File(pickedImage.value!.path);
          final filePath = '${user.id}/avatar.jpg';
          // ignore: avoid_print
          print("FILE PATH: $filePath");

          try {
            await Supabase.instance.client.storage.createBucket(
              'avatars',
              const BucketOptions(public: true),
            );
          } catch (e) {
            // Bucket may already exist or client key doesn't have create bucket permissions
          }

          await Supabase.instance.client.storage
              .from('avatars')
              .upload(
                filePath,
                imageFile,
                fileOptions: const FileOptions(
                  upsert: true,
                ),
              );

          final rawImageUrl = Supabase.instance.client.storage
              .from('avatars')
              .getPublicUrl(filePath);

          // Append timestamp to bust network/Flutter image cache
          final imageUrl = '$rawImageUrl?t=${DateTime.now().millisecondsSinceEpoch}';

          await Supabase.instance.client
              .from('profiles')
              .update({
                'avatar_url': imageUrl,
              })
              .eq('id', user.id);

          avatarUrl.value = imageUrl;
          debugPrint('SUCCESS: Avatar image uploaded successfully. Image URL: $imageUrl');
        }

        // 2. Update profile fields
        await Supabase.instance.client
            .from('profiles')
            .update({
              'full_name': usernameController.text.trim(),
              'phone': phoneController.text.trim(),
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', user.id);

        userName.value = usernameController.text.trim();
        debugPrint('SUCCESS: Profile details updated successfully for user ID: ${user.id}');
      } else {
        debugPrint('WARNING: Cannot update profile. No authenticated user found.');
      }

      Get.back();
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('ERROR: Exception occurred while updating profile: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}

