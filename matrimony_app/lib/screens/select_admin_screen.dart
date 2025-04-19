import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/screens/add_edit_admin_screen.dart';
import 'package:matrimony_app/screens/welcome_back_screen.dart';
import 'package:matrimony_app/utils/components.dart';
import '../data/admin/admin.dart';
import '../data/admin/admin_prefs.dart';


/// A screen that displays a grid of admin profiles for selection.
/// Tapping an admin card (outside the icons) navigates to WelcomeBackScreen.
/// Each admin card includes edit and delete icons in the top‑right corner.
class SelectAdminScreen extends StatefulWidget {
  const SelectAdminScreen({super.key});

  @override
  State<SelectAdminScreen> createState() => _SelectAdminScreenState();
}

class _SelectAdminScreenState extends State<SelectAdminScreen> {
  // List to hold the saved admin profiles.
  List<Admin> adminList = [];

  @override
  void initState() {
    super.initState();
    loadAdmins();
  }

  /// Loads the admin list from SharedPreferences.
  Future<void> loadAdmins() async {
    List<Admin> admins = await AdminPrefs.getAdmins();
    setState(() {
      adminList = admins;
    });
  }

  /// Refreshes the admin list after any change.
  Future<void> refreshAdmins() async {
    await loadAdmins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white,
              AppColors.primary,
              AppColors.secondary,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Title text.
                const Center(
                  child: Text(
                    'Select Admin 😀',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // GridView displaying admin cards plus an "Add Admin" card.
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row.
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemCount:
                        adminList.length + 1, // Extra cell for "Add Admin"
                    itemBuilder: (context, index) {
                      if (index < adminList.length) {
                        Admin admin = adminList[index];
                        // Inside your GridView.builder, in the admin card branch:
                        return GestureDetector(
                          onTap: () {
                            // Tapping the card (outside the icons) navigates to WelcomeBackScreen.
                            Navigator.push(
                                context,
                                Components.createRoute(
                                  WelcomeBackScreen(
                                    adminIdentifier: admin.username,
                                  ),
                                ));
                          },
                          child: Card(
                            key: ValueKey(admin.username),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Stack(
                              children: [
                                // Main content: Centered admin avatar and username.
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: AppColors.secondary,
                                        backgroundImage: const AssetImage(
                                            'assets/icons/app_icon12.png'),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        admin.username,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Edit icon at top-left.
                                Positioned(
                                  top: 1,
                                  left: 1,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      // Navigate to AddEditAdminScreen in edit mode.
                                      await Navigator.push(
                                        context,
                                        Components.createRoute(
                                          AddEditAdminScreen(
                                            adminToEdit: admin,
                                          ),
                                        ),
                                      );
                                      await refreshAdmins();
                                    },
                                  ),
                                ),
                                // Delete icon at top-right.
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDeleteConfirmationDialog(
                                        context: context,
                                        admin: admin,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // "Add Admin" card.
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              Components.createRoute(
                                const AddEditAdminScreen(),
                              ),
                            );
                            await refreshAdmins();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 50,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Add Admin",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Displays a confirmation dialog to delete a admin.
  void showDeleteConfirmationDialog({
    required BuildContext context,
    required admin,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Admin!'),
          content: const Text('Are you sure you want to delete admin?'),
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
                      Navigator.of(dialogContext).pop();
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
                      // Delete the admin and refresh the list.
                      List<Admin> admins = await AdminPrefs.getAdmins();
                      admins.removeWhere((a) => a.username == admin.username);
                      await AdminPrefs.saveAdmins(admins);
                      await refreshAdmins();
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
}
