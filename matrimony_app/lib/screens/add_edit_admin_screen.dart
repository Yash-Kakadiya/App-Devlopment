import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import '../data/admin/admin.dart';
import '../data/admin/admin_prefs.dart';
import '../utils/components.dart';

/// A screen for adding or editing an admin profile.
/// If [adminToEdit] is provided, the screen pre-fills the fields for editing;
/// otherwise, it works in "add" mode.
class AddEditAdminScreen extends StatefulWidget {
  final Admin? adminToEdit; // Optional admin parameter for editing

  const AddEditAdminScreen({super.key, this.adminToEdit});

  @override
  State<AddEditAdminScreen> createState() => _AddEditAdminScreenState();
}

class _AddEditAdminScreenState extends State<AddEditAdminScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  // Use a default image path for simplicity.
  final String defaultImagePath = 'assets/icons/main_icon.png';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // If an admin is provided for editing, prefill the text controllers.
    if (widget.adminToEdit != null) {
      usernameController.text = widget.adminToEdit!.username;
      passwordController.text = widget.adminToEdit!.password;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Called when the admin presses the save button.
  /// In "add" mode, the new admin is appended to the stored list.
  /// In "edit" mode, the existing admin is updated.
  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      Admin admin = Admin(
        username: username,
        password: password,
      );

      // Retrieve the current list of admins.
      List<Admin> admins = await AdminPrefs.getAdmins();

      if (widget.adminToEdit != null) {
        // Editing mode: update the existing admin.
        // Find the index of the admin to edit by matching the username.
        int index = admins
            .indexWhere((a) => a?.username == widget.adminToEdit!.username);
        if (index != -1) {
          admins[index] = admin; // Replace with the updated admin.
        }
      } else {
        // Adding mode: add the new admin.
        admins.add(admin);
      }

      // Save the updated list of admins.
      await AdminPrefs.saveAdmins(admins);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Change the app bar title based on mode.
    String titleText = widget.adminToEdit != null ? "Edit Admin" : "Add Admin";

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Admin Name Field.
              Components.getFormField(
                context: context,
                controller: usernameController,
                keyboardType: TextInputType.name,
                labelText: '🙂 Admin Name',
                hintText: 'Enter Admin Name 🙃',
                textCapitalization: TextCapitalization.sentences,
                // Validate that the name is between 3 and 10 alphabetic characters.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter name\n(2-10 characters, alphabets only) 😇';
                  }
                  var regex = RegExp(r"^[a-zA-Z\s'.-]{2,10}$");
                  if (!regex.hasMatch(value)) {
                    return 'Enter a valid name\n(2-10 characters, alphabets only) 😇';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Password Field.
              Components.getFormField(
                context: context,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                labelText: '🗝️ Password',
                hintText: 'Enter your password 🙃',
                obscureText: isPasswordHidden,
                // Suffix icon to toggle password visibility.
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
              const Spacer(),
              ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text("Save Admin 😈"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
