import 'package:flutter/material.dart';
import 'package:matrimony_app/core/app_colors.dart';
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

import '../utils/string_constants.dart';
import '../data/models/user_model.dart';

class AddEditUserScreen extends StatefulWidget {
  int? id;
  AddEditUserScreen({super.key, this.id});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  // Controllers for the input fields.
  bool isAdd = true;
  bool isFavoriteController = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  String? age;
  String heightController = '5\'5 ft';
  String weightController = '55 kg';
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
  // If adding more pages, define additional GlobalKey<FormState> variables.

  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    // Retrieve the user data if needed.
    if (widget.id != null) {
      isAdd = false;
      Map<String, dynamic> user = UserModel.userList[widget.id!];

      isFavoriteController = user[ISFAVORITE];
      fullNameController.text = user[NAME] ?? '';
      emailController.text = user[EMAIL] ?? '';
      passwordController.text = user[PASSWORD] ?? '';
      confirmPasswordController.text = user[PASSWORD] ?? '';
      phoneController.text = user[PHONE] ?? '';
      genderController.text = user[GENDER] ?? '';
      birthdateController.text = user[BIRTHDATE] ?? '';
      age = user[AGE];
      heightController = user[HEIGHT] ?? '';
      weightController = user[WEIGHT];
      hobbiesController = user[HOBBIES] ?? [];
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
    }
  }

  @override
  void dispose() {
    // Dispose controllers and the PageController.
    pageController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    genderController.dispose();
    birthdateController.dispose();
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

  // A helper method to validate the current page.
  // Add more cases if you add more pages.
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
        return hobbiesController.length < 5 ? false : true;
      case 8:
        return educationCareerFormKey.currentState!.validate() ?? true;
      case 9:
        return socialStatusFormKey.currentState!.validate() ?? true;
      case 10:
        return locationFormKey.currentState!.validate() ?? true;

      // case n: // For additional page...
      //   return additionalFormKey.currentState?.validate() ?? false;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    genderController.text =
        genderController.text == 'female' ? 'female' : 'male';
    // List of onboarding pages.
    // To add more pages, simply extend this list and update _validateCurrentPage accordingly.
    List<Widget> onboardingPages = [
      NameOnboardingPage(
        formKey: nameFormKey,
        fullNameController: fullNameController,
      ),
      EmailOnBoardingPage(
        isAdd: isAdd,
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
        age: age,
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
      HobbiesOnboardingScreen(
        hobbiesController: hobbiesController,
        formKey: hobbiesFormKey,
      ),
      EducationCareerOnboardingScreen(
        educationController: educationController,
        occupationController: occupationController,
        employedInController: employedInController,
        incomeController: incomeController,
        formKey: educationCareerFormKey,
      ),
      SocialStatusOnboardingScreen(
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

    // Update progress based on the current page and total pages.
    double progressValue = (currentPage + 1) / onboardingPages.length;

    return Scaffold(
      appBar: AppBar(
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
            IconButton(
              onPressed: () {
                setState(() {
                  isFavoriteController = !isFavoriteController;
                });
              },
              icon: Icon(
                Icons.favorite,
                color:
                    isFavoriteController ? AppColors.secondary : Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.pink[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(30),
              value: progressValue,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              backgroundColor: Colors.grey[300],
              minHeight: 5,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (newPage) async {
                  bool isValid = await validateCurrentPage();
                  if (!isValid) {
                    // If validation fails, animate back to the current page.
                    pageController.animateToPage(
                      currentPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    return; // Do not update the current page.
                  }

                  // Allow backward swipe or forward swipe when valid.
                  setState(() {
                    currentPage = newPage;
                  });
                },
                itemBuilder: (context, index) {
                  return onboardingPages[index];
                },
              ),
            ),
            // const Spacer(),
            // Next / Submit button
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool isValid = await validateCurrentPage();
                        if (!isValid) return;

                        if (currentPage < onboardingPages.length - 1) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          saveUser();
                          // On the last page, submit the form.
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
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
                            ? 'Submit 😎'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                checkSaveBtn(),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget checkSaveBtn() {
    if (widget.id != null) {
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
              'Save',
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

  void showCancelAddUserConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Cancel ${widget.id != null ? 'Editing' : 'Adding'}!'),
          content: Text(
              'Are you sure you don\'t want to ${widget.id != null ? 'edit' : 'add'} user?'),
          actions: [
            Row(
              children: [
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
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DashboardScreen(),
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
                        'No 🥲',
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
                      onPressed: () {
                        saveUser();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
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

  void saveUser() {
    Map<String, dynamic> userData = {
      NAME: fullNameController.text,
      EMAIL: emailController.text,
      PASSWORD: passwordController.text,
      PHONE: phoneController.text,
      GENDER: genderController.text,
      BIRTHDATE: birthdateController.text,
      AGE: age,
      HEIGHT: heightController,
      WEIGHT: weightController,
      HOBBIES: hobbiesController,
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
    print(userData);

    if (widget.id != null) {
      UserModel.updateUser(widget.id!, userData);
      print('User Updated from screen');
    } else {
      UserModel.addUser(userData);
      print('User Added');
    }
  }
}
