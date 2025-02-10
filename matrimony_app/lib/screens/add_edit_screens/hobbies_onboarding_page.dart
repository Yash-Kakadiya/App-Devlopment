import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class HobbiesOnboardingScreen extends StatefulWidget {
  List<String> hobbiesController;
  GlobalKey<FormState> formKey;

  HobbiesOnboardingScreen({
    super.key,
    required this.hobbiesController,
    required this.formKey,
  });

  @override
  _HobbiesOnboardingScreenState createState() =>
      _HobbiesOnboardingScreenState();
}

class _HobbiesOnboardingScreenState extends State<HobbiesOnboardingScreen> {
  List<String> hobbies = [
    'Travel 🌍',
    'Cooking 🍳',
    'Reading 📚',
    'Fitness 🏋️',
    'Music 🎵',
    'Movies 🎬',
    'Photography 📸',
    'Sports ⚽',
    'Art 🎨',
    'Nature 🌿',
    'Technology 💻',
    'Fashion 👗',
    'Gaming 🎮',
    'Hiking 🥾',
    'Dancing 💃',
    'Writing ✍️',
    'Meditation 🧘',
    'Poetry 📜',
    'Camping 🏕️',
    'Science 🔬',
    'Interior Design 🏡',
    'Fishing 🎣',
    'Running 🏃',
    'Cycling 🚴',
    'Motor Sports 🏎️'
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title texts
          const Text(
            "Choose minimum 5 interests",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "that describes you. 😈",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            onTapOutside: (PointerDownEvent event) {
              // Optionally, you can print the event details or do other actions.
              debugPrint('Tapped outside: ${event.position}');
              FocusScope.of(context).unfocus();
            },
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search your interest",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  String newHobby = searchController.text.trim();
                  if (newHobby.isNotEmpty) {
                    // If the hobby is not already in the list, add it.
                    if (!hobbies.contains(newHobby)) {
                      setState(() {
                        hobbies.add(newHobby);
                        widget.hobbiesController.add(newHobby);
                      });
                    }
                    // Clear the search field
                    searchController.clear();
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: hobbies.where((hobby) {
                  if (searchController.text.isNotEmpty &&
                      !hobby
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                    return false;
                  }
                  return true;
                }).map((hobby) {
                  bool isSelected = widget.hobbiesController.contains(hobby);
                  return GestureDetector(
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
                        border: isSelected
                            ? Border.all(
                                color: AppColors.secondary, // Choose your color
                                width: 1.5,
                              )
                            : Border.all(
                                color: Colors.black, // Choose your color
                                width: 1.0,
                              ),
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
