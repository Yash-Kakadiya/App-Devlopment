import 'package:flutter/material.dart';
import 'package:matrimony_app/utils/components.dart';
import '../core/app_colors.dart';
import '../utils/string_constants.dart';
import '../data/models/user_model.dart';
import 'add_edit_user_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  final int id;
  const UserDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = UserModel.getUser(widget.id)!;
    String userGender = user[GENDER].toLowerCase();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                  size: 22,
                  color: AppColors.lightText,
                ),
                const SizedBox(width: 10),
                Text(
                  user[NAME],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightText,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  user[ISFAVORITE] = !user[ISFAVORITE];
                });
              },
              icon: Icon(
                Icons.favorite,
                color: user[ISFAVORITE] ? AppColors.secondary : Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.pink[400],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Profile Header Card with avatar and name
            Card(
              shadowColor: userGender == 'male'
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
                      backgroundColor: user[GENDER].toLowerCase() == 'male'
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

            // Personal Details Card
            buildSectionCard(
              title: "Personal Details",
              userGender: userGender,
              children: [
                rowOfCard(
                  icon: Icons.person,
                  iconColor: Colors.blue,
                  field: NAME,
                  data: user[NAME],
                ),
                rowOfCard(
                  icon: Icons.mail,
                  iconColor: Colors.red,
                  field: EMAIL,
                  data: user[EMAIL],
                ),
                rowOfCard(
                  icon: Icons.phone_android,
                  iconColor: Colors.black,
                  field: PHONE,
                  data: user[PHONE],
                ),
                rowOfCard(
                  icon: user[GENDER].toLowerCase() == 'male'
                      ? Icons.male
                      : Icons.female,
                  iconColor: Colors.red,
                  field: GENDER,
                  data: user[GENDER],
                ),
                rowOfCard(
                  icon: Icons.calendar_month_outlined,
                  iconColor: Colors.green,
                  field: BIRTHDATE,
                  data: user[BIRTHDATE],
                ),
              ],
            ),

            // Physical Details Card
            buildSectionCard(
              title: "Physical Details",
              userGender: userGender,
              children: [
                rowOfCard(
                  icon: Icons.emoji_emotions_rounded,
                  iconColor: Colors.blue,
                  field: AGE,
                  data: user[AGE],
                ),
                rowOfCard(
                  icon: Icons.straighten,
                  iconColor: Colors.purple,
                  field: HEIGHT,
                  data: user[HEIGHT],
                ),
                rowOfCard(
                  icon: Icons.emoji_food_beverage,
                  iconColor: Colors.green,
                  field: WEIGHT,
                  data: user[WEIGHT],
                ),
              ],
            ),

            // Location Details Card
            buildSectionCard(
              title: "Location Details",
              userGender: userGender,
              children: [
                rowOfCard(
                  icon: Icons.map,
                  iconColor: Colors.brown,
                  field: STATE,
                  data: user[STATE],
                ),
                rowOfCard(
                  icon: Icons.flag,
                  iconColor: Colors.blue,
                  field: COUNTRY,
                  data: user[COUNTRY],
                ),
                rowOfCard(
                  icon: Icons.location_on,
                  iconColor: Colors.deepOrange,
                  field: CITY,
                  data: user[CITY],
                ),
              ],
            ),

            // Educational Details Card
            buildSectionCard(
              title: "Educational & Career Details",
              userGender: userGender,
              children: [
                rowOfCard(
                  icon: Icons.school,
                  iconColor: Colors.purple,
                  field: EDUCATION,
                  data: user[EDUCATION],
                ),
                rowOfCard(
                  icon: Icons.work,
                  iconColor: Colors.indigo,
                  field: OCCUPATION,
                  data: user[OCCUPATION],
                ),
                rowOfCard(
                  icon: Icons.business_center,
                  iconColor: Colors.orange,
                  field: EMPLOYED_IN,
                  data: user[EMPLOYED_IN],
                ),
                rowOfCard(
                  icon: Icons.monetization_on,
                  iconColor: Colors.green,
                  field: INCOME,
                  data: user[INCOME],
                ),
              ],
            ),

            // Social Details Card
            buildSectionCard(
              title: "Social Details",
              userGender: userGender,
              children: [
                rowOfCard(
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                  field: MARITAL_STATUS,
                  data: user[MARITAL_STATUS],
                ),
                rowOfCard(
                  icon: Icons.language,
                  iconColor: Colors.blueAccent,
                  field: MOTHER_TONGUE,
                  data: user[MOTHER_TONGUE],
                ),
                rowOfCard(
                  icon: Icons.auto_awesome,
                  iconColor: Colors.amber,
                  field: RELIGION,
                  data: user[RELIGION],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.emoji_objects_outlined,
                        size: 25,
                        color: Colors.brown,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Interests: ',
                        style:
                            TextStyle(fontSize: 16, color: AppColors.lightText),
                      ),
                      const SizedBox(width: 1),
                      Expanded(child: getHobbies(hobbies: user[HOBBIES])),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            // Edit & Delete Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  onPressed: () async {
                    showAddEditUserConfirmationDialog(
                      context: context,
                      isAdd: false,
                      userId: widget.id,
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  onPressed: () {
                    showDeleteConfirmationDialog(
                        context: context, userId: widget.id);
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a card for a particular section with a header title and list of rows.
  Widget buildSectionCard({
    required String title,
    required String userGender,
    required List<Widget> children,
  }) {
    return Card(
      shadowColor:
          userGender == 'male' ? AppColors.secondary : AppColors.primary,
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header title
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Divider(color: Colors.grey),
            ...children,
          ],
        ),
      ),
    );
  }

  /// Reusable row widget for showing an icon, field name, and its data.
  Widget rowOfCard({
    required IconData icon,
    required Color iconColor,
    required String field,
    required dynamic data,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Text(
            '$field: ',
            style: const TextStyle(fontSize: 16, color: AppColors.lightText),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              data ?? 'null',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: AppColors.lightText),
            ),
          ),
        ],
      ),
    );
  }

  /// Displays the list of hobbies as chips.
  Widget getHobbies({required List<String> hobbies}) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 4.0,
      children: hobbies.map((hobby) {
        return Chip(
          label: Text(
            hobby,
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        );
      }).toList(),
    );
  }

  void showDeleteConfirmationDialog({
    required BuildContext context,
    required int userId,
  }) {
    // Capture the parent context (the detail screen context)
    final parentContext = context;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete User!'),
          content: const Text('Are you sure you want to delete user?'),
          actions: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext); // Close the dialog
                    },
                    child: const Text(
                      'No 😀',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      bool result = await UserModel.deleteUser(userId);
                      if (result) {
                        Navigator.pop(dialogContext); // Close the dialog
                        Navigator.pop(parentContext); // Pop the detail screen
                      }
                    },
                    child: const Text(
                      'Yes 🥲',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  void showAddEditUserConfirmationDialog({
    required BuildContext context,
    required bool isAdd,
    userId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${isAdd ? 'Add' : 'Edit'} User'),
          content:
              Text('Are you sure you want to ${isAdd ? 'add' : 'edit'} user?'),
          actions: [
            Row(
              children: [
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditUserScreen(
                              id: userId,
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
