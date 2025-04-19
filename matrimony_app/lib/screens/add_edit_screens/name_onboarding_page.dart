import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../utils/components.dart';

/// A stateful widget that represents the onboarding page for entering the user's full name.
class NameOnboardingPage extends StatefulWidget {
  /// Controller for the full name text input.
  final TextEditingController fullNameController;

  /// Global key for the form that wraps the full name input.
  final GlobalKey<FormState> formKey;

  /// Creates a [NameOnboardingPage] widget.
  const NameOnboardingPage({
    super.key,
    required this.fullNameController,
    required this.formKey,
  });

  @override
  State<NameOnboardingPage> createState() => _NameOnboardingPageState();
}

/// State class for [NameOnboardingPage] that builds the UI for the name input.
class _NameOnboardingPageState extends State<NameOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      // Assign the provided form key to validate this form.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text prompting the user to build their profile.
          const Text(
            "Let's build your profile!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle text asking for the user's name.
          const Text(
            "What's your good name? 😇",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 24),
          // Name input field obtained via a custom helper from Components.
          Components.getFormField(
            context: context,
            controller: widget.fullNameController,
            keyboardType: TextInputType.name,
            labelText: '🙂 Full Name',
            hintText: 'Enter Full Name 🙃',
            textCapitalization: TextCapitalization.sentences,
            // Validator function to check for a valid full name.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter name\n(3-50 characters, alphabets only) 😇';
              }
              // Regular expression that allows alphabets, spaces, apostrophes, periods, and hyphens.
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
