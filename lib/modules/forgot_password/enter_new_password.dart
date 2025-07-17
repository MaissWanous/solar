import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/login/Login.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Enter_New_Psssword extends StatelessWidget {
  final Color yellow = Color(0xFFFFBF00);
  final Color more2grey = Color(0xFFA39F9F);
  final Color moregrey = Color(0xFFB3B3B3);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 400;

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
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 16.0 : 20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: isSmall ? 10.0 : 0),
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
                    SizedBox(height: isSmall ? 20.0 : 25.0),
                    defaultFormField(
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm password must not empty";
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
                        builder: (context) => Login(),
                      ),
                    );
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
