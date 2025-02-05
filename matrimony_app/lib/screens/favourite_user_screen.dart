import 'package:flutter/material.dart';
import './user_detail_screen.dart';
import '../utils/components.dart';
import '../utils/app_colors.dart';
import '../utils/string_const.dart';
import '../utils/user_model.dart';
import 'add_edit_user_screen.dart';

class FavouriteUserScreen extends StatefulWidget {
  const FavouriteUserScreen({super.key});

  @override
  State<FavouriteUserScreen> createState() => _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavouriteUserScreen> {
  List<dynamic> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = UserModel.userList;
  }

  void filterUsers(String searchTxt) {
    searchTxt = searchTxt.toLowerCase();
    setState(() {
      filteredUsers = UserModel.userList
          .where((user) =>
              user[NAME].toLowerCase().contains(searchTxt) ||
              user[CITY].toLowerCase().contains(searchTxt) ||
              user[EMAIL].toLowerCase().contains(searchTxt) ||
              user[MOBILE].contains(searchTxt) ||
              user[AGE].contains(searchTxt))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.getAppBar(
        icon: Icons.favorite,
        title: 'Favorite',
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: AppColors.textDark),
                hintText: ' Search user... 🙂',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.redAccent),
                ),
              ),
              onChanged: filterUsers,
            ),
          ),
          getFavoriteListView(),
        ],
      ),
    );
  }

  Widget getFavoriteListView() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: filteredUsers.length,
        itemBuilder: (context, idx) {
          var user = filteredUsers[idx];
          if (user[ISFAVORITE]) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(
                      id: idx,
                    ),
                  ),
                );
                setState(() {});
              },
              child: getCardView(user: user, idx: idx),
            );
          }
          return const SizedBox(
            height: 0,
          );
        },
      ),
    );
  }

  Widget getCardView({required user, required idx}) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
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
                    iconColor:
                        user[GENDER] == 'male' ? Colors.blue : Colors.pink,
                    field: GENDER,
                    data: user[GENDER],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  rowOfCard(
                    icon: Icons.emoji_emotions_rounded,
                    iconColor: Colors.green,
                    field: AGE,
                    data: user[AGE],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      user[ISFAVORITE] = !user[ISFAVORITE];
                    });
                  },
                  icon: Icon(
                    user[ISFAVORITE] ? Icons.favorite : Icons.favorite_border,
                    color: user[ISFAVORITE] ? Colors.red : Colors.grey,
                    size: 30,
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditUserScreen(id: idx),
                      ),
                    );
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.secondary,
                    size: 30,
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                IconButton(
                  onPressed: () {
                    showDeleteConfirmationDialog(context, idx);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            )
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
          size: 30,
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

  void showDeleteConfirmationDialog(BuildContext context, int idx) {
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
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  UserModel.userList.removeAt(idx); // Delete user
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
