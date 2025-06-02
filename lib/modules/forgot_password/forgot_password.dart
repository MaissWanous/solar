import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/forgot_password/enter_verification_code.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Forgot_Password extends StatelessWidget {

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
        padding: const EdgeInsets.all(20.0),
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
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 35.0),
                    Container(
                      width: 258,
                      child: Text(
                        'Select which contact details should we use to reset your password.',
                         style: TextStyle(
                             fontSize: 14.0,
                             color: more2grey,
                         ),
                      ),
                    ),
                    SizedBox(height: 35.0),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value){
                          if (value == null || value.isEmpty) {
                            return "First name must not empty";
                          }
                          else if (!isValidEmail(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        hint: 'Email',
                        prefix: Icons.email
                    ),
                  ],
                ),
              ),
              defultButton(
                  text: 'Continue',
                  function: (){
                    if(formKey.currentState?.validate() ?? false)
                      {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context)=>Enter_Verification_Code()
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


bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.com",
  );
  return emailRegex.hasMatch(email);
}