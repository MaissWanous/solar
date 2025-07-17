import 'package:flutter/material.dart';
import 'package:udemy_flutter/layout/home_layout_shopkeeper.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Add_Any_Thing extends StatefulWidget {
  @override
  State<Add_Any_Thing> createState() => _Add_Any_ThingState();
}

Color yellow = Color(0xFFFFBF00);
Color moregrey = Color(0xFFB3B3B3);
var AnythingCurrentController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _Add_Any_ThingState extends State<Add_Any_Thing> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: screenWidth * 0.6,
        leading: Row(
          children: [
            SizedBox(width: 3.0),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 35.0),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            SizedBox(width: 10.0),
            Text(
              'Add product',
              style: TextStyle(
                color: yellow,
                fontSize: screenWidth * 0.05,
                fontFamily: 'Aclonica',
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Any other qualities you want to add',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                defaultFormField(
                  controller: AnythingCurrentController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Write';
                    }
                    return null;
                  },
                  hint: 'Write',
                ),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: defultButton(
                    width: screenWidth * 0.3,
                    text: 'Next',
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home_Layout_Shopkeeper(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
