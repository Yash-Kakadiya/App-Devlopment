import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/utils/components.dart';

class SocialStatusOnboardingScreen extends StatefulWidget {
  TextEditingController maritalStatusController;
  TextEditingController motherTongueController;
  TextEditingController religionController;
  GlobalKey<FormState> formKey;

  SocialStatusOnboardingScreen({
    super.key,
    required this.maritalStatusController,
    required this.motherTongueController,
    required this.religionController,
    required this.formKey,
  });
  @override
  _SocialStatusOnboardingScreenState createState() =>
      _SocialStatusOnboardingScreenState();
}

class _SocialStatusOnboardingScreenState
    extends State<SocialStatusOnboardingScreen> {
  List<String> maritalStatusList = [
    'Never Married',
    'Married',
    'Divorced',
    'Widowed',
    'Separated',
  ];

  List<String> motherTongueList = [
    'Gujarati',
    'Hindi',
    'English',
    'Bengali',
    'Telugu',
    'Marathi',
    'Tamil',
    'Urdu',
    'Malayalam',
    'Kannada',
    'Odia',
    'Punjabi',
    'Assamese',
    'Maithili',
    'Other',
  ];

  List<String> religionList = [
    'Hinduism 🕉️',
    'Islam ☪️',
    'Christianity ✝️',
    'Buddhism ☸️',
    'Sikhism 🪯',
    'Jainism 🛕',
    'Judaism ✡️',
    'Shinto ⛩️',
    'Taoism ☯️',
    'Zoroastrianism 🔥',
    'Baháʼí Faith ⭐',
    'Confucianism 🎓',
    'Paganism 🍀',
    'Animism 🌿',
    'Rastafarianism 🇪🇹',
    'Druze 🌕',
    'Shamanism 🪄',
    'Cao Dai ☯️',
    'Tenrikyo 🙏',
    'Seicho-no-Ie 🌸',
    'Cheondoism ☀️',
    'Wicca 🔮',
    'Deism 🌞',
    'Agnosticism 🤔',
    'Atheism 🚫',
    'Spiritual but not religious 🛐',
    'Other 🏛️',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title texts
          const Text(
            "Tell us about your\nsocial status! 😇",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Provide these details to enhance your match potential ⚡",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Components.getSelectionList(
                  hintText: "Marital Status 🫂",
                  options: maritalStatusList,
                  selectedValue: widget.maritalStatusController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.maritalStatusController.text = value;
                    });
                  },
                ),
                Components.getSelectionList(
                  hintText: "Mother Tongue 🗣️",
                  options: motherTongueList,
                  selectedValue: widget.motherTongueController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.motherTongueController.text = value;
                    });
                  },
                ),
                Components.getSelectionList(
                  hintText: "Religion 🏳️",
                  options: religionList,
                  selectedValue: widget.religionController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.religionController.text = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
