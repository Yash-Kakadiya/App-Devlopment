import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrimony_app/utils/components.dart';

import '../core/app_colors.dart';
import 'dashboard_screen.dart';

/// A stateful widget that displays the "Welcome Back" screen,
/// including a custom wave background, logo, welcome text, and a button
/// to navigate to the main dashboard.
class WelcomeBackScreen extends StatefulWidget {
  final String adminIdentifier;

  /// Creates a [WelcomeBackScreen] widget.
  const WelcomeBackScreen({
    super.key,
    required this.adminIdentifier,
  });

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

/// The state class for [WelcomeBackScreen].
class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the screen width and height for responsive design.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Set the system UI overlay style to make the status bar transparent
    // and use light-colored icons.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness: Brightness.light, // Light status bar icons
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Positioned widget to display the top wave background.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              // Use the custom WaveClipper to create a wave effect.
              clipper: WaveClipper(),
              child: Container(
                height: screenHeight * 0.3, // 30% of the screen height
                color:
                    AppColors.primary, // Primary color for the wave background
              ),
            ),
          ),

          // Main content area placed safely within the device's safe area.
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spacer from the top; can be adjusted as needed.
                  const SizedBox(height: 200),

                  // App logo image centered on the screen.
                  Image.asset(
                    'assets/images/logo.png',
                    width: screenWidth * 0.6, // 60% of the screen width
                  ),

                  // const SizedBox(height: 40),
                  const Spacer(),
                  // Welcome text message displayed to the user.
                  Text(
                    'Hello, ${widget.adminIdentifier}\n Welcome back!',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // Spacer to push the button to the bottom.
                  const Spacer(),

                  // "Let's Get Started" button that navigates to the DashboardScreen.
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        Components.createRoute(
                          DashboardScreen(
                            adminIdentifier: widget.adminIdentifier,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Let's Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 66),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom clipper that creates a wave shape for the top background.
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Create a new Path to define the custom clipping shape.
    Path path = Path();
    // Start at the top left corner and draw a line down to 75% of the height.
    path.lineTo(0, size.height * 0.75);

    // Create the first quadratic bezier curve for the left half of the wave.
    path.quadraticBezierTo(
      size.width * 0.25, // Control point X (25% of width)
      size.height, // Control point Y (full height)
      size.width * 0.5, // End point X (50% of width)
      size.height * 0.85, // End point Y (85% of height)
    );

    // Create the second quadratic bezier curve for the right half of the wave.
    path.quadraticBezierTo(
      size.width * 0.75, // Control point X (75% of width)
      size.height * 0.7, // Control point Y (70% of height)
      size.width, // End point X (full width)
      size.height * 0.85, // End point Y (85% of height)
    );

    // Draw a line to the top right corner.
    path.lineTo(size.width, 0);
    // Close the path to complete the shape.
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
