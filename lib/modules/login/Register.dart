import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/login/enter_verification_code_for_register.dart';
import 'package:udemy_flutter/modules/login/register_customer.dart';
import 'package:udemy_flutter/modules/login/register_for_shopkeeper_1.dart';
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
  var confirmpasswordController = TextEditingController();
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            size: screenWidth * 0.09,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                        width: screenWidth * 0.6,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Aclonica',
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: 'Register Account To '),
                              TextSpan(
                                text: 'Solar Energy',
                                style: TextStyle(color: yellow),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        'Hello there, register to continue',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: more2grey,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Email must not be empty";
                          } else if (!isValidEmail(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        hint: 'Email',
                        prefix: Icons.email,
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        hint: 'New Password',
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "New password must not be empty";
                          }
                          return null;
                        },
                        prefix: Icons.lock,
                        suffix: Icons.remove_red_eye,
                        isPassword: true,
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      defaultFormField(
                        controller: confirmpasswordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password must not be empty";
                          }
                          if (value != passwordController.text) {
                            return "Confirm password does not match";
                          }
                          return null;
                        },
                        hint: 'Confirm password',
                        prefix: Icons.check_circle,
                        isPassword: true,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildCircle('Customer'),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  'Customer',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.035,
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
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  'Shopkeeper',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                buildCircle('Technical'),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  'Technical',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.035,
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
                    if (selectedAccount == 'Customer') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Enter_Verification_Code_For_Register(selectedAccount: 'Customer'),
                        ),
                      );
                    } else if (selectedAccount == 'Shopkeeper') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Enter_Verification_Code_For_Register(selectedAccount: 'Shopkeeper'),
                        ),
                      );
                    } else if (selectedAccount == 'Technical') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Enter_Verification_Code_For_Register(selectedAccount: 'Technical'),
                        ),
                      );
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
                backgroundColor: yellow,
                borderColor: yellow,
                textColor: Colors.white,
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
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
