import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrimony_app/screens/about_us_screen.dart';
import 'package:matrimony_app/screens/homepage.dart';
import '../core/app_colors.dart';
import '../screens/dashboard_screen.dart';
import '../screens/onboarding_screen.dart';

class Components {
  static AppBar getAppBar({
    scaffoldKey,
    required IconData icon,
    required String title,
  }) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          size: 25,
          weight: 400,
          color: AppColors.lightText,
        ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer(); // Opens sidebar drawer
          print('ok');
        },
      ),
      title: Row(
        children: [
          Icon(
            icon,
            size: 25,
            weight: 400,
            color: AppColors.lightText,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.pink[400],
    );
  }

  static Drawer getDrawer({
    required context,
  }) {
    return Drawer(
      child: Column(
        children: [
          // Sidebar Header with Profile Image and Name
          UserAccountsDrawerHeader(
            onDetailsPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Homepage(screenIdx: 3)),
              );
            },
            accountName: const Text(
              "Yash Kakadiya",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("yashkakadiya931@gmail.com"),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const Homepage(screenIdx: 3)),
                );
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/ma_about_us.gif'),
              ),
            ),
            decoration: const BoxDecoration(color: AppColors.primary),
          ),

          // Sidebar Options
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primary),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  static TextFormField getFormField({
    required context,
    required keyboardType,
    required controller,
    required validator,
    required labelText,
    required hintText,
    obscureText = false,
    suffixIcon,
    inputFormatters,
  }) {
    return TextFormField(
      onTapOutside: (PointerDownEvent event) {
        // Optionally, you can print the event details or do other actions.
        debugPrint('Tapped outside: ${event.position}');
        FocusScope.of(context).unfocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: true,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  static Widget getSelectionList({
    required String hintText,
    required List<String> options,
    required String? selectedValue,
    required onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          isExpanded: true,
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            hoverColor: AppColors.primary,
          ),
          value: options.contains(selectedValue) ? selectedValue : null,
          hint: Text(
            hintText,
            style: const TextStyle(color: AppColors.lightText),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Select $hintText 😇";
            }
            return null;
          }, // Passed validator here
        ),
      ],
    );
  }
}
