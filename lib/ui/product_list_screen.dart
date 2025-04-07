import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_view_model.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Produits")),
      body: FutureBuilder(
        future: vm.fetchProducts(),
        builder: (context, snapshot) {
          return Consumer<ProductViewModel>(
            builder: (context, vm, child) {
              if (vm.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: vm.products.length,
                itemBuilder: (context, index) {
                  final product = vm.products[index];
                  return ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(product.title),
                    subtitle: Text("${product.price} €"),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ProductDetailScreen(product: product),
                          ),
                        ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
