import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:matrimony_app/core/app_colors.dart';
import 'package:matrimony_app/screens/about_us_screen.dart';
import 'package:matrimony_app/screens/explore_screen.dart';
import 'package:matrimony_app/screens/favorite_users_screen.dart';
import 'package:matrimony_app/screens/user_list_screen.dart';
import '../utils/components.dart';

/// A homepage widget that serves as the main landing screen for HeartLink.net.
/// It contains a [PageView] for navigating between different screens, a custom
/// app bar, a navigation drawer, and a curved bottom navigation bar.
class Homepage extends StatefulWidget {
  final String adminIdentifier;

  /// Creates a [Homepage] widget.
  ///
  /// The [screenIdx] parameter sets the initial screen index to display.
  const Homepage(
      {super.key, required this.adminIdentifier, required this.screenIdx});

  /// The initial screen index.
  final int screenIdx;

  @override
  State<Homepage> createState() => _HomepageState();
}

/// State class for [Homepage] that manages the current page and navigation.
class _HomepageState extends State<Homepage> {
  /// Current page index for the [PageView].
  int _page = 0;

  /// Global key for the curved bottom navigation bar.
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  /// Global key for the [Scaffold] widget, used to control the navigation drawer.
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// Controller for managing the [PageView]'s pages.
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize the current page using the provided screen index.
    _page = widget.screenIdx;
    // Initialize the PageController with the current page.
    _pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    // Dispose of the PageController to free up resources.
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the list of screens to be displayed in the PageView.
    List<Widget> screens = [
      ExploreScreen(adminIdentifier: widget.adminIdentifier),
      UserListScreen(adminIdentifier: widget.adminIdentifier),
      FavoriteUsersScreen(adminIdentifier: widget.adminIdentifier),
      AboutUsScreen(adminIdentifier: widget.adminIdentifier),
    ];

    // Define a list of icon and title pairs for the AppBar.
    List appList = [
      [Icons.explore, 'Explore'],
      [Icons.people, 'Profiles'],
      [Icons.favorite, 'Favorite Profiles'],
      [Icons.info, 'About Us'],
    ];

    // Define the list of icons for the curved bottom navigation bar.
    List<Widget> list = const <Widget>[
      Icon(Icons.explore, size: 30, color: AppColors.primary),
      Icon(Icons.people, size: 30, color: AppColors.primary),
      Icon(Icons.favorite, size: 30, color: AppColors.primary),
      Icon(Icons.info, size: 30, color: AppColors.primary),
    ];

    return Scaffold(
      key: scaffoldKey,
      // Build the AppBar using a custom method from Components.
      appBar: Components.getAppBar(
          icon: appList[_page][0],
          title: appList[_page][1],
          scaffoldKey: scaffoldKey),
      // Add the navigation drawer using a custom method from Components.
      drawer: Components.getDrawer(
        context: context,
        adminIdentifier: widget.adminIdentifier,
      ),
      // The body is a PageView that allows horizontal swiping between screens.
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          // Update the current page index when the user swipes between pages.
          setState(() {
            _page = page;
          });
        },
        children: screens,
      ),
      // The curved bottom navigation bar for quick navigation between screens.
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page, // Set the initial index.
        items: list, // List of icons to display.
        maxWidth: double.infinity,
        height: 50.0,
        // Background color for the navigation bar items container.
        color: Colors.grey[200]!,
        // Background color for the selected button.
        buttonBackgroundColor: const Color(0xFFFFE8EF),
        // Color behind the navigation bar.
        backgroundColor: AppColors.primary,
        // Animation settings for when an item is tapped.
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          // Update the current page and navigate to the selected page.
          setState(() {
            _page = index;
          });
          // Immediately jump to the selected page.
          _pageController.jumpToPage(index);
        },
        // Allow index change when tapping on an item.
        letIndexChange: (index) => true,
      ),
    );
  }
}
