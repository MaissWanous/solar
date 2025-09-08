import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/services/edit_api.dart';

class EditController extends GetxController {
  final EditApi api;
  var isLoading = false.obs;

  EditController(String token) : api = EditApi();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   final TextEditingController fnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

   Future<bool> updateName(String name) async {
    isLoading.value = true;
    bool success = await api.updateName(name);
    isLoading.value = false;
    return success;
  }

   Future<bool> updatePhone(String phone) async {
    isLoading.value = true;
    bool success = await api.updatePhone(phone);
    isLoading.value = false;
    return success;
  }

   Future<bool> updateProfile({String? name, String? phone}) async {
    isLoading.value = true;
    Map<String, String> data = {};
    if (name != null) data['Fname'] = name;
    if (phone != null) data['phone'] = phone;

    bool success = await api.updateProfile(data);
    isLoading.value = false;
    return success;
  }

  @override
  void onClose() {
    fnameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
