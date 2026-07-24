import 'package:get/get.dart';

class HelpCenterController extends GetxController {
  final searchQuery = ''.obs;

  final faqs = [
    {
      'question': 'How do I reset my password?',
      'answer': 'Go to Security settings and tap on Change Password.'
    },
    {
      'question': 'How do I change my currency?',
      'answer': 'Go to Settings and tap on Currency.'
    },
    {
      'question': 'Is my data secure?',
      'answer': 'Yes, we use industry-standard encryption to protect your data.'
    },
    {
      'question': 'How do I contact support?',
      'answer': 'You can reach us at support@personalwallet.com'
    },
  ].obs;

  List<Map<String, String>> get filteredFaqs {
    if (searchQuery.value.isEmpty) {
      return faqs;
    }
    return faqs
        .where((faq) =>
            faq['question']!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            faq['answer']!
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  void onContactSupport() {
    Get.snackbar('Support', 'Connecting to support agent...');
  }
}
