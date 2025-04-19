import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/utils/components.dart';

import '../../core/app_constants.dart';

/// A stateful widget for the social status onboarding page.
/// This page allows the user to select their marital status, mother tongue,
/// and religion using selection lists.
/// The selected values are stored in the provided controllers.
class SocialStatusOnboardingPage extends StatefulWidget {
  /// Controller to store the selected marital status.
  final TextEditingController maritalStatusController;

  /// Controller to store the selected mother tongue.
  final TextEditingController motherTongueController;

  /// Controller to store the selected religion.
  final TextEditingController religionController;

  /// Global key for the form used on this page.
  final GlobalKey<FormState> formKey;

  /// Creates a [SocialStatusOnboardingPage] widget.
  const SocialStatusOnboardingPage({
    super.key,
    required this.maritalStatusController,
    required this.motherTongueController,
    required this.religionController,
    required this.formKey,
  });

  @override
  State<SocialStatusOnboardingPage> createState() =>
      _SocialStatusOnboardingPageState();
}

/// State class for [SocialStatusOnboardingPage] that builds the UI and manages user interactions.
class _SocialStatusOnboardingPageState
    extends State<SocialStatusOnboardingPage> {
  /// List of available marital status options.
  List<String> maritalStatusList = MARITAL_STATUS_LIST;

  /// List of available mother tongue options.
  List<String> motherTongueList = MOTHER_TONGUE_LIST;

  /// List of available religion options.
  List<String> religionList = RELIGION_LIST;

  @override
  Widget build(BuildContext context) {
    return Form(
      // Assign the provided form key for validation.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text asking the user for their social status.
          const Text(
            "Tell us about your\nsocial status! 😇",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle text providing context to enhance match potential.
          const Text(
            "Provide these details to enhance your match potential ⚡",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          // Expanded widget to fill available vertical space with selection lists.
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Dropdown for selecting marital status.
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
                // Dropdown for selecting mother tongue.
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
                // Dropdown for selecting religion.
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
