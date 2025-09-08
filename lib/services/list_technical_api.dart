import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/models/list_technical_model.dart';

class TechnicalApi {
  static Future<List<TechnicalUser>> fetchTechnicalUsers() async {
    final response = await http.get(Uri.parse('http://192.168.1.109:4000/technical'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> usersJson = data['user'];
      return usersJson.map((json) => TechnicalUser.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load technical users');
    }
  }
}
