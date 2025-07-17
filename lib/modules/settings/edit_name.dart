import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/settings/settings.dart';
import 'package:udemy_flutter/modules/settings/settings_%20shopkeeper.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Edit_Name extends StatefulWidget {
  @override
  State<Edit_Name> createState() => _Edit_NameState();
}

const Color yellow = Color(0xFFFFBF00);
const Color more_gray = Color(0xFFB3B3B3);

var nameController = TextEditingController();
var formKey = GlobalKey<FormState>();

class _Edit_NameState extends State<Edit_Name> {
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
                controller: nameController,
                hint: 'Name',
                prefix: Icons.person,
                type: TextInputType.name,
                validate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Name must not be empty";
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
