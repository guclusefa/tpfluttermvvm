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

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
