import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/profile_customer/profile_customer.dart';
import 'package:udemy_flutter/modules/settings/settings.dart';
import 'package:image_picker/image_picker.dart';

import '../login/Login.dart';



class Settings_Menu extends StatefulWidget {

  @override
  State<Settings_Menu> createState() => _Settings_MenuState();
}

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);
const Color gray = Color(0xFFF2F2F2);

class _Settings_MenuState extends State<Settings_Menu> {

  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 170,
        leading: Row(
          children: [
            SizedBox(width: 3.0,),
            IconButton(
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
            SizedBox(width: 10.0),
            Text(
              'My profile',
              style: TextStyle(
                color: yellow,
                fontSize: 20.0,
                fontFamily: 'Aclonica',
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: yellow,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,

                    ),
                    CircleAvatar(
                      radius: 17.5,
                      backgroundColor: yellow,
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 22.0,
                          ),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ibrahem Smith',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      'BesemSmith@gmail.com'
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50.0,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings_Customer()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 25.0,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 2,
                    color:gray,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile_Customer()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: Colors.black,
                        size: 25.0,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Help',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 2,
                    color:gray,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _showLogoutDialog(context); // ✅ مرر الـ context
              },

              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 25.0,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
          Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.all(20.0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Do you want to log out?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(height: 1, color: Colors.grey.shade300),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Log out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

