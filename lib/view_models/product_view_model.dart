import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _loading = false;
  bool get loading => _loading;

  // ✅ FAVORIS
  final Set<int> _favorites = {};
  Set<int> get favorites => _favorites;

  void toggleFavorite(int productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
    } else {
      _favorites.add(productId);
    }
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();
    try {
      _products = await _apiService.fetchProducts();
    } catch (e) {
      print('Erreur de récupération : $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int id) async {
    await _apiService.deleteProduct(id);
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _apiService.addProduct(product);
    _products.add(newProduct);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final updated = await _apiService.updateProduct(product);
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = updated;
      notifyListeners();
    }
  }
}
