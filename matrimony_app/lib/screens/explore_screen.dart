import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/user_details_screen.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../services/user_model.dart';
import '../utils/components.dart';

/// A screen that displays a list of user profiles for exploration.
/// Each profile is shown in a card and tapping on a card navigates
/// to the user's detailed information screen.
class ExploreScreen extends StatefulWidget {
  final String adminIdentifier;
  const ExploreScreen({super.key, required this.adminIdentifier});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

/// State class for [ExploreScreen] that builds the user list view.
class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use FutureBuilder to handle asynchronous fetching of users.
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: UserModel.getAllUsers(), // Asynchronous call to SQLite.
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Components.showLoading());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found. 🥲"));
          } else {
            List<Map<String, dynamic>> users = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: users.length,
              itemBuilder: (context, index) {
                // Retrieve the current user data.
                Map<String, dynamic> user = users[index];
                return GestureDetector(
                  // Navigate to the UserDetailsScreen when a card is tapped.
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(
                          adminIdentifier: widget.adminIdentifier,
                          // Find the user's index in the list for identification.
                          id: user[ID],
                        ),
                      ),
                    );
                    // Refresh the state after returning from the details screen.
                    setState(() {});
                  },
                  child: Card(
                    elevation: 7,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.grey,
                    borderOnForeground: true,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // Profile Header Card displaying the user's avatar and name.
                          Card(
                            // Use different shadow colors based on the user's gender.
                            shadowColor: user[GENDER].toLowerCase() == 'male'
                                ? AppColors.secondary
                                : AppColors.primary,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  // Circular avatar showing the first letter of the user's name.
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        user[GENDER].toLowerCase() == 'male'
                                            ? AppColors.secondary
                                            : AppColors.primary,
                                    // Uncomment the following lines to use an icon instead of text.
                                    // child: Icon(
                                    //   user[GENDER].toLowerCase() == 'male'
                                    //       ? Icons.male
                                    //       : Icons.female,
                                    //   size: 50,
                                    //   color: Colors.white,
                                    // ),
                                    child: Text(
                                      // Display the first character of the user's name.
                                      user[NAME][0],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Display the user's full name.
                                  Text(
                                    user[NAME],
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightText,
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
