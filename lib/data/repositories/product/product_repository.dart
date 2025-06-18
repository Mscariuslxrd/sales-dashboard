
import 'package:mini_sales_dash/data/models/product/product_model.dart';
import 'package:mini_sales_dash/services/api/product/product.dart';

enum PriceFilter {
  all,
  under100,
  between100and500,
  over500,
}

class ProductRepository {
  static final ProductRepository _instance = ProductRepository._internal();
  factory ProductRepository() => _instance;
  ProductRepository._internal();

  Future<List<Product>> getProducts([PriceFilter filter = PriceFilter.all]) async {
    try {
      final products = await ProductApi.fetchProducts();
      
      switch (filter) {
        case PriceFilter.under100:
          return products.where((product) => product.price < 100).toList();
        case PriceFilter.between100and500:
          return products.where((product) => 
            product.price >= 100 && product.price <= 500).toList();
        case PriceFilter.over500:
          return products.where((product) => product.price > 500).toList();
        case PriceFilter.all:
      return products;
      }
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      return await ProductApi.fetchProductById(id);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  String getFilterDisplayName(PriceFilter filter) {
    switch (filter) {
      case PriceFilter.all:
        return 'Все товары';
      case PriceFilter.under100:
        return 'До \$100';
      case PriceFilter.between100and500:
        return '\$100 - \$500';
      case PriceFilter.over500:
        return 'Свыше \$500';
    }
  }
} 