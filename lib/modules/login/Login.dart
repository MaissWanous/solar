

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/forgot_password/forgot_password.dart';
import 'package:udemy_flutter/modules/home/home_all_customer.dart';
import 'package:udemy_flutter/modules/login/Register.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Login extends StatelessWidget {
  //const Login({super.key});
  final Color yellow = Color(0xFFFFBF00);
  final Color more2grey =Color(0xFFA39F9F);
  final Color moregrey=Color(0xFFB3B3B3);


  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.keyboard_arrow_left,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontFamily: 'Aclonica',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                Row(
                  children: [
                    Text(
                      'To ',
                      style: TextStyle(
                        fontFamily: 'Aclonica',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    Text(
                      'Solar Energy',
                      style: TextStyle(
                        fontFamily: 'Aclonica',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: yellow,

                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30.0,
                ),

                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: more2grey,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),

                defaultFormField(
                controller:emailController,
                hint: 'Email',
                prefix: Icons.email,
                type: TextInputType.emailAddress,
                  validate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email must not be empty";
                    }
                    else if (!isValidEmail(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },

                ),
                SizedBox(
                  height: 30.0,
                ),
                defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    hint: 'Password',
                    prefix:Icons.lock,
                    suffix: Icons.remove_red_eye,
                    isPassword: true,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                         return "Password must not empty";
                     }
                      return null;
                   },
                ) ,
                SizedBox(
                  height: 5.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)=>Forgot_Password(),
                            ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: yellow,
                          fontSize: 14.0,
                        ),
                      ),

                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                defultButton(
                  text: 'Login',
                  backgroundColor: yellow,
                  borderColor: yellow,
                  textColor: Colors.white,
                  function:(){
                    if(formKey.currentState?.validate() ?? false)
                      {


                      }
                    },
                ),
                SizedBox(
                  height: 30.0,
                ),
                defultButton(
                  text: 'Continue As Guest',
                  backgroundColor: Colors.white,
                  borderColor: yellow,
                  textColor: yellow,
                  function:(){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home_All_Customer()),
                          (Route<dynamic> route) => false,
                    );


                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>Register(),
                              ),
                          );
                        },
                        child: Text(
                          'Don\'t have an account?',
                          style:TextStyle(
                            color: Colors.black,
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9]+\.com",
  );
  return emailRegex.hasMatch(email);
}
