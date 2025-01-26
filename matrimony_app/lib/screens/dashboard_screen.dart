import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import './add_user_screen.dart';
import './user_list_screen.dart';
import './about_us_screen.dart';
import './favourite_user_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '💑‍ Matrimonial homepage 👨‍👩‍👧‍👦',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dashBoardBtn(
                    btnName: 'Add User',
                    icon: Icons.person_add,
                    screen: const AddUserScreen(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _dashBoardBtn(
                    btnName: 'User List',
                    icon: Icons.list_alt,
                    screen: const UserListScreen(),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dashBoardBtn(
                    btnName: 'Favourite',
                    icon: Icons.favorite,
                    screen: const FavouriteUserScreen(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _dashBoardBtn(
                    btnName: 'About Us',
                    icon: Icons.menu_book,
                    screen: const AboutUsScreen(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashBoardBtn({
    required String btnName,
    required IconData icon,
    required Widget screen,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: InkWell(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => screen,
            ));
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.secondary),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.accent,
              ),
              Text(
                btnName,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.cardBackground,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
