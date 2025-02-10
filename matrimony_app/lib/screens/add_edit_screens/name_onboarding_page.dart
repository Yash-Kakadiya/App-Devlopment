import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../utils/components.dart';

class NameOnboardingPage extends StatefulWidget {
  TextEditingController fullNameController;
  GlobalKey<FormState> formKey;

  NameOnboardingPage({
    super.key,
    required this.fullNameController,
    required this.formKey,
  });

  @override
  State<NameOnboardingPage> createState() => _NameOnboardingPageState();
}

class _NameOnboardingPageState extends State<NameOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title texts
          const Text(
            "Let's build your profile!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "What's your good name? 😇",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 24),
          // Name input field
          Components.getFormField(
            context: context,
            controller: widget.fullNameController,
            keyboardType: TextInputType.name,
            labelText: '🙂 Full Name',
            hintText: 'Enter Full Name 🙃',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter valid name\n(3-50 characters, alphabets only) 😇';
              }
              var regex = RegExp(r"^[a-zA-Z\s'.-]{3,50}$");
              if (!regex.hasMatch(value)) {
                return 'Enter a valid full name\n(3-50 characters, alphabets only) 😇';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
