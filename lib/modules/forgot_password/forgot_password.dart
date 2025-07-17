import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/forgot_password/enter_verification_code.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Forgot_Password extends StatelessWidget {
  final Color yellow = Color(0xFFFFBF00);
  final Color more2grey = Color(0xFFA39F9F);

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: screenWidth * 0.08,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot password',
                      style: TextStyle(
                        fontFamily: 'Aclonica',
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Container(
                      width: screenWidth * 0.75,
                      child: Text(
                        'Select which contact details should we use to reset your password.',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: more2grey,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "First name must not be empty";
                        } else if (!isValidEmail(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      hint: 'Email',
                      prefix: Icons.email,
                    ),
                  ],
                ),
              ),
              defultButton(
                text: 'Continue',
                function: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Enter_Verification_Code(),
                      ),
                    );
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
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  return emailRegex.hasMatch(email);
}
