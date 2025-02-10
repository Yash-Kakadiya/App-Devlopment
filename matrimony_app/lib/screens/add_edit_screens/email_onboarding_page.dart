import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../data/models/user_model.dart';
import '../../utils/components.dart';
import '../../utils/string_constants.dart';

class EmailOnBoardingPage extends StatefulWidget {
  bool isAdd = true;
  TextEditingController emailController;
  GlobalKey<FormState> formKey;

  EmailOnBoardingPage({
    super.key,
    required this.isAdd,
    required this.emailController,
    required this.formKey,
  });

  @override
  State<EmailOnBoardingPage> createState() => _EmailOnBoardingPageState();
}

class _EmailOnBoardingPageState extends State<EmailOnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title texts
          const Text(
            "Give us your email!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Trust us to respect your space. Your email will only hear from us when it truly matters! 😉",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 24),
          // Email input field
          Components.getFormField(
            context: context,
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: '📧 Email Address',
            hintText: 'Enter your Email 🙃',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter email address 😇';
              }
              var regex = RegExp(r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$");
              if (!regex.hasMatch(value)) {
                return 'Enter a valid email address 😇\nfor e.g: example@email.com';
              }
              if (widget.isAdd) {
                if (isUserRegistered(value)) {
                  return 'Email is already registered 😇.';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  bool isUserRegistered(String value) {
    var userList = UserModel.getAllUsers();
    for (int i = 0; i < userList.length; i++) {
      if (userList[i][EMAIL] == value) {
        return true;
      }
    }
    return false;
  }
}
