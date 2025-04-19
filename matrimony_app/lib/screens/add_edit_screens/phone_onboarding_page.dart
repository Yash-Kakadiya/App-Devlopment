import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_colors.dart';
import '../../services/user_model.dart';
import '../../utils/components.dart';
import '../../core/app_constants.dart';

/// A stateful widget for the phone onboarding page.
/// This page is used to collect the user's mobile phone number as part of the onboarding process.
class PhoneOnboardingPage extends StatefulWidget {
  /// Flag to indicate whether this is for adding a new user (true) or editing an existing user (false).
  bool isAdd = true;

  /// Controller to manage the phone number input text.
  final TextEditingController phoneController;

  /// Global key for the form used in this onboarding page.
  final GlobalKey<FormState> formKey;

  /// Creates a [PhoneOnboardingPage] widget.
  PhoneOnboardingPage({
    super.key,
    required this.isAdd,
    required this.phoneController,
    required this.formKey,
  });

  @override
  State<PhoneOnboardingPage> createState() => _PhoneOnboardingPageState();
}

/// State class for [PhoneOnboardingPage] that builds the UI and handles phone number validation.
class _PhoneOnboardingPageState extends State<PhoneOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      // Attach the form key to enable validation.
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text prompting the user to enter their phone number.
          const Text(
            "Enter you phone📲 number.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 32),
          // Phone input field created using a custom component helper.
          // (Note: The comment below says "Name input field", but it is actually used for phone number input.)
          Components.getFormField(
            context: context,
            controller: widget.phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              // Allow digits only.
              FilteringTextInputFormatter.digitsOnly,
              // Limit the input to 10 digits.
              LengthLimitingTextInputFormatter(10),
            ],
            labelText: '📱 Mobile number',
            hintText: 'Enter your mobile number 🙃',
            // Validator function to ensure a valid 10-digit mobile number is entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter mobile number 😇';
              }
              // Regular expression to check for exactly 10 digits.
              var regex = RegExp(r"^[0-9]{10}$");
              if (!regex.hasMatch(value)) {
                return 'Enter a valid 10-digit mobile number 😇.';
              }
              // If adding a new user, check if the mobile number is already registered.
              // if (widget.isAdd) {
              //   if (await isUserRegistered(value)) {
              //     return 'Mobile number is already registered 😇.';
              //   }
              // }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Checks whether the provided phone number [value] is already registered.
  ///
  /// Iterates through the user list and returns true if a user with the same phone number exists.
  Future<bool> isUserRegistered(String value) async {
    var userList = await UserModel.getAllUsers();
    for (int i = 0; i < userList.length; i++) {
      if (userList[i][PHONE] == value) {
        return true;
      }
    }
    return false;
  }
}
