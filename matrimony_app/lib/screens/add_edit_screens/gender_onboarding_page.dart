import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';

class GenderOnboardingPage extends StatefulWidget {
  String name;
  TextEditingController genderController;
  GlobalKey<FormState> formKey;

  GenderOnboardingPage({
    super.key,
    required this.name,
    required this.genderController,
    required this.formKey,
  });

  @override
  State<GenderOnboardingPage> createState() => _GenderOnboardingPageState();
}

class _GenderOnboardingPageState extends State<GenderOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "${widget.name}, What is your gender?",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),

          // Gender Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              genderCard("male", "assets/images/male_passport.png"),
              const SizedBox(width: 20),
              genderCard("female", "assets/images/female_passport.png"),
            ],
          ),
        ],
      ),
    );
  }

  Widget genderCard(String gender, String imagePath) {
    bool isSelected = (widget.genderController.text == gender);
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.genderController.text = gender;
        });
      },
      child: Container(
        width: 120,
        height: 180,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(height: 10),
            Image.asset(
              imagePath,
              width: 100,
            ),
            const SizedBox(height: 5),
            Text(
              gender,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
