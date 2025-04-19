import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/core/app_constants.dart';

/// A stateful widget that displays the hobbies onboarding page.
/// This page allows the user to select their interests (hobbies) from a list,
/// as well as search and add new hobbies. The user must select at least 5 hobbies.
class HobbiesOnboardingPage extends StatefulWidget {
  /// A list of selected hobbies. This acts as a controller to track the chosen hobbies.
  final List<String> hobbiesController;

  /// Global key for the form on this page.
  final GlobalKey<FormState> formKey;

  /// Creates a [HobbiesOnboardingPage] widget.
  const HobbiesOnboardingPage({
    super.key,
    required this.hobbiesController,
    required this.formKey,
  });

  @override
  State<HobbiesOnboardingPage> createState() => _HobbiesOnboardingPageState();
}

/// State class for [HobbiesOnboardingPage] that builds the UI and handles user interactions.
class _HobbiesOnboardingPageState extends State<HobbiesOnboardingPage> {
  /// A list of default hobbies to choose from.
  List<String> hobbies = hobbiesList;

  /// Controller for the search field to filter or add new hobbies.
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text prompting the user to choose a minimum of 5 interests.
          const Text(
            "Choose minimum 5 interests",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle text providing additional instruction.
          const Text(
            "that describes you. 😈",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 10),
          // Search TextField allows the user to search for a hobby or add a new one.
          TextField(
            // When tapped outside the TextField, it will lose focus.
            onTapOutside: (PointerDownEvent event) {
              debugPrint('Tapped outside: ${event.position}');
              FocusScope.of(context).unfocus();
            },
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search your interest",
              prefixIcon: const Icon(Icons.search),
              // Suffix icon to add the hobby entered in the search field.
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // Trim the input text to remove extra spaces.
                  String newHobby = searchController.text.trim();
                  if (newHobby.isNotEmpty) {
                    // If the hobby is not already in the list, add it.
                    if (!hobbies.contains(newHobby)) {
                      setState(() {
                        hobbies.add(newHobby);
                        widget.hobbiesController.add(newHobby);
                      });
                    }
                    // Clear the search field after adding.
                    searchController.clear();
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (value) {
              // Rebuild the UI when the search text changes to update the filtered list.
              setState(() {});
            },
          ),
          const SizedBox(height: 16),
          // Wrap widget to display hobbies as selectable chips.
          // SingleChildScrollView allows scrolling if there are many hobby options.
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                // Filter hobbies based on the search text.
                children: hobbies.where((hobby) {
                  if (searchController.text.isNotEmpty &&
                      !hobby
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                    return false;
                  }
                  return true;
                }).map((hobby) {
                  // Check if the hobby is already selected.
                  bool isSelected = widget.hobbiesController.contains(hobby);
                  return GestureDetector(
                    // Toggle selection status on tap.
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          widget.hobbiesController.remove(hobby);
                        } else {
                          widget.hobbiesController.add(hobby);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // Change border style based on selection.
                        border: isSelected
                            ? Border.all(
                                color: AppColors
                                    .secondary, // Selected border color.
                                width: 1.5,
                              )
                            : Border.all(
                                color: Colors.black, // Unselected border color.
                                width: 1.0,
                              ),
                        // Change background color based on selection.
                        color:
                            isSelected ? AppColors.primary : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(
                        hobby,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Display a warning message if fewer than 5 hobbies are selected.
          if (widget.hobbiesController.length < 5)
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Select at least 5 hobbies. 😇",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
