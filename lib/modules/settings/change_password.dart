import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/settings/settings.dart';
import 'package:udemy_flutter/modules/settings/settings_%20shopkeeper.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Change_Password extends StatefulWidget {
  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

const Color yellow = Color(0xFFFFBF00);
const Color more_gray = Color(0xFFB3B3B3);

var oldPasswordController = TextEditingController();
var newPasswordController = TextEditingController();
var confirmPasswordController = TextEditingController();

var formKey = GlobalKey<FormState>();

class _Change_PasswordState extends State<Change_Password> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmall = screenWidth < 360;
    final bool isMedium = screenWidth >= 360 && screenWidth < 600;

    final double padding = isSmall
        ? 12
        : isMedium
        ? 20
        : 25;

    final double spacing = isSmall ? 20.0 : 25.0;
    final double largeSpacing = isSmall ? 40.0 : 60.0;
    final double buttonWidth = screenWidth * 0.5;

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
            color: Colors.black,
            size: 35.0,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              defaultFormField(
                controller: oldPasswordController,
                type: TextInputType.visiblePassword,
                hint: 'Old Password',
                validate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Old password must not be empty";
                  }
                  return null;
                },
                prefix: Icons.lock,
                suffix: Icons.remove_red_eye,
                isPassword: true,
              ),
              SizedBox(height: spacing),
              defaultFormField(
                controller: newPasswordController,
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
              SizedBox(height: spacing),
              defaultFormField(
                controller: confirmPasswordController,
                type: TextInputType.visiblePassword,
                validate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm password must not empty";
                  }
                  if (value != newPasswordController.text) {
                    return "Confirm password does not match";
                  }
                  return null;
                },
                hint: 'Confirm password',
                prefix: Icons.check_circle,
                isPassword: true,
              ),
              SizedBox(height: largeSpacing),
              Center(
                child: defultButton(
                  text: 'Save',
                  function: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Settings_Shopkeeper(),
                        ),
                      );
                    }
                  },
                  width: buttonWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
