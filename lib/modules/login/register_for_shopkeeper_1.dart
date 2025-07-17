import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout.dart';
import 'package:udemy_flutter/modules/login/register_for_shopkeeper_2.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Register_for_shopkeeper1 extends StatelessWidget {
  final Color yellow = const Color(0xFFFFBF00);
  final Color more2grey = const Color(0xFFA39F9F);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
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
                      const Spacer(),
                      defultButton(
                        text: 'Register',
                        function: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register_for_shopkeeper2(),
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
            ),
          );
        },
      ),
    );
  }
}
