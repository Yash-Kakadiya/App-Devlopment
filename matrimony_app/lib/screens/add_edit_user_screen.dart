import 'package:flutter/material.dart';
import 'package:matrimony_app/screens/add_edit_screens/birthdate_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/education_career_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/gender_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/height_weight_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/hobbies_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/location_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/name_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/email_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/password_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/phone_onboarding_page.dart';
import 'package:matrimony_app/screens/add_edit_screens/social_status_onboarding_page.dart';
import 'package:matrimony_app/screens/dashboard_screen.dart';
import 'package:matrimony_app/utils/components.dart';
import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../services/user_model.dart';

/// A screen that allows adding or editing a user profile in an admin‑specific SQLite data.
/// The screen is composed of multiple onboarding pages (forms) for collecting user data.
/// If an [id] is provided, the screen loads the existing user data for editing;
/// otherwise, a new user is added.
/// The [adminIdentifier] is used to ensure that the correct admin’s data is accessed.
class AddEditUserScreen extends StatefulWidget {
  /// Unique identifier for the admin (e.g. admin username) to select the correct DB.
  final String adminIdentifier;

  /// The [id] of the user to be edited; if null, a new user will be created.
  final String? id;

  /// Creates an [AddEditUserScreen] widget.
  const AddEditUserScreen({super.key, required this.adminIdentifier, this.id});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  // Flag to determine if this screen is for adding a new user.
  bool isAdd = true;
  bool isLoading = false;
  // Controller for tracking the favorite status (stored as a bool here, but later converted if needed).
  int isFavoriteController = 0;

  // TextEditingControllers for user input fields.
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  // Note: hobbiesController is a list; we will join it to a String when saving.
  List<String> hobbiesController = [];
  TextEditingController educationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController employedInController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController motherTongueController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  // Global keys for each onboarding page's form.
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> genderFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> birthdateFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> heightWeightFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hobbiesFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> educationCareerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> socialStatusFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> locationFormKey = GlobalKey<FormState>();
  // Controller for the PageView that holds the onboarding pages.
  late final PageController pageController;
  // Tracks the current page index in the onboarding flow.
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController starting at page 0.
    pageController = PageController(initialPage: 0);

