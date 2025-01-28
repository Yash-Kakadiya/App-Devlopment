import 'package:flutter/material.dart';
import 'package:matrimony_app/utils/components.dart';
import '../utils/app_colors.dart';
import '../utils/string_const.dart';
import '../utils/user_model.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  List<String> citiesList = [
    'Rajkot',
    'Surat',
    'Ahmedabad',
    'Vadodara',
    'Gandhinagar',
    'Jamnagar',
  ];
  List<String> hobbies = [
    'Video Games 🎮',
    'Reading 📖',
    'Music 📻',
    'Sports 🤾‍♂️',
    'Traveling 🚞',
    'Dancing 🕺',
    'Cooking 🧑‍🍳',
  ];
  String dob = '';
  DateTime? date = DateTime.now();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? cityController;
  String? genderController = 'male';
  List<bool> hobbiesController = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Components.getAppBar(
          icon: Icons.person_add,
          title: 'Add User',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: fullNameController,
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
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: '🙂 Full Name',
                      hintText: 'Enter Full Name 🙃',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid email address 😇';
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid email address 😇';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '📧 Email Address',
                      hintText: 'Enter your Email 🙃',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password 😇';
                      }
                      var regex = RegExp(
                          r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
                      if (!regex.hasMatch(value)) {
                        return 'Set strong Password 💪:\n Minimum 8 characters\nat least contains 1\n uppercase letter,\n1 lowercase letter,\n digit,\n special character 😇';
                      }
                      return null;
                    },
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: '🗝️ Password',
                      hintText: 'Enter your password 🙃',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter confirm password 😇';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match 😇';
                      }
                      return null;
                    },
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: '🔐 Confirm Password',
                      hintText: 'Enter your password again 🙃',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: mobileController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter mobile number 😇';
                      }
                      var regex = RegExp(r"^[0-9]{10}$");
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid 10-digit mobile number 😇.';
                      }
                      // if (isUserRegistered(value)) {
                      //   return 'Mobile number is already registered 😇.';
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '📱 Mobile number',
                      hintText: 'Enter your mobile number 🙃',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onTap: () async {
                      date = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(date!.year - 80),
                        lastDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                      );
                      dob = '${date!.day}-${date!.month}-${date!.year}';
                      setState(() {
                        dateController.text=dob;
                      });
                    },
                    readOnly: true,
                    mouseCursor: MouseCursor.defer,
                    keyboardType: TextInputType.datetime,
                    showCursor: true,
                    controller: dateController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == '🗓️ Select Date of birth') {
                        return 'Select your date of birth 😇';
                      }

                      int age = DateTime.now().year - date!.year;
                      if (DateTime.now().month < date!.month ||
                          (DateTime.now().month == date!.month &&
                              DateTime.now().day < date!.day)) {
                        age--;
                      }
                      if (age < 18) {
                        return 'You must be at least 18 years old to register.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text('🗓️ Date of birth'),
                      hintText: 'Select your date of birth 🙃',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: '🗺️ City',
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
                        cityController = value;
                      },
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Select City 😇';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
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
                  ),
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
      UserModel.addUser(
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        mobile: mobileController.text,
        dob: dob!,
        age: '18',
        city: cityController!,
        gender: genderController!,
        hobbies: hobbies,
      );
      print(UserModel.getUserList());
      resetForm();
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
    cityController = '';
    genderController = 'male';
    for (int i = 0; i < hobbiesController.length; i++) {
      hobbiesController[i] = false;
    }
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
      value: hobbiesController[i],
      onChanged: (value) {
        setState(() {
          hobbiesController[i] = !hobbiesController[i];
        });
      },
      child: Text(
        hobbies[i],
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
