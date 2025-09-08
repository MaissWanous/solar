import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/controllers/ProfileController.dart';

const Color yellow = Color(0xFFFFBF00);
const Color off_white = Color(0xFFFDF7E8);

class Profile_Customer extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          final user = controller.profile.value;
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: yellow,
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    '${user.fname} ${user.lname ?? ''}',
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
                        Flexible(
                          child: Text(
                            user.phone ?? 'No phone',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
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
                        Flexible(
                          child: Text(
                            (user.country != null && user.country!.isNotEmpty)
                                ? user.country!
                                : 'No country',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