    // If an ID is provided, we are editing an existing user; load its data.
    if (widget.id != null) {
      loadUserData();
    }
  }

  /// Loads user data from the admin-specific data and updates the controllers.
  Future<void> loadUserData() async {
    isLoading = true;
    // Fetch the user using the asynchronous SQLite call.
    Map<String, dynamic> immutableUser = (await UserModel.getUser(widget.id!))!;
    Map<String, dynamic> user = Map<String, dynamic>.from(immutableUser);

    setState(() {
      isAdd = false;
      isFavoriteController = user[ISFAVORITE];
      fullNameController.text = user[NAME] ?? '';
      emailController.text = user[EMAIL] ?? '';
      passwordController.text = user[PASSWORD] ?? '';
      confirmPasswordController.text = user[PASSWORD] ?? '';
      phoneController.text = user[PHONE] ?? '';
      genderController.text = user[GENDER] ?? '';
      birthdateController.text = user[BIRTHDATE] ?? '';
      ageController.text = user[AGE];
      heightController.text = user[HEIGHT] ?? '';
      weightController.text = user[WEIGHT];
      // Since hobbies are stored as a comma-separated string, split it into a list.
      hobbiesController = (user[HOBBIES] as String).split(',');
      educationController.text = user[EDUCATION] ?? '';
      occupationController.text = user[OCCUPATION] ?? '';
      employedInController.text = user[EMPLOYED_IN] ?? '';
      incomeController.text = user[INCOME] ?? '';
      maritalStatusController.text = user[MARITAL_STATUS] ?? '';
      motherTongueController.text = user[MOTHER_TONGUE] ?? '';
      religionController.text = user[RELIGION] ?? '';
      countryController.text = user[COUNTRY] ?? '';
      stateController.text = user[STATE] ?? '';
      cityController.text = user[CITY] ?? '';
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // Dispose all controllers and the PageController.
    pageController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    genderController.dispose();
    birthdateController.dispose();
    heightController.dispose();
    weightController.dispose();
    educationController.dispose();
    occupationController.dispose();
    employedInController.dispose();
    incomeController.dispose();
    maritalStatusController.dispose();
    motherTongueController.dispose();
    religionController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    super.dispose();
  }

  /// Validates the current page's form. Returns true if valid.
  Future<bool> validateCurrentPage() async {
    switch (currentPage) {
      case 0:
        return nameFormKey.currentState?.validate() ?? true;
      case 1:
        return emailFormKey.currentState?.validate() ?? true;
      case 2:
        return passwordFormKey.currentState?.validate() ?? true;
      case 3:
        return phoneFormKey.currentState?.validate() ?? true;
      case 4:
        return birthdateFormKey.currentState?.validate() ?? true;
      case 5:
        return genderFormKey.currentState?.validate() ?? true;
      case 6:
        return heightWeightFormKey.currentState?.validate() ?? true;
      case 7:
        // Ensure at least 5 hobbies are selected.
        return hobbiesController.length < 5 ? false : true;
      case 8:
        return educationCareerFormKey.currentState!.validate();
      case 9:
        return socialStatusFormKey.currentState!.validate();
      case 10:
        return locationFormKey.currentState!.validate();
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure gender is either 'female' or 'male'.
    genderController.text =
        genderController.text == 'female' ? 'female' : 'male';

    // List of onboarding pages for different sections.
    List<Widget> onboardingPages = [
      NameOnboardingPage(
        formKey: nameFormKey,
        fullNameController: fullNameController,
      ),
      EmailOnBoardingPage(
        formKey: emailFormKey,
        emailController: emailController,
      ),
      PasswordOnboardingPage(
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        formKey: passwordFormKey,
      ),
      PhoneOnboardingPage(
        isAdd: isAdd,
        phoneController: phoneController,
        formKey: phoneFormKey,
      ),
      BirthdateOnboardingPage(
        name: fullNameController.text,
        birthdateController: birthdateController,
        ageController: ageController,
        formKey: birthdateFormKey,
      ),
      GenderOnboardingPage(
        name: fullNameController.text,
        genderController: genderController,
        formKey: genderFormKey,
      ),
      HeightWeightOnboardingPage(
        gender: genderController.text,
        heightController: heightController,
        weightController: weightController,
      ),
      HobbiesOnboardingPage(
        hobbiesController: hobbiesController,
        formKey: hobbiesFormKey,
      ),
      EducationCareerOnboardingPage(
        educationController: educationController,
        occupationController: occupationController,
        employedInController: employedInController,
        incomeController: incomeController,
        formKey: educationCareerFormKey,
      ),
      SocialStatusOnboardingPage(
        maritalStatusController: maritalStatusController,
        motherTongueController: motherTongueController,
        religionController: religionController,
        formKey: socialStatusFormKey,
      ),
      LocationOnboardingPage(
        countryController: countryController,
        stateController: stateController,
        cityController: cityController,
        formKey: locationFormKey,
      ),
    ];

    // Calculate progress as a fraction of total pages.
    double progressValue = (currentPage + 1) / onboardingPages.length;

    return Scaffold(
      appBar: AppBar(
        // Back button that triggers a cancellation confirmation dialog.
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: AppColors.lightText,
          ),
          onPressed: () {
            showCancelAddUserConfirmationDialog(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display an icon and text based on whether adding or editing.
            Row(
              children: [
                Icon(
                  widget.id != null ? Icons.edit : Icons.person_add,
                  size: 25,
                  color: AppColors.lightText,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.id != null ? 'Editing User' : 'Adding User',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightText,
                  ),
                ),
              ],
            ),
            // Favorite icon (if needed) to toggle favorite status.
            IconButton(
              onPressed: () {
                setState(() {
                  isFavoriteController = isFavoriteController == 1 ? 0 : 1;
                });
              },
              icon: Icon(
                Icons.favorite,
                color: isFavoriteController == 1
                    ? AppColors.secondary
                    : Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.pink[400],
      ),
      body: isLoading
          ? Components.showLoading()
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Progress indicator showing onboarding progress.
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(30),
                    value: progressValue,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    backgroundColor: Colors.grey[300],
                    minHeight: 5,
                  ),
                  const SizedBox(height: 32),
                  // PageView to display onboarding pages.
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: onboardingPages.length,
                      onPageChanged: (newPage) async {
                        // Validate current page before allowing page change.
                        bool isValid = await validateCurrentPage();
                        if (!isValid) {
                          // If validation fails, animate back to the current page.
                          pageController.animateToPage(
                            currentPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          return; // Do not update the page.
                        }
                        setState(() {
                          currentPage = newPage;
                        });
                      },
                      itemBuilder: (context, index) {
                        return onboardingPages[index];
                      },
                    ),
                  ),
                  // Row containing Next/Submit button and a Save button (if editing).
                  Row(
                    children: [
                      checkSaveBtn(onboardingPages.length),
                      const SizedBox(width: 5),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate current page before proceeding.
                              bool isValid = await validateCurrentPage();
                              if (!isValid) return;

                              if (currentPage < onboardingPages.length - 1) {
                                // Go to next page if not on the last page.
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                // On the last page, save the user data.
                                await saveUser();
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              currentPage == onboardingPages.length - 1
                                  ? widget.id != null
                                      ? 'Save 😎'
                                      : 'Submit 😎'
                                  : 'Next',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  /// Returns a "Save" button if in editing mode and not on the last page.
  Widget checkSaveBtn(int onboardingPagesLength) {
    if (widget.id != null && currentPage != onboardingPagesLength - 1) {
      return Expanded(
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () async {
              bool isValid = await validateCurrentPage();
              if (!isValid) return;
              showSaveUserConfirmationDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Save 😎',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  /// Displays a confirmation dialog when canceling add/edit operation.
  /// Returns a Future<bool> that is true if the user confirms cancellation,
  /// and false otherwise.
  Future<bool> showCancelAddUserConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title:
                  Text('Cancel ${widget.id != null ? 'Editing' : 'Adding'}!'),
              content: Text(
                  'Are you sure you don\'t want to ${widget.id != null ? 'edit' : 'add'} user?'),
              actions: [
                Row(
                  children: [
                    // "No" button: User does not want to cancel.
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
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
                            Navigator.of(dialogContext).pop(false);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    // "Yes" button: User confirms cancellation.
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          child: const Text(
                            'Yes 🥲',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pushReplacement(
                                Components.createRoute(DashboardScreen(
                                    adminIdentifier: widget.adminIdentifier)));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Displays a confirmation dialog to save changes when editing an existing user.
  void showSaveUserConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Save Changes!'),
          content: const Text('Are you sure you want to save changes?'),
          actions: [
            Row(
              children: [
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
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5),
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
                        // Await saving the user data.
                        Map<String, dynamic> userMap = await saveUser();
                        // Navigate to DashboardScreen passing the adminIdentifier.
                        Navigator.pushReplacement(
                          context,
                          Components.createRoute(
                            DashboardScreen(
                              adminIdentifier: widget.adminIdentifier,
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

  /// Saves the user data to the SQLite data (admin-specific).
  /// Returns the saved user data as a Map.
  Future<Map<String, dynamic>> saveUser() async {
    // Convert the hobbies list into a comma-separated string.
    Map<String, dynamic> userData = {
      NAME: fullNameController.text,
      EMAIL: emailController.text,
      PASSWORD: passwordController.text,
      PHONE: phoneController.text,
      GENDER: genderController.text,
      BIRTHDATE: birthdateController.text,
      AGE: ageController.text,
      HEIGHT: heightController.text,
      WEIGHT: weightController.text,
      HOBBIES: hobbiesController.join(','), // Convert list to string.
      EDUCATION: educationController.text,
      OCCUPATION: occupationController.text,
      EMPLOYED_IN: employedInController.text,
      INCOME: incomeController.text,
      MARITAL_STATUS: maritalStatusController.text,
      MOTHER_TONGUE: motherTongueController.text,
      RELIGION: religionController.text,
      COUNTRY: countryController.text,
      STATE: stateController.text,
      CITY: cityController.text,
      ISFAVORITE: isFavoriteController,
    };
    String? userId = widget.id;
    print('onsave');
    print(userData);

    if (widget.id != null) {
      // Update the existing user.
      await UserModel.updateUser(widget.id!, userData);
      print('User Updated from screen');
      print('id:${widget.id}');
    } else {
      // Add a new user.
      userId = await UserModel.addUser(userData);
      print('User Added');
    }

    // Optionally, display a toast message.
    Components.getAddEditUserToast(
      context: context,
      adminIdentifier: widget.adminIdentifier,
      isAdd: isAdd,
      userId: userId!,
    );
    return userData;
  }
}
