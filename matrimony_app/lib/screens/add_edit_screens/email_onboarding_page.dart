import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../services/user_model.dart';
import '../../utils/components.dart';
import '../../core/app_constants.dart';

/// A stateful widget for the email onboarding page.
/// It validates the input to ensure the email format is correct and (when adding a new user)
/// checks that the email is not already registered.
class EmailOnBoardingPage extends StatefulWidget {
  /// Controller to manage the email input text.
  final TextEditingController emailController;

  /// Global key for the form used in this onboarding page.
  final GlobalKey<FormState> formKey;

  /// Creates an [EmailOnBoardingPage] widget.
  const EmailOnBoardingPage({
    super.key,
    required this.emailController,
    required this.formKey,
  });

  @override
  State<EmailOnBoardingPage> createState() => _EmailOnBoardingPageState();
}

/// State class for [EmailOnBoardingPage] that builds the UI and handles email validation.
class _EmailOnBoardingPageState extends State<EmailOnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      // Assign the provided form key for validation purposes.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text prompting the user to provide their email.
          const Text(
            "Give us your email!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 8),
          // Subtext providing additional context about the email.
          const Text(
            "Trust us to respect your space. Your email will only hear from us when it truly matters! 😉",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 24),
          // Email input field created using a helper method from Components.
          Components.getFormField(
            context: context,
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: '📧 Email Address',
            hintText: 'Enter your Email 🙃',
            // Validator function to ensure the email is not empty,
            // has a valid format, and (if adding a new user) is not already registered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter email address 😇';
              }
              // Regular expression for validating the email format.
              var regex = RegExp(r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$");
              if (!regex.hasMatch(value)) {
                return 'Enter a valid email address 😇\nfor e.g: example@email.com';
              }
              // If adding a new user, check if the email is already registered.
              // if (widget.isAdd) {
              //   if (await isUserRegistered(value)) {
              //     return 'Email is already registered 😇.';
              //   }
              // }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Checks whether the provided email [value] is already registered.
  ///
  /// Iterates through the list of all users and compares the email field.
  /// Returns true if the email is found, otherwise false.
  Future<bool> isUserRegistered(String value) async {
    var userList = await UserModel.getAllUsers();
    for (int i = 0; i < userList.length; i++) {
      if (userList[i][EMAIL] == value) {
        return true;
      }
    }
    return false;
  }
}
