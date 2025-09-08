import 'package:flutter/material.dart';
import 'package:udemy_flutter/controllers/edit_controller.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/controllers/ProfileController.dart';

class Edit_Name extends StatefulWidget {
  final String token;

  Edit_Name({required this.token});

  @override
  State<Edit_Name> createState() => _EditNameState();
}

class _EditNameState extends State<Edit_Name> {
  late EditController controller;
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    controller = EditController(widget.token);
    controller.fnameController.text = profileController.profile.value.fname;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmall = screenWidth < 360;
    final bool isMedium = screenWidth >= 360 && screenWidth < 600;

    final double padding = isSmall ? 12 : isMedium ? 20 : 25;
    final double buttonWidth = screenWidth * 0.5;

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
            color: Colors.black,
            size: 35.0,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.fnameController,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "First name must not be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: buttonWidth,
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                      if (controller.formKey.currentState!.validate()) {
                        bool success = await controller
                            .updateName(controller.fnameController.text);
                        if (success) {
                           await profileController.fetchProfile();
                          Get.back();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to update profile"),
                            ),
                          );
                        }
                      }
                    },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Save'),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
