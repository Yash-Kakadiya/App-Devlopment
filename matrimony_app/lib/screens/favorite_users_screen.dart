import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/add_edit_user_screen.dart';
import 'package:matrimony_app/screens/user_details_screen.dart';
import 'package:matrimony_app/data/models/user_model.dart';

import '../core/app_colors.dart';
import '../utils/string_constants.dart';
import 'dashboard_screen.dart';

class FavoriteUsersScreen extends StatefulWidget {
  const FavoriteUsersScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteUsersScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<FavoriteUsersScreen> {
  // Using explicit typing (assuming users are represented as Map<String, dynamic>)
  List<Map<String, dynamic>> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();

  // State variables for sort and filter options.
  String _selectedSortField = "";
  bool isAscendingSort = true;
  double _minAge = 18;
  double _maxAge = 80;
  String? _selectedGender; // null or empty means no gender filter

  @override
  void initState() {
    super.initState();
    // Assuming getAllUsers() returns a List of Map<String, dynamic>
    filteredUsers = List<Map<String, dynamic>>.from(UserModel.userList);
    print(filteredUsers);
  }

  @override
  void dispose() {
    // Dispose controller to prevent memory leaks.
    searchController.dispose();
    super.dispose();
  }

  /// Applies search, filter, and sort criteria to the full user list.
  void updateUserList() {
    List<Map<String, dynamic>> users =
        List<Map<String, dynamic>>.from(UserModel.userList);
    String searchTxt = searchController.text.toLowerCase();

    // Apply text search filter.
    if (searchTxt.isNotEmpty) {
      users = users.where((user) {
        return (user[NAME]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[EMAIL]?.toString().toLowerCase() ?? '').contains(searchTxt) ||
            (user[PHONE]?.toString().toLowerCase() ?? '').contains(searchTxt) ||
            (user[GENDER]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[AGE]?.toString().toLowerCase() ?? '').contains(searchTxt) ||
            (user[HEIGHT]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[WEIGHT]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[HOBBIES]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[EDUCATION]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[OCCUPATION]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[EMPLOYED_IN]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[INCOME]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[MARITAL_STATUS]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[MOTHER_TONGUE]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[RELIGION]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[COUNTRY]?.toString().toLowerCase() ?? '')
                .contains(searchTxt) ||
            (user[STATE]?.toString().toLowerCase() ?? '').contains(searchTxt) ||
            (user[CITY]?.toString().toLowerCase() ?? '').contains(searchTxt);
      }).toList();
    }

    // Apply age range filter.
    // --- FIX APPLIED HERE ---
    users = users.where((user) {
      String ageStr = user[AGE]?.toString() ?? '';
      int? age = int.tryParse(ageStr);
      // If there's no valid age, include the user.
      if (age == null) return true;
      return age >= _minAge && age <= _maxAge;
    }).toList();

    // Apply gender filter if one is selected (skip if "All" or empty).
    if (_selectedGender != null &&
        _selectedGender!.isNotEmpty &&
        _selectedGender != "All") {
      users = users.where((user) {
        return (user[GENDER]?.toString().toLowerCase() ==
            _selectedGender!.toLowerCase());
      }).toList();
    }

    // Apply sorting if a sort parameter is selected.
    if (_selectedSortField.isNotEmpty) {
      if (_selectedSortField == "Recently Added") {
        // Sort by index in the main list.
        users.sort((a, b) {
          int indexA = UserModel.userList.indexOf(a);
          int indexB = UserModel.userList.indexOf(b);
          return isAscendingSort
              ? indexA.compareTo(indexB)
              : indexB.compareTo(indexA);
        });
      } else {
        users.sort((a, b) {
          var aValue = a[_selectedSortField]?.toString() ?? '';
          var bValue = b[_selectedSortField]?.toString() ?? '';
          // Compare as numbers for numerical fields.
          if (_selectedSortField == AGE ||
              _selectedSortField == HEIGHT ||
              _selectedSortField == WEIGHT) {
            double aNum = double.tryParse(aValue) ?? 0;
            double bNum = double.tryParse(bValue) ?? 0;
            return isAscendingSort
                ? aNum.compareTo(bNum)
                : bNum.compareTo(aNum);
          } else {
            return isAscendingSort
                ? aValue.toLowerCase().compareTo(bValue.toLowerCase())
                : bValue.toLowerCase().compareTo(aValue.toLowerCase());
          }
        });
      }
    }

    setState(() {
      filteredUsers = users;
    });
  }

  // Called on every change in the search field.
  void filterUsers(String searchTxt) {
    updateUserList();
  }

  /// Opens a dialog to choose a sort parameter and order.
  void showSortOptionsDialog() {
    // Temporary variables for the dialog.
    String tempSortField = _selectedSortField;
    bool tempIsAscending = isAscendingSort;

    // List of sort options.
    List<String> sortOptions = [
      NAME,
      EMAIL,
      PHONE,
      GENDER,
      AGE,
      HEIGHT,
      WEIGHT,
      HOBBIES,
      EDUCATION,
      OCCUPATION,
      EMPLOYED_IN,
      INCOME,
      MARITAL_STATUS,
      MOTHER_TONGUE,
      RELIGION,
      COUNTRY,
      STATE,
      CITY,
      "Recently Added"
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: tempSortField.isEmpty ? null : tempSortField,
                    hint: const Text("Select sort parameter"),
                    isExpanded: true,
                    items: sortOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setStateDialog(() {
                        tempSortField = newValue ?? "";
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Ascending"),
                      Switch(
                        activeTrackColor: AppColors.secondary,
                        activeColor: AppColors.primary,
                        inactiveThumbColor: AppColors.secondary,
                        inactiveTrackColor: AppColors.primary,
                        value: tempIsAscending,
                        onChanged: (bool newValue) {
                          setStateDialog(() {
                            tempIsAscending = newValue;
                          });
                        },
                      ),
                      const Text("Descending"),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedSortField = tempSortField;
                  isAscendingSort = tempIsAscending;
                });
                updateUserList();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Apply',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Opens a dialog to filter by age range and gender.
  void showFilterOptionsDialog() {
    // Temporary variables for the dialog.
    RangeValues tempRange = RangeValues(_minAge, _maxAge);
    String tempGender = (_selectedGender == null || _selectedGender!.isEmpty)
        ? "All"
        : _selectedGender!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Age Range"),
                  RangeSlider(
                    activeColor: AppColors.primary,
                    min: 18,
                    max: 80,
                    divisions: 62,
                    labels: RangeLabels(
                      tempRange.start.round().toString(),
                      tempRange.end.round().toString(),
                    ),
                    values: tempRange,
                    onChanged: (RangeValues newRange) {
                      setStateDialog(() {
                        tempRange = newRange;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text("Gender"),
                  DropdownButton<String>(
                    value: tempGender,
                    isExpanded: true,
                    items:
                        <String>["All", "male", "female"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value[0].toUpperCase() + value.substring(1)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setStateDialog(() {
                        tempGender = newValue ?? "All";
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _minAge = tempRange.start;
                  _maxAge = tempRange.end;
                  // Use empty string for no gender filter if "All" is selected.
                  _selectedGender = (tempGender == "All") ? "" : tempGender;
                });
                updateUserList();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Apply',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.lightText),
                hintText: ' Search user... 🙂',
                // Wrap the row in a fixed-width container to avoid layout issues.
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.sort, color: AppColors.lightText),
                        onPressed: showSortOptionsDialog,
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list_alt,
                            color: AppColors.lightText),
                        onPressed: showFilterOptionsDialog,
                      ),
                    ],
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
              onChanged: filterUsers,
            ),
          ),
          getFavoriteUsersListView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        tooltip: 'Add User',
        child: const Icon(Icons.add),
        onPressed: () {
          showAddEditUserConfirmationDialog(
            context: context,
            isAdd: true,
          );
        },
      ),
    );
  }

  /// Builds the list view of users.
  Widget getFavoriteUsersListView() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: filteredUsers.length,
        itemBuilder: (context, idx) {
          Map<String, dynamic> user = filteredUsers[idx];
          if (user[ISFAVORITE]) {
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
              child: getCardView(user: user, idx: idx),
            );
          }
        },
      ),
    );
  }

  /// Builds a card view for a single user.
  Widget getCardView({required Map<String, dynamic> user, required int idx}) {
    return Card(
      shadowColor: AppColors.secondary,
      surfaceTintColor: AppColors.primary,
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
                    data: user[NAME]?.toString(),
                  ),
                  const SizedBox(height: 10),
                  rowOfCard(
                    icon: Icons.location_city,
                    iconColor: Colors.orangeAccent,
                    field: CITY,
                    data: user[CITY]?.toString(),
                  ),
                  const SizedBox(height: 10),
                  rowOfCard(
                    icon: Icons.mail,
                    iconColor: Colors.red,
                    field: EMAIL,
                    data: user[EMAIL]?.toString(),
                  ),
                  const SizedBox(height: 10),
                  rowOfCard(
                    icon: Icons.phone_android,
                    iconColor: Colors.black,
                    field: PHONE,
                    data: user[PHONE]?.toString(),
                  ),
                  const SizedBox(height: 10),
                  rowOfCard(
                    icon: (user[GENDER]?.toString().toLowerCase() == 'male')
                        ? Icons.male
                        : Icons.female,
                    iconColor:
                        (user[GENDER]?.toString().toLowerCase() == 'male')
                            ? Colors.blue
                            : Colors.pink,
                    field: GENDER,
                    data: user[GENDER]?.toString(),
                  ),
                  const SizedBox(height: 10),
                  rowOfCard(
                    icon: Icons.emoji_emotions_rounded,
                    iconColor: Colors.green,
                    field: AGE,
                    data: user[AGE]?.toString(),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      user[ISFAVORITE] = !(user[ISFAVORITE] ?? false);
                    });
                  },
                  icon: Icon(
                    (user[ISFAVORITE] ?? false)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color:
                        (user[ISFAVORITE] ?? false) ? Colors.red : Colors.grey,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showAddEditUserConfirmationDialog(
                        context: context, isAdd: false, userId: idx);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.secondary,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDeleteConfirmationDialog(context: context, userId: idx);
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

  /// Builds a row widget for each field in the user card.
  Widget rowOfCard({
    required IconData icon,
    required Color iconColor,
    required String field,
    required String? data,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
          color: iconColor,
        ),
        const SizedBox(width: 10),
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.lightText,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            data ?? 'null',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.lightText,
            ),
          ),
        ),
      ],
    );
  }

  /// Shows a confirmation dialog to delete a user.
  void showDeleteConfirmationDialog({
    required BuildContext context,
    required int userId,
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
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      // Wait for deletion to complete.
                      bool result = await UserModel.deleteUser(userId);
                      if (result) {
                        // Update the UI after deletion.
                        setState(() {
                          updateUserList();
                        });
                      }
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
  void showAddEditUserConfirmationDialog({
    required BuildContext context,
    required bool isAdd,
    int? userId,
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
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: const Text(
                      'No 🥲',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
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
                      Navigator.of(context).pop(); // Close dialog first
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditUserScreen(
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
