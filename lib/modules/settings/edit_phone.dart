import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:udemy_flutter/controllers/edit_controller.dart';
import 'package:udemy_flutter/controllers/ProfileController.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class Edit_Phone extends StatefulWidget {
  final String token;

  Edit_Phone({required this.token});

  @override
  State<Edit_Phone> createState() => _Edit_PhoneState();
}

const Color yellow = Color(0xFFFFBF00);
const Color more_gray = Color(0xFFB3B3B3);

class _Edit_PhoneState extends State<Edit_Phone> {
  late EditController controller;
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    controller = EditController(widget.token);
    controller.phoneController.text = profileController.profile.value.phone ?? '';
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
              defaultFormField(
                controller: controller.phoneController,
                hint: 'Phone',
                prefix: Icons.phone,
                type: TextInputType.number,
                validate: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Phone must not be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 60.0),
              Center(
                child: SizedBox(
                  width: buttonWidth,
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                      if (controller.formKey.currentState!.validate()) {
                        bool success = await controller.updatePhone(controller.phoneController.text);
                        if (success) {
                          await profileController.fetchProfile();
                          Get.back();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to update phone")),
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
