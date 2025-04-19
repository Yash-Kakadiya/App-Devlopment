import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../utils/components.dart';

/// A stateful widget for the password onboarding page.
/// This page collects the user's password and confirmation password as part of the onboarding process.
class PasswordOnboardingPage extends StatefulWidget {
  /// Controller for the password input field.
  final TextEditingController passwordController;

  /// Controller for the confirm password input field.
  final TextEditingController confirmPasswordController;

  /// Global key for the form used in this onboarding page.
  final GlobalKey<FormState> formKey;

  /// Creates a [PasswordOnboardingPage] widget.
  const PasswordOnboardingPage({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  State<PasswordOnboardingPage> createState() => _PasswordOnboardingPageState();
}

/// State class for [PasswordOnboardingPage] that builds the UI and handles password visibility toggling.
class _PasswordOnboardingPageState extends State<PasswordOnboardingPage> {
  /// Controls whether the password fields are obscured or visible.
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      // Attach the provided form key to the form for validation.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text prompting the user to set their password.
          const Text(
            "Let's set your password!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          // Password input field using a custom form field component.
          Components.getFormField(
            context: context,
            controller: widget.passwordController,
            keyboardType: TextInputType.visiblePassword,
            labelText: '🗝️ Password',
            hintText: 'Enter your password 🙃',
            textCapitalization: TextCapitalization.sentences,
            // Use the isPasswordHidden flag to obscure the text.
            obscureText: isPasswordHidden,
            // Suffix icon to toggle password visibility.
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isPasswordHidden = !isPasswordHidden;
                });
              },
              child: Icon(
                // Show visibility icon if password is hidden, otherwise show visibility_off.
                isPasswordHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            // Validator function to ensure a strong password is entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Password 😇';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters long 🔢';
              }
              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Password must contain at least one uppercase letter 🔠';
              }
              if (!RegExp(r'[a-z]').hasMatch(value)) {
                return 'Password must contain at least one lowercase letter 🔡';
              }
              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Password must contain at least one digit 🔢';
              }
              if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                return 'Password must contain at least one special character (!@#\$&*~) 💥';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Confirm Password input field using a custom form field component.
          Components.getFormField(
            context: context,
            controller: widget.confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            labelText: '🔐 Confirm Password',
            hintText: 'Enter your password again 🙃',
            textCapitalization: TextCapitalization.sentences,
            // Use the same isPasswordHidden flag for consistency.
            obscureText: isPasswordHidden,
            // Validator to ensure the confirm password field matches the password field.
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter confirm password 😇';
              }
              if (value != widget.passwordController.text) {
                return 'Passwords do not match 😇';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
