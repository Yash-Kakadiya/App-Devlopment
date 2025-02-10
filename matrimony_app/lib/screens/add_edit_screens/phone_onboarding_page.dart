import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_colors.dart';
import '../../data/models/user_model.dart';
import '../../utils/components.dart';
import '../../utils/string_constants.dart';

class PhoneOnboardingPage extends StatefulWidget {
  bool isAdd=true;
  TextEditingController phoneController;
  GlobalKey<FormState> formKey;
  PhoneOnboardingPage({
    super.key,
    required this.isAdd,
    required this.phoneController,
    required this.formKey,
  });

  @override
  State<PhoneOnboardingPage> createState() => _PhoneOnboardingPageState();
}

class _PhoneOnboardingPageState extends State<PhoneOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title texts
          const Text(
            "Enter you phone📲 number.",
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
            controller: widget.phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              // Allow digits only
              FilteringTextInputFormatter.digitsOnly,
              // Limit input to 10 digits
              LengthLimitingTextInputFormatter(10),
            ],
            labelText: '📱 Mobile number',
            hintText: 'Enter your mobile number 🙃',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter mobile number 😇';
              }
              var regex = RegExp(r"^[0-9]{10}$");
              if (!regex.hasMatch(value)) {
                return 'Enter a valid 10-digit mobile number 😇.';
              }
              if (widget.isAdd) {
                if (isUserRegistered(value)) {
                  return 'Mobile number is already registered 😇.';
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
      if (userList[i][PHONE] == value) {
        return true;
      }
    }
    return false;
  }
}
