import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _loading = false;

  List<Product> get products => _products;
  bool get loading => _loading;

  Future<void> fetchProducts() async {
    setLoading(true);
    _products = await _apiService.fetchProducts();
    setLoading(false);
  }

  Future<void> addProduct(Product product) async {
    setLoading(true);
    final newProduct = await _apiService.addProduct(product);
    _products.add(newProduct);
    setLoading(false);
  }

  Future<void> updateProduct(Product product) async {
    setLoading(true);
    final updated = await _apiService.updateProduct(product);
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = updated;
    }
    setLoading(false);
  }

  Future<void> deleteProduct(int id) async {
    setLoading(true);
    await _apiService.deleteProduct(id);
    _products.removeWhere((p) => p.id == id);
    setLoading(false);
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
