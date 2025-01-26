import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class FavouriteUserScreen extends StatefulWidget {
  const FavouriteUserScreen({super.key});

  @override
  State<FavouriteUserScreen> createState() => _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavouriteUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.favorite,
              size: 40,
              weight: 400,
              color: AppColors.textDark,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Favourite User',
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
