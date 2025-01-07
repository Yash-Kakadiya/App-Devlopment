import 'package:flutter/material.dart';

class DemoForm extends StatefulWidget {
  @override
  State<DemoForm> createState() => _DemoFormState();
}

class _DemoFormState extends State<DemoForm> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String registerText = "Register";
  String loginText = "Login";
  String buttonText = "Login";
  bool isRegister = false;
  String askText = "Register";
  String askStatement = "";
  GlobalKey<FormState> key = GlobalKey();
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Number';
                  }
                },
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Password';
                  }
                },
                obscureText: isHide,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTapDown: (details) {
                        setState(() {
                          isHide = false;
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          isHide = true;
                        });
                      },
                      child: Icon(Icons.visibility,
                          color: isHide ? null : Colors.red),
                    ),
                    labelText: "PASSWORD",
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: isRegister,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Value';
                      } else if (confirmPasswordController.text !=
                          passwordController.text) {
                        return 'Password and Confirm password are not same';
                      }
                    },
                    obscureText: isHide,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Enter Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    print(
                        'Login Successful: No.: ${phoneController.text} | Password: ${confirmPasswordController.text}');
                  }
                },
                child: Text(buttonText),
                onHover: (details){

                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      " ${isRegister ? 'Already SignedUP' : 'Have you Registered'}? "),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isRegister = !isRegister;
                        buttonText =
                            buttonText == loginText ? registerText : loginText;
                        askText =
                            askText == registerText ? loginText : registerText;
                      });
                    },
                    child: Text(
                      askText,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
