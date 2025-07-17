import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Register_for_shopkeeper2 extends StatelessWidget {
  final Color yellow = Color(0xFFFFBF00);
  final Color more2grey = Color(0xFFA39F9F);

  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopNumberController = TextEditingController();
  final TextEditingController shopLocationController = TextEditingController();
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
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Aclonica',
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Register Account\n',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
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
                            SizedBox(height: 30.0),
                            Text(
                              'Please complete the registration steps to continue',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: more2grey,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            defaultFormField(
                              controller: shopNameController,
                              type: TextInputType.name,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Shop name must not be empty";
                                }
                                return null;
                              },
                              hint: 'Shop name',
                              prefix: Icons.store,
                            ),
                            SizedBox(height: 25.0),
                            defaultFormField(
                              controller: shopNumberController,
                              type: TextInputType.number,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Shop number must not be empty";
                                }
                                return null;
                              },
                              hint: 'Shop number',
                              prefix: Icons.phone,
                            ),
                            SizedBox(height: 25.0),
                            defaultFormField(
                              controller: shopLocationController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Shop location must not be empty";
                                }
                                return null;
                              },
                              hint: 'Shop location',
                              prefix: Icons.location_on_outlined,
                            ),
                          ],
                        ),
                      ),
                      defultButton(
                        text: 'Register',
                        function: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home_Layout_Shopkeeper(),
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
          ),
        ),
      ),
    );
  }
}
