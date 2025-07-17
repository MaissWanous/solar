import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/modules/profile_customer/profile_customer.dart';
import 'package:udemy_flutter/modules/settings/settings_%20shopkeeper.dart';
import '../login/Login.dart';

class Settings_Menu_Shopkeeper extends StatefulWidget {
  @override
  State<Settings_Menu_Shopkeeper> createState() =>
      _Settings_Menu_ShopkeeperState();
}

const Color yellow = Color(0xFFFFBF00);
const Color gray = Color(0xFFF2F2F2);

class _Settings_Menu_ShopkeeperState extends State<Settings_Menu_Shopkeeper> {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmall = screenWidth < 360;
    final bool isMedium = screenWidth >= 360 && screenWidth < 600;

    final double avatarRadius = isSmall ? 35 : isMedium ? 40 : 45;
    final double iconSize = isSmall ? 20 : isMedium ? 25 : 28;
    final double spacingHorizontal = isSmall ? 10 : isMedium ? 20 : 25;
    final double spacingVertical = isSmall ? 10 : isMedium ? 15 : 20;
    final double fontSizeTitle = isSmall ? 18 : isMedium ? 20 : 22;
    final double fontSizeOption = isSmall ? 12 : isMedium ? 14 : 16;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 170,
        leading: Row(
          children: [
            SizedBox(width: 3.0),
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
                fontSize: fontSizeTitle,
                fontFamily: 'Aclonica',
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: yellow,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                    ),
                    CircleAvatar(
                      radius: avatarRadius * 0.44,
                      backgroundColor: yellow,
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: avatarRadius * 0.55,
                          ),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spacingHorizontal),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ibrahem Smith',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSizeTitle,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spacingVertical * 0.3),
                      Text(
                        'BesemSmith@gmail.com',
                        style: TextStyle(
                          fontSize: fontSizeOption,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spacingVertical * 2.5),
            _buildMenuItem(
              context,
              icon: Icons.settings,
              text: 'Settings',
              iconSize: iconSize,
              fontSize: fontSizeOption,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Settings_Shopkeeper()));
              },
            ),
            _divider(),
            _buildMenuItem(
              context,
              icon: Icons.help_outline,
              text: 'Help',
              iconSize: iconSize,
              fontSize: fontSizeOption,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile_Customer()));
              },
            ),
            _divider(),
            _buildMenuItem(
              context,
              icon: Icons.logout,
              text: 'Log out',
              iconSize: iconSize,
              fontSize: fontSizeOption,
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String text,
        required double iconSize,
        required double fontSize,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: iconSize,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _divider() {
    return Container(
      height: 2,
      color: gray,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5),
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
                      Navigator.of(context).pop();
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
                      Navigator.of(context).pop();
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
