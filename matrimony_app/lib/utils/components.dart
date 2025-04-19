import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/homepage.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import '../core/app_colors.dart';
import '../screens/dashboard_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/user_details_screen.dart';

/// A utility class that provides common UI components for the HeartLink.net app.
///
/// It includes methods to create a custom AppBar, Drawer, TextFormField, and a dropdown selection list.
class Components {
  // /// Create a global navigator key that will always point to a valid context.
  // static final GlobalKey<NavigatorState> navigatorKey =
  //     GlobalKey<NavigatorState>();

// Helper function to create a page route with a slide animation.
  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Use a curved animation for smoothness.
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        // Slide transition: new page slides in from 10% below.
        final slideTween = Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        );

        // Fade transition: new page fades in from 0% to 100% opacity.
        final fadeTween = Tween<double>(
          begin: 0,
          end: 1,
        );

        return FadeTransition(
          opacity: fadeTween.animate(curvedAnimation),
          child: SlideTransition(
            position: slideTween.animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }

  /// Returns a customized [AppBar] widget.
  ///
  /// [scaffoldKey] is used to control the opening of the Drawer.
  /// [icon] is the icon to display alongside the title.
  /// [title] is the text to display in the AppBar.
  static PreferredSize getAppBar({
    scaffoldKey,
    required IconData icon,
    required String title,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60), // Custom height
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25), // Rounded corners at the bottom
          bottomRight: Radius.circular(25),
        ),
        child: AppBar(
          // The leading widget is an IconButton that opens the drawer.
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              size: 25,
              weight:
                  400, // Note: 'weight' is not a valid parameter for the Icon widget.
              color: AppColors.lightText,
            ),
            onPressed: () {
              scaffoldKey.currentState
                  ?.openDrawer(); // Opens the sidebar drawer.
            },
          ),
          // The title consists of a Row with an icon and text.
          title: Row(
            children: [
              Icon(
                icon,
                size: 25,
                weight:
                    400, // Note: 'weight' is not a valid parameter for the Icon widget.
                color: AppColors.lightText,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightText,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.pink[400],
        ),
      ),
    );
  }

  /// Returns a customized [Drawer] widget for the app's sidebar.
  ///
  /// [context] is used for navigation actions.
  static Drawer getDrawer({
    required String adminIdentifier,
    required context,
  }) {
    return Drawer(
      child: Column(
        children: [
          // Sidebar header with user account information.
          UserAccountsDrawerHeader(
            onDetailsPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Homepage(
                    adminIdentifier: adminIdentifier,
                    screenIdx: 3,
                  ),
                ),
              );
            },
            accountName: const Text(
              "Yash Kakadiya",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("yashkakadiya931@gmail.com"),
            // Profile picture which also acts as a button.
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Homepage(
                      adminIdentifier: adminIdentifier,
                      screenIdx: 3,
                    ),
                  ),
                );
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/ma_about_us.gif'),
              ),
            ),
            decoration: const BoxDecoration(color: AppColors.primary),
          ),

          // Sidebar option for navigating to the Home/Dashboard screen.
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primary),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DashboardScreen(
                    adminIdentifier: adminIdentifier,
                  ),
                ),
              );
            },
          ),

          // Sidebar option for logging out and navigating to the Onboarding screen.
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Returns a configured [TextFormField] widget.
  ///
  /// [context] is used for managing focus.
  /// [keyboardType] specifies the type of keyboard for input.
  /// [controller] manages the text being edited.
  /// [validator] is a function to validate the input.
  /// [labelText] is the label for the form field.
  /// [hintText] is the placeholder text.
  /// [obscureText] indicates if the text should be hidden (e.g., for passwords).
  /// [suffixIcon] is an optional widget to display at the end of the field.
  /// [inputFormatters] are optional formatters for the input.
  static TextFormField getFormField({
    required context,
    required keyboardType,
    required controller,
    required validator,
    required labelText,
    required hintText,
    obscureText = false,
    suffixIcon,
    inputFormatters,
    textCapitalization,
  }) {
    return TextFormField(
      // Dismisses the keyboard when the user taps outside the field.
      onTapOutside: (PointerDownEvent event) {
        debugPrint('Tapped outside: ${event.position}');
        FocusScope.of(context).unfocus();
      },
      // Automatically validate the field as the user interacts.
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  /// Returns a widget containing a dropdown selection list.
  ///
  /// [hintText] is the placeholder text when no option is selected.
  /// [options] is the list of string options available.
  /// [selectedValue] is the currently selected value.
  /// [onChanged] is the callback function when the selection changes.
  static Widget getSelectionList({
    required String hintText,
    required List<String> options,
    required String? selectedValue,
    required onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          isExpanded: true,
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            hoverColor: AppColors.primary,
          ),
          // Sets the current value if it exists in the options list; otherwise, null.
          value: options.contains(selectedValue) ? selectedValue : null,
          hint: Text(
            hintText,
            style: const TextStyle(color: AppColors.lightText),
          ),
          // Converts each option into a DropdownMenuItem.
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          // Validator ensures that an option is selected.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Select $hintText 😇";
            }
            return null;
          },
        ),
      ],
    );
  }

  static void getAddEditUserToast({
    required context,
    required String adminIdentifier,
    required bool isAdd,
    required String userId,
  }) {
    return CherryToast(
      icon: Icons.verified,
      iconColor: isAdd ? Colors.green : Colors.blue,
      iconSize: 30,
      themeColor: Colors.transparent,
      shadowColor: AppColors.secondary,
      animationCurve: Curves.easeInCubic,
      backgroundColor: Colors.white,
      animationDuration: const Duration(seconds: 1),
      toastDuration: const Duration(seconds: 3),
      title: Text(
        'User ${isAdd ? 'Added' : 'Edited'} Successfully. 😀',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      toastPosition: Position.top,
      displayCloseButton: true,
      animationType: AnimationType.fromLeft,
      displayIcon: true,
      // action: Text(
      //   isAdd ? '' : 'View Edited Profile?',
      //   style: const TextStyle(
      //     color: AppColors.secondary,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      // actionHandler: () {
      //   print('id:${userId}');
      //   print('adinId: $adminIdentifier');
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => UserDetailsScreen(
      //         adminIdentifier: adminIdentifier,
      //         id: userId, // Use the data ID.
      //       ),
      //     ),
      //   );
      // },
    ).show(context);
  }

  static void getDeleteUserToast({required context}) {
    return CherryToast(
      icon: Icons.restore_from_trash,
      iconColor: Colors.red,
      iconSize: 30,
      themeColor: Colors.transparent,
      shadowColor: AppColors.secondary,
      animationCurve: Curves.easeInCubic,
      backgroundColor: Colors.white,
      animationDuration: const Duration(seconds: 1),
      toastDuration: const Duration(seconds: 3),
      title: const Text(
        'User deleted Successfully. 🥲',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      toastPosition: Position.top,
      displayCloseButton: true,
      animationType: AnimationType.fromLeft,
      displayIcon: true,
    ).show(context);
  }

  static Widget showLoading({Color? overlayBackgroundColor}) {
    return Center(
      child: OverlayLoaderWithAppIcon(
        isLoading: true,
        appIconSize: 50.0,
        overlayOpacity: 1.0,
        overlayBackgroundColor: overlayBackgroundColor ?? Colors.transparent,
        circularProgressColor: AppColors.primary,
        appIcon: Image.asset('assets/icons/main_icon.png'),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
