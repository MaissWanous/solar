import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/login/register_customer.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Color yellow = Color(0xFFFFBF00);
  final Color more2grey = Color(0xFFA39F9F);
  final Color moregrey = Color(0xFFB3B3B3);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String? selectedAccount;

  Widget buildCircle(String label) {
    bool isSelected = selectedAccount == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAccount = label;
        });
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isSelected ? yellow : Colors.transparent,
          border: Border.all(
            color: yellow,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 35.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Aclonica',
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: 'Register Account To '),
                              TextSpan(text: 'Solar Energy', style: TextStyle(color: yellow)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'Hello there, register to continue',
                        style: TextStyle(fontSize: 14.0, color: more2grey),
                      ),
                      SizedBox(height: 30.0),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Email must not be empty";
                          }
                          else if (!isValidEmail(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        hint: 'Email',
                        prefix: Icons.email,
                      ),
                      SizedBox(height: 25.0),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Password must not empty";
                          }

                          return null;
                        },
                        hint: "Password",
                        prefix: Icons.lock,
                        suffix: Icons.remove_red_eye,
                        isPassword: true,
                      ),
                      SizedBox(height: 25.0),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password must not empty";
                          }
                          return null;
                        },
                        hint: 'Confirm password',
                        prefix: Icons.check_circle,
                        isPassword: true,
                      ),
                      SizedBox(height: 35),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildCircle('Customer'),
                                SizedBox(width: 9.0),
                                Text(
                                  'Customer',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildCircle('Shopkeeper'),
                                SizedBox(width: 9),
                                Text(
                                  'Shopkeeper',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                buildCircle('Technical'),
                                SizedBox(width: 9),
                                Text(
                                  'Technical',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              defultButton(
                text: 'Next',
                function: () {
                  if (formKey.currentState?.validate() ?? false) {
                    if (selectedAccount != null) {
                     {
                       if(selectedAccount=='Customer')
                         {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context)=>Register_customer(),
                               ),
                           );
                         }

                     }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please select an account type."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                backgroundColor: yellow,
                borderColor: yellow,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.com",
  );
  return emailRegex.hasMatch(email);
}



