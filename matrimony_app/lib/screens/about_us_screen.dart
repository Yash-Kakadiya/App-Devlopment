import 'package:flutter/material.dart';
import 'package:matrimony_app/utils/components.dart';

import '../core/app_colors.dart';
import 'dashboard_screen.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Components.getDrawer(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Make the container circular
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/ma_about_us.gif',
                    ),
                    fit:
                        BoxFit.cover, // Ensure the image fits within the circle
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                              "Yash Kakadiya(23010101121)",
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                              "Prof. Mehul Bhundiya(Computer Engineering Department), School of Computer Science",
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                              "ASWDC , School of Computer Science",
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
            Row(
              children: [
                const SizedBox(width: 20),
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
                    "About ASWDC",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.lightText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: AppColors.secondary,
                  width: 2,
                ),
              ),
              elevation: 7,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Image.asset(
                          'assets/images/du_logo.png',
                          height: 180,
                          width: 180,
                        )),
                        Expanded(
                            child: Image.asset(
                          'assets/images/aswdc.png',
                          height: 180,
                          width: 180,
                        ))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "ASWDC is Application,Software and Website Development Center @ Darshan University run by Students and Staff of School of Computer Science.",
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Sole Purpose of ASWDC is to bridge gap between university curriculum & industry demands. Students learn cutting edge technologies, develop real world application & experience professional environment @ ASWDC under guidance of industry experts & faculty members.",
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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
                              "aswdc@darshan.ac.in",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
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
                              "+91-9727747317",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.blur_circular_outlined,
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
                              "www.darshan.ac.in",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            const Text(
              "© 2025 Darshan University",
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            const Text("All Right Reserverd - Privacy Policy",
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
