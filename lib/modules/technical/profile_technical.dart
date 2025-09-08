import 'package:flutter/material.dart';

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);

class Profile_Technical extends StatefulWidget {
  final String fullName;
  final String phone;
  final String country;
  final String profilePic;

  const Profile_Technical({
    Key? key,
    required this.fullName,
    required this.phone,
    required this.country,
    required this.profilePic,
  }) : super(key: key);

  @override
  State<Profile_Technical> createState() => _Profile_TechnicalState();
}

class _Profile_TechnicalState extends State<Profile_Technical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: Text(
            widget.fullName,
            style: TextStyle(
              color: yellow,
              fontFamily: 'Aclonica',
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: yellow,
                  backgroundImage: widget.profilePic == 'assets/images/sample_avatar.png'
                      ? null
                      : AssetImage(widget.profilePic),
                ),
                SizedBox(width: 20.0),
                Text(
                  widget.fullName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 55.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: off_white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.phone,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        widget.phone,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: off_white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        widget.country,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
