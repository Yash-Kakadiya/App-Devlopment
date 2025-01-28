import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/user_detail_screen.dart';
import 'package:matrimony_app/utils/components.dart';
import 'package:matrimony_app/utils/user_model.dart';

import '../utils/app_colors.dart';
import '../utils/string_const.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.getAppBar(
        icon: Icons.list_alt,
        title: 'User List',
      ),
      body: getUserListView(),
    );
  }

  Widget getUserListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: UserModel.userList.length,
      itemBuilder: (context, index) {
        var user = UserModel.userList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(
                  id: index,
                ),
              ),
            );
          },
          child: getCardView(user: user),
        );
      },
    );
  }

  Widget getCardView({required user}) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              icon: user[GENDER] == 'male' ? Icons.male : Icons.female,
              iconColor: Colors.red,
              field: GENDER,
              data: user[GENDER],
            ),
            const SizedBox(
              height: 10,
            ),
            rowOfCard(
              icon: Icons.emoji_emotions_rounded,
              iconColor: Colors.yellow,
              field: AGE,
              data: user[AGE],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
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
          size: 20,
          color: iconColor,
        ),
        const SizedBox(width: 10),
        Text(
          field+': ',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textDark, // Dark text color
          ),
        ),
        const SizedBox(width: 10),
        Text(
          data,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textDark, // Dark text color
          ),
        ),
      ],
    );
  }
}
