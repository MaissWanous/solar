import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/settings/settings.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Edit_Email extends StatefulWidget {
  @override
  State<Edit_Email> createState() => _Edit_EmailState();
}

const Color yellow = Color(0xFFFFBF00);
const Color more_gray = Color(0xFFB3B3B3);

var emailController = TextEditingController();
var formKey = GlobalKey<FormState>();

class _Edit_EmailState extends State<Edit_Email> {
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
              SizedBox(height: 60.0),
              Center(
                child: defultButton(
                  text: 'Save',
                  function: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Settings_Customer(),
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

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  return emailRegex.hasMatch(email);
}
