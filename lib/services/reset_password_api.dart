import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/models/reset_password_model.dart';
import 'package:udemy_flutter/token.dart';

class ResetPasswordApi {
  Future<ResetPasswordResponse> resetPassword({
    required String oldPassword,
    required String newPassword,
   }) async {
    final url = Uri.parse('http://192.168.1.109:4000/reset-Mypassword');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token.apiToken}',
    };

    final body = jsonEncode({
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return ResetPasswordResponse.fromJson(jsonDecode(response.body));
    } else {
       throw Exception('Failed to change password');
    }
  }
}
