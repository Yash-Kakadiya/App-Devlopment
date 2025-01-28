import 'package:flutter/material.dart';

import 'app_colors.dart';

class Components {
  static AppBar getAppBar({required IconData icon, required String title}) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            icon,
            size: 25,
            weight: 400,
            color: AppColors.textDark,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primary,
    );
  }
}
