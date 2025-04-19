import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/add_edit_user_screen.dart';
import 'package:matrimony_app/screens/homepage.dart';
import 'package:matrimony_app/screens/onboarding_screen.dart';
import 'package:matrimony_app/utils/components.dart';
import '../core/app_colors.dart';

/// The DashboardScreen serves as the main landing page for HeartLink.net,
/// providing navigation options to various parts of the app such as adding a profile,
/// viewing profiles, accessing favorites, and learning about the app.
/// It also includes a logout button.
class DashboardScreen extends StatefulWidget {
  final String adminIdentifier;

  /// Creates a DashboardScreen widget.
  const DashboardScreen({
    super.key,
    required this.adminIdentifier,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

/// State class for DashboardScreen that builds the UI and handles navigation.
class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive UI design.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        // The outer container with a vertical gradient background.
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Gradient transitions through white, secondary color, then primary color.
              colors: [
                Colors.white,
                AppColors.secondary,
                AppColors.primary,
              ],
            ),
          ),
          child: SafeArea(
            // SafeArea ensures content doesn't overlap with system UI elements.
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Row for displaying the app logo at the top.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: screenWidth *
                          0.5, // Adjusts logo width based on screen size.
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Main content card that holds welcome text, options grid, and logout button.
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    // White card with rounded corners.
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Welcome message with app name.
                        const Text(
                          'Welcome to\nHeartLink.net',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Subtext tagline.
                        const Text(
                          'Where every 💖 finds its perfect 🔗.',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.lightText,
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Grid of navigation options.
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2, // Two buttons per row.
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            children: [
                              // Dashboard button for adding a new profile (with confirmation dialog).
                              dashBoardBtn(
                                  icon: Icons.person_add,
                                  btnName: 'Add Profile',
                                  screenIdx: 0,
                                  alert: true),
                              // Dashboard button for viewing existing profiles.
                              dashBoardBtn(
                                icon: Icons.people,
                                btnName: 'View Profiles',
                                screenIdx: 1,
                              ),
                              // Dashboard button for accessing favorite profiles.
                              dashBoardBtn(
                                icon: Icons.favorite,
                                btnName: 'Favorites',
                                screenIdx: 2,
                              ),
                              // Dashboard button for the About Us section.
                              dashBoardBtn(
                                icon: Icons.info,
                                btnName: 'About Us',
                                screenIdx: 3,
                              )
                            ],
                          ),
                        ),
                        // Logout button at the bottom of the card.
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 7,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            // Navigates to the OnboardingScreen upon logout.
                            Navigator.pushReplacement(
                              context,
                              Components.createRoute(
                                const OnboardingScreen(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              // Icon container for the logout button.
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFE8EF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.logout,
                                  size: 32,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Logout button label.
                              const Text(
                                'Log out',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a dashboard button widget with an icon and label.
  ///
  /// [btnName] is the label of the button.
  /// [icon] is the icon to display.
  /// [screenIdx] is used to determine which screen to navigate to.
  /// [alert] (optional) indicates if a confirmation dialog should be shown before navigation.
  Widget dashBoardBtn({
    required String btnName,
    required IconData icon,
    required int screenIdx,
    alert = false,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        padding: const EdgeInsets.all(10),
      ),
      onPressed: () {
        if (alert) {
          // If alert is true, show a confirmation dialog before adding a user.
          showAddUserConfirmationDialog(context);
        } else {
          // Otherwise, navigate to the Homepage with the provided screen index.
          Navigator.push(
            context,
            Components.createRoute(
              Homepage(
                adminIdentifier: widget.adminIdentifier,
                screenIdx: screenIdx,
              ),
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon display within a circular container.
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFFFE8EF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 7),
          // Button label text.
          Text(
            btnName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  /// Displays a confirmation dialog before proceeding to add a new user.
  ///
  /// If the user confirms ("Yes 😀"), navigates to the AddEditUserScreen.
  /// If the user declines ("No 🥲"), simply closes the dialog.
  void showAddUserConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add User'),
          content: const Text('Are you sure you want to add user?'),
          actions: [
            // Row containing the "No" and "Yes" buttons.
            Row(
              children: [
                // "No" button: declines the action and closes the dialog.
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      child: const Text(
                        'No 🥲',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                // "Yes" button: confirms the action and navigates to the AddEditUserScreen.
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Yes 😀',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // Pop from dialog box
                        Navigator.pop(context);
                        // Navigate to the AddEditUserScreen for adding a new user.
                        Navigator.push(
                          context,
                          Components.createRoute(
                            AddEditUserScreen(
                              adminIdentifier: widget.adminIdentifier,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
