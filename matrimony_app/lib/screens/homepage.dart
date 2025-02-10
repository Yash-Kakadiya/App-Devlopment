import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/screens/about_us_screen.dart';
import 'package:matrimony_app/screens/favorite_users_screen.dart';
import 'package:matrimony_app/screens/user_list_screen.dart';

import '../utils/components.dart';
import 'explore_profiles_screen.dart';

class Homepage extends StatefulWidget {
  // Accept the initial screen index as a parameter.
  const Homepage({super.key, required this.screenIdx});

  final int screenIdx;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // State variable to track the current index.
  int idx = 3;
  late PageController _pageController;
  late NotchBottomBarController _notchController;

  @override
  void initState() {
    super.initState();
    // Initialize idx with the passed value from widget.
    idx = widget.screenIdx;
    _pageController = PageController(initialPage: idx);
    _notchController = NotchBottomBarController(index: idx);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define your screens. Each entry is a three-element list:
    // [icon, title, screen widget].
    List<List<dynamic>> screens = [
      [Icons.explore, 'Explore', ExploreProfilesScreen()],
      [Icons.people, 'Profiles', UserListScreen()],
      [Icons.favorite, 'Favourite Profiles', FavoriteUsersScreen()],
      [Icons.info, 'About Us', AboutUsScreen()],
    ];

    return Scaffold(
      key: scaffoldKey,
      appBar: Components.getAppBar(
        scaffoldKey: scaffoldKey,
        icon: screens[idx][0],
        // Use the current index (idx) for the title.
        title: screens[idx][1],
      ),
      drawer: Components.getDrawer(context: context),
      extendBody: true, // Allow body to extend behind the bottom nav bar.
      body: Padding(
        // Add bottom padding to ensure content does not get hidden behind the nav bar.
        padding: const EdgeInsets.only(bottom: 60.0), // Adjust the height as needed.
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              idx = page;
            });
            _notchController.jumpTo(page);
          },
          children: List.generate(screens.length, (index) => screens[index][2]),
        ),
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchController,
        color: Colors.grey[200]!,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 0.0,
        notchColor: const Color(0xFFFFE8EF),
        removeMargins: true,
        bottomBarWidth: MediaQuery.of(context).size.width,
        showShadow: true,
        showBottomRadius: true,
        textAlign: TextAlign.center,
        durationInMilliSeconds: 100,
        itemLabelStyle: const TextStyle(fontSize: 12),
        showTopRadius: false,
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.explore, color: AppColors.primary),
            activeItem: Icon(Icons.explore, color: AppColors.secondary),
            itemLabel: 'Explore',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.people, color: AppColors.primary),
            activeItem: Icon(Icons.people, color: AppColors.secondary),
            itemLabel: 'Profiles',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.favorite, color: AppColors.primary),
            activeItem: Icon(Icons.favorite, color: AppColors.secondary),
            itemLabel: 'Favourite Profiles',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.info, color: AppColors.primary),
            activeItem: Icon(Icons.info, color: AppColors.secondary),
            itemLabel: 'About Us',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            idx = index;
          });
        },
        kIconSize: 24.0,
      ),
    );
  }
}
