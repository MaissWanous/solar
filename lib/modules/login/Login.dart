import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/layout/home_layout_Technical.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/modules/forgot_password/forgot_password.dart';
import 'package:udemy_flutter/modules/login/Register.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          border: Border.all(color: yellow, width: 2),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontFamily: 'Aclonica',
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'To ',
                      style: TextStyle(
                        fontFamily: 'Aclonica',
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Solar Energy',
                      style: TextStyle(
                        fontFamily: 'Aclonica',
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: yellow,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: more2grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                defaultFormField(
                  controller: emailController,
                  hint: 'Email',
                  prefix: Icons.email,
                  type: TextInputType.emailAddress,
                  validate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email must not be empty";
                    } else if (!isValidEmail(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                defaultFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  hint: 'Password',
                  prefix: Icons.lock,
                  suffix: Icons.remove_red_eye,
                  isPassword: true,
                  validate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Password must not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.015),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Forgot_Password()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: yellow,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          buildCircle('Customer'),
                          SizedBox(width: 8),
                          Text('Customer', style: TextStyle(fontSize: screenWidth * 0.035)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          buildCircle('Shopkeeper'),
                          SizedBox(width: 8),
                          Text('Shopkeeper', style: TextStyle(fontSize: screenWidth * 0.035)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          buildCircle('Technical'),
                          SizedBox(width: 8),
                          Text('Technical', style: TextStyle(fontSize: screenWidth * 0.035)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                defultButton(
                  text: 'Login',
                  backgroundColor: yellow,
                  borderColor: yellow,
                  textColor: Colors.white,
                  function: () {
                    if (formKey.currentState?.validate() ?? false) {
                      if (selectedAccount != null) {
                        if (selectedAccount == 'Customer') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home_Layout()),
                          );
                        } else if (selectedAccount == 'Shopkeeper') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home_Layout_Shopkeeper()),
                          );
                        }
                        else if (selectedAccount == 'Technical') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home_Layout_Technical()),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select an account type."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.(com|net|org)$",
  );
  return emailRegex.hasMatch(email);
}
