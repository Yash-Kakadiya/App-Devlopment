import 'package:flutter/material.dart';
import 'package:matrimony_app/utils/components.dart';

import '../utils/app_colors.dart';
import '../utils/string_const.dart';
import '../utils/user_model.dart';
import 'add_edit_user_screen.dart';

class UserDetailScreen extends StatefulWidget {
  int id;
  UserDetailScreen({super.key, required this.id});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = UserModel.getUser(id: widget.id);
    return Scaffold(
      appBar: Components.getAppBar(
        icon: Icons.person,
        title: 'User Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(7),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: user[GENDER] == 'male'
                            ? AppColors.secondary
                            : AppColors.primary,
                        child: Icon(
                          user[GENDER] == 'male' ? Icons.male : Icons.female,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user[NAME],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      rowOfCard(
                        icon: Icons.person,
                        iconColor: Colors.blue,
                        field: NAME,
                        data: user[NAME],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rowOfCard(
                        icon: Icons.location_city,
                        iconColor: Colors.orangeAccent,
                        field: CITY,
                        data: user[CITY],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rowOfCard(
                        icon: Icons.mail,
                        iconColor: Colors.red,
                        field: EMAIL,
                        data: user[EMAIL],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rowOfCard(
                        icon: Icons.phone_android,
                        iconColor: Colors.black,
                        field: MOBILE,
                        data: user[MOBILE],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rowOfCard(
                        icon:
                            user[GENDER] == 'male' ? Icons.male : Icons.female,
                        iconColor: Colors.red,
                        field: GENDER,
                        data: user[GENDER],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rowOfCard(
                        icon: Icons.calendar_month_outlined,
                        iconColor: Colors.green,
                        field: DOB,
                        data: user[DOB],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rowOfCard(
                        icon: Icons.emoji_emotions_rounded,
                        iconColor: Colors.blue,
                        field: AGE,
                        data: user[AGE],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.emoji_objects_outlined,
                            size: 25,
                            color: Colors.brown,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Hobbies: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textDark, // Dark text color
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          getHobbies(hobbies: user[HOBBIES]),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditUserScreen(id: widget.id),
                        ),
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
                      showDeleteConfirmationDialog(context, widget.id);
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
      ),
    );
  }

  Widget rowOfCard(
      {required IconData icon,
      required Color iconColor,
      required field,
      required data}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
          color: iconColor,
        ),
        const SizedBox(width: 10),
        Text(
          field + ': ',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textDark, // Dark text color
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            data ?? 'null',
            maxLines: 2,
            // softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark, // Dark text color
            ),
          ),
        ),
      ],
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(() {
                  UserModel.userList.removeAt(index);
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getHobbies({required List<dynamic> hobbies}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        checkHobby(hobbies[0]),
        checkHobby(hobbies[1]),
        checkHobby(hobbies[2]),
        checkHobby(hobbies[3]),
        checkHobby(hobbies[4]),
        checkHobby(hobbies[5]),
        checkHobby(hobbies[6]),
      ],
    );
  }

  Widget checkHobby(dynamic hobby) {
    if (hobby[1]) {
      return Text(
        hobby[0],
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.textDark, // Dark text color
        ),
      );
    }
    return const SizedBox(
      height: 0,
    );
  }
}
