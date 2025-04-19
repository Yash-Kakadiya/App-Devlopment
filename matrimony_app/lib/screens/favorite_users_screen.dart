import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/add_edit_user_screen.dart';
import 'package:matrimony_app/screens/user_details_screen.dart';
import 'package:matrimony_app/utils/components.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../services/user_model.dart';

/// A screen that displays a list of user profiles with options for searching,
/// filtering, sorting, and performing actions such as editing or deleting a user.
/// Data is fetched asynchronously from an SQLite data using FutureBuilder.
class FavoriteUsersScreen extends StatefulWidget {
  /// The admin identifier is used to ensure that the correct admin-specific DB is accessed.
  final String adminIdentifier;
  const FavoriteUsersScreen({
    super.key,
    required this.adminIdentifier,
  });

  @override
  State<FavoriteUsersScreen> createState() => _FavoriteUsersScreenState();
}

class _FavoriteUsersScreenState extends State<FavoriteUsersScreen> {
  // Controller for the search text field.
  final TextEditingController searchController = TextEditingController();

  // State variables for sort and filter options.
  String _selectedSortField = "";
  bool isAscendingSort = true;
  double _minAge = 18;
  double _maxAge = 80;
  String? _selectedGender; // null or empty means no gender filter

  // Future variable that returns the filtered user list.
  Future<List<Map<String, dynamic>>>? _userFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future with the filtered user list.
    _userFuture = fetchAndFilterUsers();
  }

  /// Fetches all users from the API, applies search, filter, and sort criteria,
  /// and returns the resulting list.
  Future<List<Map<String, dynamic>>> fetchAndFilterUsers() async {
    List<Map<String, dynamic>> users = await UserModel.getAllUsers();
    String searchTxt = searchController.text.toLowerCase();

    // Apply text search filter on multiple fields.
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
    users = users.where((user) {
      String ageStr = user[AGE]?.toString() ?? '';
      int? age = int.tryParse(ageStr);
      if (age == null) return true;
      return age >= _minAge && age <= _maxAge;
    }).toList();

    // Apply gender filter if a specific gender is selected.
    if (_selectedGender != null &&
        _selectedGender!.isNotEmpty &&
        _selectedGender != "All") {
      users = users.where((user) {
        return (user[GENDER]?.toString().toLowerCase() ==
            _selectedGender!.toLowerCase());
      }).toList();
    }

    // Apply sorting based on the selected sort field.
    if (_selectedSortField.isNotEmpty) {
      if (_selectedSortField == "Recently Added") {
        // Sort by the 'id' field (assumes higher id = more recent).
        users.sort((a, b) {
          int indexA = a[ID];
          int indexB = b[ID];
          return isAscendingSort
              ? indexA.compareTo(indexB)
              : indexB.compareTo(indexA);
        });
      } else {
        // Sort by the selected field.
        users.sort((a, b) {
          var aValue = a[_selectedSortField]?.toString() ?? '';
          var bValue = b[_selectedSortField]?.toString() ?? '';
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
    return users;
  }

  /// Updates the future so that the UI refreshes with the new filtered list.
  Future<void> updateUserList() async {
    setState(() {
      _userFuture = fetchAndFilterUsers();
    });
  }

  /// Called on every change in the search field.
  void filterUsers(String searchTxt) {
    updateUserList();
  }

  /// Opens a dialog for choosing sort options.
  void showSortOptionsDialog() {
    String tempSortField = _selectedSortField;
    bool tempIsAscending = isAscendingSort;
    List<String> sortOptions = [
      "Recently Added",
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

  /// Opens a dialog for filtering users by age range and gender.
  void showFilterOptionsDialog() {
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
  void dispose() {
    // Dispose the search controller to avoid memory leaks.
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The main scaffold containing a search bar, list view (via FutureBuilder), and a floating button.
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Search bar.
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onTapOutside: (PointerDownEvent event) {
                debugPrint('Tapped outside: ${event.position}');
                FocusScope.of(context).unfocus();
              },
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.lightText),
                hintText: ' Search user... 🙂',
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
          // Display the user list using FutureBuilder.
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Components.showLoading());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("Error: ${snapshot.error.toString()}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No users found. 🥲"));
                } else {
                  List<Map<String, dynamic>> users = snapshot.data!
                      .where((user) => (user[ISFAVORITE] == 1))
                      .toList();
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: users.length,
                    itemBuilder: (context, idx) {
                      Map<String, dynamic> user = users[idx];
                      return GestureDetector(
                        // On tapping a user card, navigate to UserDetailsScreen.
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsScreen(
                                adminIdentifier: widget.adminIdentifier,
                                id: user[ID], // Use the database ID.
                              ),
                            ),
                          );
                          updateUserList();
                        },
                        child: getCardView(user: user, idx: idx),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      // Floating button to add a new user.
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        tooltip: 'Add User',
        child: const Icon(Icons.add),
        onPressed: () {
          showAddEditUserConfirmationDialog(context: context, isAdd: true);
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
            // Left side: user details.
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
            // Right side: action buttons.
            Column(
              children: [
                // Favorite toggle button.
                IconButton(
                  onPressed: () async {
                    // Create a mutable copy of the user map because the returned map is read-only.
                    Map<String, dynamic> mutableUser =
                        Map<String, dynamic>.from(user);
                    // Toggle the favorite value.
                    mutableUser[ISFAVORITE] =
                        (mutableUser[ISFAVORITE] == 1) ? 0 : 1;

                    // Update the database asynchronously.
                    await UserModel.updateUser(mutableUser[ID], mutableUser);
                    // Refresh the user list.
                    updateUserList();
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
                // Edit button.
                IconButton(
                  onPressed: () {
                    showAddEditUserConfirmationDialog(
                        context: context, isAdd: false, userId: user[ID]);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.secondary,
                    size: 30,
                  ),
                ),
                // Delete button.
                IconButton(
                  onPressed: () {
                    showDeleteConfirmationDialog(
                        context: context, userId: user[ID]);
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

  /// Builds a row widget to display a field icon, label, and its value.
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
          style: const TextStyle(fontSize: 16, color: AppColors.lightText),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            data ?? 'null',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, color: AppColors.lightText),
          ),
        ),
      ],
    );
  }

  /// Displays a confirmation dialog to delete a user.
  void showDeleteConfirmationDialog({
    required BuildContext context,
    required String userId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
                      bool result = await UserModel.deleteUser(userId);
                      if (result) {
                        updateUserList();
                        Components.getDeleteUserToast(context: context);
                      }
                      Navigator.of(dialogContext).pop();
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

  /// Displays a confirmation dialog for adding or editing a user.
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      child: const Text(
                        'No 😀',
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
                // "Yes" button.
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
                      onPressed: () async {
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
