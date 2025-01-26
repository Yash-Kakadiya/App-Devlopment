import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.menu_book,
              size: 40,
              weight: 400,
              color: AppColors.textDark,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
