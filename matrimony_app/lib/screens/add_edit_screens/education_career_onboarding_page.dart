import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/utils/components.dart';

import '../../core/app_constants.dart';

/// A stateful widget for the education and career onboarding page.
/// This page allows the user to select their highest education, occupation,
/// employment sector, and annual income using selection lists.
class EducationCareerOnboardingPage extends StatefulWidget {
  /// Controller for the education field.
  final TextEditingController educationController;

  /// Controller for the occupation field.
  final TextEditingController occupationController;

  /// Controller for the employed-in field.
  final TextEditingController employedInController;

  /// Controller for the income field.
  final TextEditingController incomeController;

  /// Global key for the form on this page.
  final GlobalKey<FormState> formKey;

  /// Creates an [EducationCareerOnboardingPage] widget.
  const EducationCareerOnboardingPage({
    super.key,
    required this.educationController,
    required this.occupationController,
    required this.employedInController,
    required this.incomeController,
    required this.formKey,
  });

  @override
  State<EducationCareerOnboardingPage> createState() =>
      _EducationCareerOnboardingPageState();
}

/// State class for [EducationCareerOnboardingPage] that builds the UI and handles user interactions.
class _EducationCareerOnboardingPageState
    extends State<EducationCareerOnboardingPage> {
  // List of education options.
  List<String> educationList = EDUCATION_LIST;

  // List of occupation options.
  List<String> occupationList = OCCUPATION_LIST;

  // List of employment sector options.
  List<String> employedInList = EMPLOYEDIN_LIST;

  // List of annual income options.
  List<String> incomeList = INCOME_LIST;

  @override
  Widget build(BuildContext context) {
    return Form(
      // Assign the provided form key to this form.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text prompting the user to provide education and career details.
          const Text(
            "Tell us about your\neducation & career! 😇",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle text giving additional context about why these details are needed.
          const Text(
            "Providing these details helps others\nget to know the real you. 😉",
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
                // Dropdown selection for highest education.
                Components.getSelectionList(
                  hintText: "Highest Education 🎓",
                  options: educationList,
                  selectedValue: widget.educationController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.educationController.text = value;
                    });
                  },
                ),
                // Dropdown selection for occupation.
                Components.getSelectionList(
                  hintText: "Occupation 🤵",
                  options: occupationList,
                  selectedValue: widget.occupationController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.occupationController.text = value;
                    });
                  },
                ),
                // Dropdown selection for employment sector.
                Components.getSelectionList(
                  hintText: "Employed In 👷‍♂️",
                  options: employedInList,
                  selectedValue: widget.employedInController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.employedInController.text = value;
                    });
                  },
                ),
                // Dropdown selection for annual income.
                Components.getSelectionList(
                  hintText: "Annual Income 🤑",
                  options: incomeList,
                  selectedValue: widget.incomeController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.incomeController.text = value;
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
