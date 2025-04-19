import 'package:flutter/material.dart';
import '../core/app_colors.dart';

/// A screen that provides information about the app, the development team,
/// and related details such as contact information and social links.
class AboutUsScreen extends StatefulWidget {
  final String adminIdentifier;

  /// Creates an [AboutUsScreen] widget.
  const AboutUsScreen({
    super.key,
    required this.adminIdentifier,
  });

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

/// State class for [AboutUsScreen] which builds the UI containing
/// team information, ASWDC details, and contact information.
class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // // Provides a navigation drawer using a custom component.
      // drawer: Components.getDrawer(
      //     context: context, adminIdentifier: widget.adminIdentifier),
      // Allows scrolling when content overflows the viewport.
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Spacer at the top.
            const SizedBox(
              height: 20,
            ),
            // Centered circular image (likely a profile or logo image).
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Make the container circular.
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/ma_about_us.gif',
                    ),
                    fit: BoxFit.cover, // Ensure the image covers the circle.
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Centered title displaying a name.
            const Center(
                child: Text(
              "Yash Kakadiya",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            // Row with a container displaying the "Meet Our Team" label.
            Row(
              children: [
                const SizedBox(width: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pinkAccent,
                        AppColors.secondary,
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Meet Our Team",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.lightText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Card containing details about team roles.
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(
                  color: AppColors.secondary,
                  width: 2,
                ),
              ),
              elevation: 7,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: const Column(
                  children: [
                    // Row for "Developed By" information.
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Developed By:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Yash Kakadiya",
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row for "Mentored By" information.
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Mentored By:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Prof. Yash Kakadiya(Computer Engineering Department), School of Computer Science",
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row for "Explored By" information.
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Explored By:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "My Friends",
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row for "Eulogized By" information.
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Eulogized By:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Darshan University , Rajkot , Gujarat - INDIA",
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Section header for "Contact Us".
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pinkAccent,
                        AppColors.secondary,
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.lightText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Card displaying contact details.
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: AppColors.secondary,
                  width: 2,
                ),
              ),
              child: const Column(
                children: [
                  // Row for email contact.
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "yashkakadiya931@gmail.com",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row for phone contact.
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.telegram,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "@yash_01_12",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Card displaying additional social and app-related actions.
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: AppColors.secondary,
                  width: 2,
                ),
              ),
              child: const Column(
                children: [
                  // Row for sharing the app.
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Share App",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row for exploring more apps.
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.apps,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "More Apps",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row for rating the app.
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Rate Us",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row for liking the app on Facebook.
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Like Us on Facebook",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row for checking for updates.
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.update,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Check for Update",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Footer text with copyright and policy information.
            const Text(
              "© 2025 Yash Kakadiya",
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            const Text("All Right Reserved - Privacy Policy",
                style: TextStyle(fontFamily: 'Roboto')),
            const Text("Made With 💝 in INDIA",
                style: TextStyle(fontFamily: 'Roboto')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
