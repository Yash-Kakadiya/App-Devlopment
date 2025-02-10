import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/user_details_screen.dart';
import '../core/app_colors.dart';
import '../utils/string_constants.dart';
import '../data/models/user_model.dart';
import 'add_edit_user_screen.dart';

class ExploreProfilesScreen extends StatefulWidget {
  @override
  State<ExploreProfilesScreen> createState() => _ExploreProfilesScreenState();
}

class _ExploreProfilesScreenState extends State<ExploreProfilesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> users = UserModel.getAllUsers();

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: users.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> user = users[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(
                    id: UserModel.userList.indexOf(user),
                  ),
                ),
              );
              setState(() {});
            },
            child: Card(
              elevation: 7,
              shadowColor: Colors.black,
              surfaceTintColor: Colors.grey,
              borderOnForeground: true,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Profile Header Card with avatar and name
                    Card(
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
                            CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  user[GENDER].toLowerCase() == 'male'
                                      ? AppColors.secondary
                                      : AppColors.primary,
                              // child: Icon(
                              //   user[GENDER].toLowerCase() == 'male'
                              //       ? Icons.male
                              //       : Icons.female,
                              //   size: 50,
                              //   color: Colors.white,
                              // ),
                              child: Text(
                                user[NAME][0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
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
      ),
    );
  }
}
