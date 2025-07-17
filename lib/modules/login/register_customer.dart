import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Register_customer extends StatelessWidget {
  final Color yellow = const Color(0xFFFFBF00);
  final Color more2grey = const Color(0xFFA39F9F);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
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
                            width: isSmallScreen ? double.infinity : 400,
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'Aclonica',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Register Account\n',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const TextSpan(
                                    text: 'To ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Solar Energy',
                                    style: TextStyle(color: yellow),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Text(
                            'Please complete the registration steps to continue',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: more2grey,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          defaultFormField(
                            controller: firstNameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "First name must not be empty";
                              }
                              return null;
                            },
                            hint: 'First name',
                            prefix: Icons.account_circle,
                          ),
                          const SizedBox(height: 25.0),
                          defaultFormField(
                            controller: lastNameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Last name must not be empty";
                              }
                              return null;
                            },
                            hint: 'Last name',
                            prefix: Icons.account_circle,
                          ),
                          const SizedBox(height: 25.0),
                          defaultFormField(
                            controller: phoneNumberController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Phone number must not be empty";
                              }
                              return null;
                            },
                            hint: 'Phone number',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(height: 25.0),
                          defaultFormField(
                            controller: locationController,
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Location must not be empty";
                              }
                              return null;
                            },
                            hint: 'Location',
                            prefix: Icons.location_on,
                          ),
                        ],
                      ),
                    ),
                  ),
                  defultButton(
                    text: 'Register',
                    function: () {
                      if (formKey.currentState?.validate() ?? false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home_Layout(),
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
          );
        },
      ),
    );
  }
}
