import 'package:get/get.dart';
import 'package:udemy_flutter/models/product_model.dart';
import 'package:udemy_flutter/services/api_service.dart';


class ProductController extends GetxController {
  var allProducts = <Product>[].obs;
  var isLoading = true.obs;

  final ProductApi _api = ProductApi();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final products = await _api.fetchAllProducts();
      allProducts.value = products;
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
