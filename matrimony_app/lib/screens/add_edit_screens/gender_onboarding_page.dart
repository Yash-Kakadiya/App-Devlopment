import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';

/// A stateful widget representing the gender selection onboarding page.
/// It displays two cards (one for male and one for female) and allows the user
/// to select their gender. The selection is stored in the provided [genderController].
class GenderOnboardingPage extends StatefulWidget {
  /// The user's name to personalize the prompt.
  final String name;

  /// A [TextEditingController] that stores the selected gender.
  final TextEditingController genderController;

  /// A global key for the form in this page.
  final GlobalKey<FormState> formKey;

  /// Creates a [GenderOnboardingPage] widget.
  const GenderOnboardingPage({
    super.key,
    required this.name,
    required this.genderController,
    required this.formKey,
  });

  @override
  State<GenderOnboardingPage> createState() => _GenderOnboardingPageState();
}

/// State class for [GenderOnboardingPage] that builds the UI and handles user interactions.
class _GenderOnboardingPageState extends State<GenderOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      // Attach the provided form key to enable validation if needed.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text asking the user for their gender.
          Text(
            "${widget.name}, What is your gender?",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          // Row containing two gender selection cards.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Male gender selection card.
              genderCard("male", "assets/images/male_passport.png"),
              const SizedBox(width: 20),
              // Female gender selection card.
              genderCard("female", "assets/images/female_passport.png"),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a gender selection card for a given [gender] and corresponding [imagePath].
  ///
  /// When tapped, the card updates the [genderController] with the selected gender.
  Widget genderCard(String gender, String imagePath) {
    // Determine if the current card is selected by comparing with the value in the gender controller.
    bool isSelected = (widget.genderController.text == gender);
    return GestureDetector(
      onTap: () {
        // When tapped, update the genderController and refresh the UI.
        setState(() {
          widget.genderController.text = gender;
        });
      },
      child: Container(
        width: 120,
        height: 180,
        decoration: BoxDecoration(
          // Set the border color based on selection status.
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
            // Display an icon to indicate whether this card is selected.
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(height: 10),
            // Display the gender image from the provided asset path.
            Image.asset(
              imagePath,
              width: 100,
            ),
            const SizedBox(height: 5),
            // Display the gender text.
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
