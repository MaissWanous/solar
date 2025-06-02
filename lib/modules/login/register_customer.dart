import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Register_customer extends StatelessWidget {

  final Color yellow = Color(0xFFFFBF00);
  final Color more2grey = Color(0xFFA39F9F);
  final Color moregrey = Color(0xFFB3B3B3);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
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
                        width: 200,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Aclonica',
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: 'Register Account To '),
                              TextSpan(text: 'Solar Energy', style: TextStyle(color: yellow)),
                            ]
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'Please complete the registration steps to continue',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: more2grey
                        ),
                      ),
                      SizedBox(height: 30.0),
                      defaultFormField(
                          controller: TextEditingController(),
                          type: TextInputType.name,
                          validate:  (String? value) {
                            if (value == null || value.isEmpty) {
                              return "First name must not empty";
                            }
                            return null;
                          },
                          hint: 'First name',
                          prefix: Icons.account_circle,
                      ),
                      SizedBox(height: 25.0),
                      defaultFormField(
                        controller: TextEditingController(),
                        type: TextInputType.name,
                        validate:  (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Last name must not empty";
                          }
                          return null;
                        },
                        hint: 'Last name',
                        prefix: Icons.account_circle,
                      ),
                      SizedBox(height: 25.0),
                      defaultFormField(
                        controller: TextEditingController(),
                        type: TextInputType.number,
                        validate:  (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number must not empty";
                          }
                          return null;
                        },
                        hint: 'Phone number',
                        prefix: Icons.numbers,
                      ),
                      SizedBox(height: 25.0),
                      defaultFormField(
                        controller: TextEditingController(),
                        type: TextInputType.number,
                        validate:  (String? value) {
                          if (value == null || value.isEmpty) {
                            return "location must not empty";
                          }
                          return null;
                        },
                        hint: 'Location',
                        prefix: Icons.area_chart,
                      ),
                    ],
                  ),
                ),
              ),
          defultButton(
            text: 'Register',
            function: () {
          if (formKey.currentState?.validate() ?? false) {
            //TODOOOOOOOOOOOOOO
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

