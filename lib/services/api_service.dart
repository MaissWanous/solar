import 'package:http/http.dart' as http;
import 'package:udemy_flutter/models/product_model.dart';
import 'dart:convert';

class ProductApi {
  Future<List<Product>> fetchAllProducts() async {
    final url = Uri.parse('http://192.168.1.109:4000/getAllProduct');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> productsJson = jsonData['products'];
      return productsJson.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
