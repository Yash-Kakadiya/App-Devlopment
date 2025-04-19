import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/utils/components.dart';
import 'onboarding_screen.dart';

/// A stateful widget representing the splash screen for the HeartLink.net app.
class SplashScreen extends StatefulWidget {
  /// Creates a [SplashScreen] widget.
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// The state class for [SplashScreen] which manages animations and navigation.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  /// Controller to manage the overall animation sequence.
  late AnimationController controller;

  /// Animation for fading in the logo.
  late Animation<double> fadeInAnimation;

  /// Animation for the progress bar's width.
  late Animation<double> progressAnimation;

  /// Animation for fading out the entire splash screen.
  late Animation<double> fadeOutAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController with a duration of 4 seconds.
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Define a fade-in animation for the logo from 0% to 100% opacity.
    // This animation runs during the first 30% of the total animation duration.
    fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    // Define a progress animation for the progress bar that animates its width
    // from 0% to 100% during the interval from 30% to 70% of the total duration.
    progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    // Define a fade-out animation for the entire splash screen from 100% to 0% opacity.
    // This animation runs during the final 30% of the total animation duration.
    fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Start the animation sequence.
    controller.forward().then((_) {
      // Once the animation is complete, and if the widget is still mounted,
      // navigate to the OnboardingScreen.
      if (mounted) {
        Navigator.pushReplacement(
          context,
          Components.createRoute(
            const OnboardingScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the AnimationController to free up resources.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtain the screen width for responsive sizing.
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // AnimatedBuilder rebuilds its child whenever the animation value changes.
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            // Set a vertical gradient background.
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
              ),
            ),
            // Apply a fade-out effect to the entire splash screen.
            child: FadeTransition(
              opacity: fadeOutAnimation,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Fade in the logo image using the fadeInAnimation.
                    FadeTransition(
                      opacity: fadeInAnimation,
                      child: Image.asset(
                        'assets/images/full_logo_white.png',
                        width: screenWidth * 0.8,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Animate the opacity of the progress bar container.
                    AnimatedOpacity(
                      opacity: fadeInAnimation.value,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        // Set the dimensions and background for the progress bar.
                        width: screenWidth * 0.8,
                        height: 6,
                        decoration: BoxDecoration(
                          // A semi-transparent white background.
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        // Use FractionallySizedBox to adjust the progress bar width
                        // based on the progressAnimation value.
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progressAnimation.value,
                          child: Container(
                            // The progress bar with a gradient fill.
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.secondary,
                                  Colors.white,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
