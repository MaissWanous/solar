import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/settings/change_password.dart';
import 'package:udemy_flutter/modules/profile_customer/profile_customer.dart';
import 'package:udemy_flutter/modules/settings/edit_email.dart';
import 'package:udemy_flutter/modules/settings/edit_name.dart';
import 'package:udemy_flutter/modules/settings/edit_phone.dart';

class Settings_Customer extends StatefulWidget {

  @override
  State<Settings_Customer> createState() => _Settings_CustomerState();
}

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);
const Color gray = Color(0xFFF2F2F2);

class _Settings_CustomerState extends State<Settings_Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Settings',
              style: TextStyle(
                color: yellow,
                fontSize: 20.0,
                fontFamily: 'Aclonica'
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Change_Password()));
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
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 25.0,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Password',
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Edit_Name(token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsImlhdCI6MTc1NzE2MTI1NCwiZXhwIjoxNzU3MTcyMDU0fQ.y2soz82zNRHVjVBbm-MmWVhinOvt3IaeKW9ekebf3Cw',)));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 25.0,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Name',
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Edit_Phone(token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsImlhdCI6MTc1NzE2MTI1NCwiZXhwIjoxNzU3MTcyMDU0fQ.y2soz82zNRHVjVBbm-MmWVhinOvt3IaeKW9ekebf3Cw',)));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.black,
                        size: 25.0,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Phone Number',
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
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                        size: 25.0,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
