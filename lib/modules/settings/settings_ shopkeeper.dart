import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/settings/change_password.dart';
import 'package:udemy_flutter/modules/profile_customer/profile_customer.dart';
import 'package:udemy_flutter/modules/settings/edit_email.dart';
import 'package:udemy_flutter/modules/settings/edit_name.dart';
import 'package:udemy_flutter/modules/settings/edit_phone.dart';
import 'package:udemy_flutter/modules/settings/edit_shop_name.dart';
import 'package:udemy_flutter/modules/settings/edit_shop_number.dart';
import 'package:udemy_flutter/token.dart';

class Settings_Shopkeeper extends StatefulWidget {
  @override
  State<Settings_Shopkeeper> createState() => _Settings_ShopkeeperState();
}

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);
const Color gray = Color(0xFFF2F2F2);

class _Settings_ShopkeeperState extends State<Settings_Shopkeeper> {
  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required double iconSize,
    required double fontSize,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: iconSize,
            ),
            SizedBox(width: 8),
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isSmall = screenWidth < 360;
    final bool isMedium = screenWidth >= 360 && screenWidth < 600;

    final double iconSize = isSmall
        ? 20
        : isMedium
        ? 25
        : 28;
    final double fontSize = isSmall
        ? 12
        : isMedium
        ? 14
        : 16;
    final double horizontalPadding = isSmall
        ? 12
        : isMedium
        ? 20
        : 25;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 170,
        leading: Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Row(
            children: [
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
                'Settings',
                style: TextStyle(
                  color: yellow,
                  fontSize: 20.0,
                  fontFamily: 'Aclonica',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          _buildMenuItem(
            icon: Icons.lock_outline,
            text: 'Password',
            iconSize: iconSize,
            fontSize: fontSize,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Change_Password()));
            },
          ),
          _divider(),
          _buildMenuItem(
            icon: Icons.shopping_bag_outlined,
            text: 'Shop name',
            iconSize: iconSize,
            fontSize: fontSize,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Edit_Shop_Name()));
            },
          ),
          _divider(),
          _buildMenuItem(
            icon: Icons.person,
            text: 'Name',
            iconSize: iconSize,
            fontSize: fontSize,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Edit_Name(token: Token.apiToken)));
            },
          ),
          _divider(),
          _buildMenuItem(
            icon: Icons.phone,
            text: 'Phone Number',
            iconSize: iconSize,
            fontSize: fontSize,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Edit_Phone(token: Token.apiToken)));
            },
          ),
          _divider(),
          _buildMenuItem(
            icon: Icons.phone,
            text: 'Shop Number',
            iconSize: iconSize,
            fontSize: fontSize,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Edit_Shop_Number()));
            },
          ),
          _divider(),
          _buildMenuItem(
            icon: Icons.location_on_outlined,
            text: 'Shop location',
            iconSize: iconSize,
            fontSize: fontSize,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Edit_Shop_Name()));
            },
          ),
        ],
      ),
    );
  }
}
