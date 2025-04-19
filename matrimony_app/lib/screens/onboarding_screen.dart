import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/select_admin_screen.dart';
import 'package:matrimony_app/screens/welcome_back_screen.dart';
import 'package:matrimony_app/utils/components.dart';

import '../core/app_colors.dart';
import 'dashboard_screen.dart';

/// The OnboardingScreen displays a series of pages to introduce the app's features.
/// Users can swipe through the pages or use the navigation buttons.
class OnboardingScreen extends StatefulWidget {
  /// Creates an OnboardingScreen widget.
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

/// The state class for OnboardingScreen which manages the PageView and navigation.
class OnboardingScreenState extends State<OnboardingScreen> {
  /// Controller for the PageView that manages the onboarding pages.
  final PageController pageController = PageController();

  /// Keeps track of the current page index in the onboarding flow.
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Obtain the screen width and height for responsive UI design.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // SafeArea prevents UI elements from being obscured by system UI features.
      body: SafeArea(
        child: Column(
          children: [
            // Header section displaying the app logo.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo image.
                  Image.asset(
                    'assets/images/logo.png',
                    width: screenWidth * 0.5,
                    fit: BoxFit.fitWidth,
                  )
                ],
              ),
            ),
            // Expanded PageView that contains the onboarding pages.
            Expanded(
              child: PageView(
                controller: pageController,
                // Update the current page index when the user swipes.
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: const [
                  // First onboarding page.
                  OnboardingPage(
                    image:
                        'assets/images/obimg1.png', // Illustration image for page 1.
                    title: 'Countless Love Journeys',
                    description:
                        'Join us in celebrating the joyous\nstories of couples who found their match.',
                  ),
                  // Second onboarding page.
                  OnboardingPage(
                    image:
                        'assets/images/obimg2.png', // Illustration image for page 2.
                    title: 'Engage with Your Matches ',
                    description:
                        'Chat with your matches to build\na deeper connection. ',
                  ),
                  // Third onboarding page.
                  OnboardingPage(
                    image:
                        'assets/images/obimg3.png', // Illustration image for page 3.
                    title: 'Meet Your Perfect Match',
                    description:
                        'Fix a date and see where\nyour journey leads! ',
                  ),
                ],
              ),
            ),
            // Bottom section with page indicator dots and navigation buttons.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Row of dots indicating the current page in the onboarding flow.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3, // Total number of onboarding pages.
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == currentPage ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          // If the current page is reached or passed, show primary color; else, a light gray.
                          color: index <= currentPage
                              ? AppColors.primary
                              : const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Elevated button for navigation: advances to the next page or to the Dashboard.
                  ElevatedButton(
                    onPressed: () {
                      if (currentPage == 2) {
                        // On the last page, navigate to the main DashboardScreen.
                        Navigator.push(
                          context,
                          Components.createRoute(
                            const SelectAdminScreen(),
                          ),
                        );
                      } else {
                        // Otherwise, animate to the next onboarding page.
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      // Button text changes depending on whether it is the last page.
                      currentPage == 2 ? 'Let\'s Get Started' : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Text button that allows users to skip the onboarding and go to the WelcomeBackScreen.
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        Components.createRoute(
                          const SelectAdminScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A stateless widget that represents a single onboarding page with an image, title, and description.
class OnboardingPage extends StatelessWidget {
  /// The path of the image asset to display on the onboarding page.
  final String image;

  /// The title text for the onboarding page.
  final String title;

  /// The description text for the onboarding page.
  final String description;

  /// Creates an OnboardingPage widget with the provided [image], [title], and [description].
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Obtain screen dimensions for responsive design.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        // Center the content vertically and horizontally.
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display the onboarding image.
          Image.asset(
            image,
            width: screenWidth * 0.7,
            height: screenHeight * 0.4,
          ),
          // Title text of the onboarding page.
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          // Description text, expanded to occupy remaining vertical space.
          Expanded(
            child: Text(
              description,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF757575),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
