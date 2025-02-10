import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/utils/components.dart';

class EducationCareerOnboardingScreen extends StatefulWidget {
  TextEditingController educationController;
  TextEditingController occupationController;
  TextEditingController employedInController;
  TextEditingController incomeController;
  GlobalKey<FormState> formKey;

  EducationCareerOnboardingScreen({
    super.key,
    required this.educationController,
    required this.occupationController,
    required this.employedInController,
    required this.incomeController,
    required this.formKey,
  });
  @override
  _EducationCareerOnboardingScreenState createState() =>
      _EducationCareerOnboardingScreenState();
}

class _EducationCareerOnboardingScreenState
    extends State<EducationCareerOnboardingScreen> {
  List<String> educationList = [
    'High School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctorate',
    'Other'
  ];

  List<String> occupationList = [
    'Software Engineer',
    'Doctor',
    'Teacher',
    'Business Owner',
    'Artist',
    'Freelancer',
    'Other'
  ];

  List<String> employedInList = [
    'Government',
    'Private Sector',
    'Self-Employed',
    'Unemployed',
    'Other'
  ];

  List<String> incomeList = [
    'Less than \₹3,00,000',
    '\₹3,00,000 - \₹6,00,000',
    '\₹6,00,000 - \₹12,00,000',
    'Above \₹12,00,000',
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
            "Tell us about your\neducation & career! 😇",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Providing these details helps others\nget to know the real you. 😉",
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
                  hintText: "Highest Education 🎓",
                  options: educationList,
                  selectedValue: widget.educationController.text,
                  onChanged: (value) {
                    setState(() {
                      widget.educationController.text = value;
                    });
                  },
                ),
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
