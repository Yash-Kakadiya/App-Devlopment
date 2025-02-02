import 'package:flutter/material.dart';
import 'package:matrimony_app/utils/components.dart';
import '../utils/app_colors.dart';
import '../utils/string_const.dart';
import '../utils/user_model.dart';

class AddEditUserScreen extends StatefulWidget {
  // Map<String, dynamic>? user;
  int? id;
  AddEditUserScreen({super.key, this.id});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  List<String> citiesList = [
    'Rajkot',
    'Surat',
    'Ahmedabad',
    'Vadodara',
    'Gandhinagar',
    'Jamnagar',
  ];
  String dob = '';
  DateTime? date = DateTime.now();

  bool favoriteController = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String cityController = '🗺️ City';
  int age = 18;
  String genderController = 'male';
  List<List> hobbiesController = [
    ['Video Games 🎮', false],
    ['Reading 📖', false],
    ['Music 📻', false],
    ['Sports 🤾‍♂️', false],
    ['Traveling 🚞', false],
    ['Dancing 🕺', false],
    ['Cooking 🧑‍🍳', false],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      Map<String, dynamic> user = UserModel.userList[widget.id!];
      print(user);
      favoriteController = user[ISFAVORITE];
      fullNameController.text = user[NAME];
      emailController.text = user[EMAIL];
      passwordController.text = user[PASSWORD];
      confirmPasswordController.text = user[PASSWORD];
      mobileController.text = user[MOBILE];
      List<String> parts = user[DOB].split('-');
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      date = DateTime(year, month, day);
      dob = '${date!.day}-${date!.month}-${date!.year}';
      dateController.text = dob;
      cityController = user[CITY];
      genderController = user[GENDER];
      hobbiesController = user[HOBBIES];
    }
  }

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        // appBar: Components.getAppBar(
        //   icon: Icons.person_add,
        //   title: 'Add User',
        // ),
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(
                Icons.person_add,
                size: 25,
                weight: 400,
                color: AppColors.textDark,
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text(
                  'Add User',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  favoriteController ? Icons.favorite : Icons.favorite_border,
                  size: 25,
                  color: favoriteController ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    favoriteController =
                        !favoriteController; // ✅ Toggle favorite status
                  });
                },
              ),
            ],
          ),
          backgroundColor: AppColors.primary,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  getFormField(
                    controller: fullNameController,
                    keyboardType: TextInputType.name,
                    labelText: '🙂 Full Name',
                    hintText: 'Enter Full Name 🙃',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid name (3-50 characters, alphabets only) 😇';
                      }
                      var regex = RegExp(r"^[a-zA-Z\s'-]{3,50}$");

                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid full name \n (3-50 characters, alphabets only) 😇';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: '📧 Email Address',
                    hintText: 'Enter your Email 🙃',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid email address 😇';
                      }
                      var regex =
                          RegExp(r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$");
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid email address 😇';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: '🗝️ Password',
                    hintText: 'Enter your password 🙃',
                    obscureText: isPasswordHidden,
                    suffixIcon: InkWell(
                      onTapDown: (details) {
                        setState(() {
                          isPasswordHidden = false;
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          isPasswordHidden = true;
                        });
                      },
                      child: Icon(
                        isPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password 😇';
                      }
                      var regex = RegExp(
                          r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
                      if (!regex.hasMatch(value)) {
                        return 'Set strong Password 💪:\n Minimum 8 characters\nat least contains 1\n uppercase letter,\n lowercase letter,\n digit,\n special character 😇';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: '🔐 Confirm Password',
                    hintText: 'Enter your password again 🙃',
                    obscureText: isPasswordHidden,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter confirm password 😇';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match 😇';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    labelText: '📱 Mobile number',
                    hintText: 'Enter your mobile number 🙃',
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter mobile number 😇';
                      }
                      var regex = RegExp(r"^[0-9]{10}$");
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid 10-digit mobile number 😇.';
                      }
                      if (isUserRegistered(value)) {
                        return 'Mobile number is already registered 😇.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getDateField(),
                  const SizedBox(
                    height: 20,
                  ),
                  getCityField(),
                  const SizedBox(
                    height: 20,
                  ),
                  getGenderField(),
                  const SizedBox(
                    height: 20,
                  ),
                  getHobbiesField(),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: saveForm,
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppColors.secondary),
                        ),
                        child: const Text(
                          'Save User',
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: resetForm,
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.redAccent),
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

  void saveForm() {
    if (formKey.currentState!.validate()) {
      print('Form Saved');
      if (widget.id != null) {
        UserModel.updateUser(
          id: widget.id!,
          name: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
          mobile: mobileController.text,
          dob: dob,
          age: age.toString(),
          city: cityController,
          gender: genderController,
          hobbies: hobbiesController,
          isFavorite: favoriteController,
        );
      } else {
        UserModel.addUser(
          name: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
          mobile: mobileController.text,
          dob: dob,
          age: '18',
          city: cityController,
          gender: genderController,
          hobbies: hobbiesController,
          isFavorite: favoriteController,
        );
      }
      resetForm();
      // Navigator.of(context).pop();
      Navigator.pop(context);
    }
  }

  void resetForm() {
    formKey.currentState!.reset();
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    mobileController.clear();
    dob = 'Select Date of birth';
    dateController.text = '';
    cityController = '';
    genderController = 'male';
    for (var hobby in hobbiesController) {
      hobby[1] = false;
    }
  }

  Widget getFormField({
    required keyboardType,
    required controller,
    required validator,
    required labelText,
    required hintText,
    obscureText = false,
    suffixIcon,
    maxLength,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget getDateField() {
    return TextFormField(
      mouseCursor: MouseCursor.defer,
      keyboardType: TextInputType.datetime,
      showCursor: true,
      controller: dateController,
      onTap: () async {
        date = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(date!.year - 80),
          lastDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );
        dob = '${date!.day}-${date!.month}-${date!.year}';
        setState(() {
          dateController.text = dob;
        });
      },
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value == '🗓️ Select Date of birth') {
          return 'Select your date of birth 😇';
        }
        if (value.length < 8) {
          return 'Maybe date format not supported 😇';
        }
        List<String> parts = dateController.text.split('-');
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        date = DateTime(year, month, day);
        age = DateTime.now().year - date!.year;
        if (DateTime.now().month < date!.month ||
            (DateTime.now().month == date!.month &&
                DateTime.now().day < date!.day)) {
          age--;
        }
        if (age < 18) {
          print('age:$age, date: $date');
          return 'You must be at least 18 years old to register.';
        }
        return null;
      },
      decoration: InputDecoration(
        label: const Text('🗓️ Date of birth'),
        hintText: 'Select your date of birth 🙃',
        suffixIcon: const Icon(Icons.calendar_month),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget getCityField() {
    return DropdownButtonFormField(
      value: citiesList.contains(cityController) ? cityController : null,
      decoration: InputDecoration(
        labelText: cityController,
        hintText: 'Select City 🙃',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      items: citiesList
          .map(
            (city) => DropdownMenuItem(
              value: city,
              child: Text(city),
            ),
          )
          .toList(),
      onChanged: (value) => setState(
        () {
          if (cityController == '🗺️ City') {
            cityController = value!;
          }
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value == '🗺️ City') {
          return 'Select City 😇';
        }
        return null;
      },
    );
  }

  Widget getGenderField() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          const Text(
            '🤔 Gender:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioMenuButton(
                value: 'male',
                groupValue: genderController,
                onChanged: (value) {
                  setState(() {
                    genderController = value!;
                  });
                },
                child: const Text(
                  '🧔‍♂️ Male',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              RadioMenuButton(
                value: 'female',
                groupValue: genderController,
                onChanged: (value) {
                  setState(() {
                    genderController = value!;
                  });
                },
                child: const Text(
                  '👩‍🦰 Female',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getHobbiesField() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          const Text(
            '😈 Hobbies:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            width: 45,
          ),
          getHobbiesList(),
        ],
      ),
    );
  }

  Widget getHobbiesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHobbyCheckBox(0),
        getHobbyCheckBox(1),
        getHobbyCheckBox(2),
        getHobbyCheckBox(3),
        getHobbyCheckBox(4),
        getHobbyCheckBox(5),
        getHobbyCheckBox(6),
      ],
    );
  }

  Widget getHobbyCheckBox(int i) {
    return CheckboxMenuButton(
      value: hobbiesController[i][1],
      onChanged: (value) {
        setState(() {
          hobbiesController[i][1] = !hobbiesController[i][1];
        });
      },
      child: Text(
        hobbiesController[i][0],
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  bool isUserRegistered(String value) {
    var userList = UserModel.userList;
    for (int i = 0; i < userList.length; i++) {
      if (userList[i][MOBILE] == value) {
        return true;
      }
    }
    return false;
  }
}
