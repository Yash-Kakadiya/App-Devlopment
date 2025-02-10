import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../utils/components.dart';

class PasswordOnboardingPage extends StatefulWidget {
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey;

  PasswordOnboardingPage({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  State<PasswordOnboardingPage> createState() => _PasswordOnboardingPageState();
}

class _PasswordOnboardingPageState extends State<PasswordOnboardingPage> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title texts
          const Text(
            "Let's set your password!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          // Name input field
          Components.getFormField(
            context: context,
            controller: widget.passwordController,
            keyboardType: TextInputType.visiblePassword,
            labelText: '🗝️ Password',
            hintText: 'Enter your password 🙃',
            obscureText: isPasswordHidden,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isPasswordHidden = !isPasswordHidden;
                });
              },
              child: Icon(
                isPasswordHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Password 😇';
              }
              var regex = RegExp(
                  r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
              if (!regex.hasMatch(value)) {
                return 'Set strong Password 💪:\n Minimum 8 characters\nat least contains 1\n uppercase letter,\n lowercase letter,\n digit,\n special character 😇';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Components.getFormField(
            context: context,
            controller: widget.confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            labelText: '🔐 Confirm Password',
            hintText: 'Enter your password again 🙃',
            obscureText: isPasswordHidden,
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
