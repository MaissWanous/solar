import 'package:get/get.dart';
import 'package:udemy_flutter/models/edit_model.dart';
import 'package:udemy_flutter/token.dart';

class EditApi extends GetConnect {


  Future<EditModel?> fetchProfile() async {
    final response = await get(
      'http://192.168.1.109:4000/profile',
      headers: {
        'Authorization': 'Bearer ${Token.apiToken}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200 && response.body != null) {
      return EditModel.fromJson(response.body['user']);
    } else {
      return null;
    }
  }

  Future<bool> updateName(String fname) async {
    final response = await put(
      'http://192.168.1.109:4000/profile',
      {'Fname': fname},
      headers: {
        'Authorization': 'Bearer ${Token.apiToken}',
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> updatePhone(String phone) async {
    final response = await put(
      'http://192.168.1.109:4000/profile',
      {'phone': phone},
      headers: {
        'Authorization': 'Bearer ${Token.apiToken}',
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> updateProfile(Map<String, String> data) async {
    final response = await put(
      'http://192.168.1.109:4000/profile',
      data,
      headers: {
        'Authorization': 'Bearer ${Token.apiToken}',
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 200;
  }
}
