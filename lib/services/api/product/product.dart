import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_sales_dash/constants/remote_constants.dart';
import 'package:mini_sales_dash/data/models/product/product_model.dart';

class ProductApi {
  
  void printBaseUrl() {
    String baseUrl = RemoteConstants.httpBaseUrl;
    print('Base URL: $baseUrl');
  }

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${RemoteConstants.httpBaseUrl}/products'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        
        return productsJson
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Product> fetchProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${RemoteConstants.httpBaseUrl}/products/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> productJson = json.decode(response.body);
        return Product.fromJson(productJson);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
