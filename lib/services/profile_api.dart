import 'package:get/get.dart';
import 'package:udemy_flutter/models/profile_model.dart';
import 'package:udemy_flutter/token.dart';

class ProfileApi extends GetConnect {

  Future<ProfileModel?> fetchProfile() async {
    final response = await get(
      'http://192.168.1.109:4000/profile',
      headers: {
        'Authorization': 'Bearer ${Token.apiToken}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.body['user']);
    } else {
      return null;
    }
  }
}
