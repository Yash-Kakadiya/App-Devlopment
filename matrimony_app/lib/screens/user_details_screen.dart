import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../services/user_model.dart';
import '../utils/components.dart';
import 'add_edit_user_screen.dart';

/// A screen that displays the details of a specific user.
/// The user is identified by an index passed via the [id] parameter.
class UserDetailsScreen extends StatefulWidget {
  final String adminIdentifier;

  /// The index of the user in the in-memory list.
  final String id;

  /// Creates a [UserDetailsScreen] widget with the given [id].
  const UserDetailsScreen({
    super.key,
    required this.adminIdentifier,
    required this.id,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

/// State class for [UserDetailsScreen] that builds the UI to display
/// detailed information about the user and provides options to edit, delete,
/// or toggle the user's favorite status.
class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print("detail id: ${widget.id}");
    return FutureBuilder<Map<String, dynamic>?>(
      future: UserModel.getUser(
          widget.id), // Asynchronous call to fetch user from SQLite.,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Components.showLoading(overlayBackgroundColor: Colors.white);
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text("User not found 🥲")),
          );
        }
        // Once data is ready:
        final user = snapshot.data!;
        String userGender = user[GENDER].toLowerCase();
        return Scaffold(
          // AppBar with a custom title displaying the user's name and a favorite icon.
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60), // Custom height
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft:
                    Radius.circular(25), // Rounded corners at the bottom
                bottomRight: Radius.circular(25),
              ),
              child: AppBar(
                titleSpacing: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side: Icon and user's name.
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
                    // Right side: Favorite icon button to toggle favorite status.
                    IconButton(
                      onPressed: () async {
                        // Create a mutable copy of the user map because the returned map is read-only.
                        Map<String, dynamic> mutableUser =
                            Map<String, dynamic>.from(user);
                        // Toggle the favorite value: if currently 1 (true), set to 0; otherwise, set to 1.
                        mutableUser[ISFAVORITE] =
                            (mutableUser[ISFAVORITE] == 1) ? 0 : 1;

                        // Update the database asynchronously with the new favorite value.
                        await UserModel.updateUser(
                            mutableUser[ID], mutableUser);
                        // print( await UserModel.getUser(mutableUser[ID]));
                        // Update the local list with the mutable copy.
                        setState(() {});
                      },
                      icon: Icon(
                        (user[ISFAVORITE] == 1)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: (user[ISFAVORITE] == 1)
                            ? AppColors.secondary
                            : Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.pink[400],
              ),
            ),
          ),
          // Body content is scrollable.
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Profile Header Card: Displays a circular avatar (first letter of the user's name) and the user's name.
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
                        // Circular avatar: Uses the first character of the user's name.
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: user[GENDER].toLowerCase() == 'male'
                              ? AppColors.secondary
                              : AppColors.primary,
                          // Optionally, you can display an icon here instead of text.
                          child: Text(
                            user[NAME][0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // User's name displayed in a large, bold font.
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

                // Personal Details Section Card
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

                // Physical Details Section Card
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

                // Location Details Section Card
                buildSectionCard(
                  title: "Location Details",
                  userGender: userGender,
                  children: [
                    rowOfCard(
                      icon: Icons.flag,
                      iconColor: Colors.blue,
                      field: COUNTRY,
                      data: user[COUNTRY],
                    ),
                    rowOfCard(
                      icon: Icons.map,
                      iconColor: Colors.brown,
                      field: STATE,
                      data: user[STATE],
                    ),
                    rowOfCard(
                      icon: Icons.location_on,
                      iconColor: Colors.deepOrange,
                      field: CITY,
                      data: user[CITY],
                    ),
                  ],
                ),

                // Educational & Career Details Section Card
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

                // Social Details Section Card
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
                    // Row for displaying a list of hobbies (Interests) using chips.
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
                            style: TextStyle(
                                fontSize: 16, color: AppColors.lightText),
                          ),
                          const SizedBox(width: 1),
                          Expanded(
                              child: getHobbies(userHobbies: user[HOBBIES])),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // Row with Edit and Delete buttons.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Edit button: Navigates to the Add/Edit User screen for editing.
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () async {
                        showAddEditUserConfirmationDialog(
                          context: context,
                          isAdd: false,
                          userId: user[ID],
                        );
                        setState(() {});
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    // Delete button: Opens a confirmation dialog to delete the user.
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
      },
    );
  }

  /// Builds a section card with a header title and a list of row widgets.
  ///
  /// [title] is the header text for the section.
  /// [userGender] determines styling based on the user's gender.
  /// [children] are the row widgets representing details in that section.
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
            // Section header text.
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Divider(color: Colors.grey),
            // Insert all child widgets.
            ...children,
          ],
        ),
      ),
    );
  }

  /// Builds a reusable row widget displaying an icon, a field name, and its data.
  ///
  /// [icon] is displayed on the left, [field] is the label, and [data] is the user's data.
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

  /// Displays a list of hobbies as chips.
  ///
  /// [hobbies] is a list of strings representing the user's interests.
  Widget getHobbies({required String userHobbies}) {
    List<String> hobbies = userHobbies.split(',');
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

  /// Shows a confirmation dialog to delete a user.
  ///
  /// If confirmed, the user is deleted from the data model and the detail screen is closed.
  /// Displays a confirmation dialog to delete a user.
  void showDeleteConfirmationDialog({
    required BuildContext context,
    required String userId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User!'),
          content: const Text('Are you sure you want to delete user?'),
          actions: [
            Row(
              children: [
                // "No" button.
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
                      Navigator.of(context).pop();
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
                // "Yes" button.
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      // Delete the user and update the list.
                      bool result = await UserModel.deleteUser(userId);
                      if (result) {
                        setState(() {
                          Components.getDeleteUserToast(context: context);
                        });
                      }
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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

  /// Shows a confirmation dialog for adding or editing a user.
  ///
  /// If confirmed, navigates to the [AddEditUserScreen] for the corresponding action.
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
                // "No" button.
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
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
                // "Yes" button.
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
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditUserScreen(
                            adminIdentifier: widget.adminIdentifier,
                            id: userId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Yes 😀',
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
}
