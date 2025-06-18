import 'package:flutter/foundation.dart';
import 'package:mini_sales_dash/data/models/product/product_model.dart';
import 'package:mini_sales_dash/data/repositories/product/product_repository.dart';


enum ProductState { initial, loading, loaded, error }

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  
  ProductState _state = ProductState.initial;
  List<Product> _products = [];
  String? _error;
  PriceFilter _selectedFilter = PriceFilter.all;

  ProductState get state => _state;
  List<Product> get products => _products;
  String? get error => _error;
  PriceFilter get selectedFilter => _selectedFilter;
  bool get isLoading => _state == ProductState.loading;

  Future<void> initialize() async {
    await loadProducts();
  }

  Future<void> loadProducts() async {
    _setState(ProductState.loading);
    
    try {
      final products = await _repository.getProducts(_selectedFilter);
      _products = products;
      _setState(ProductState.loaded);
    } catch (e) {
      _error = e.toString();
      _setState(ProductState.error);
    }
  }

  Future<void> changeFilter(PriceFilter filter) async {
    _selectedFilter = filter;
    await loadProducts();
  }

  Future<void> refresh() async {
    await loadProducts();
  }

  void _setState(ProductState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<Product?> getProductById(int id) async {
    try {
      return await _repository.getProductById(id);
    } catch (e) {
      _error = e.toString();
      _setState(ProductState.error);
      return null;
    }
  }
} 