// 🎯 Fonctionnalités ajoutées :
// 1. Barre de recherche locale
// 2. Tri par prix (ascendant / descendant)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_view_model.dart';
import 'product_detail_screen.dart';
import 'product_form_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _searchQuery = '';
  bool _sortAsc = true;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Produits"),
        actions: [
          IconButton(
            icon: Icon(_sortAsc ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() => _sortAsc = !_sortAsc);
            },
            tooltip: "Trier par prix",
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un produit...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value.toLowerCase());
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: vm.fetchProducts(),
              builder: (context, snapshot) {
                return Consumer<ProductViewModel>(
                  builder: (context, vm, child) {
                    if (vm.loading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    var filteredProducts =
                        vm.products
                            .where(
                              (p) =>
                                  p.title.toLowerCase().contains(_searchQuery),
                            )
                            .toList();

                    filteredProducts.sort(
                      (a, b) =>
                          _sortAsc
                              ? a.price.compareTo(b.price)
                              : b.price.compareTo(a.price),
                    );

                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ListTile(
                          leading: Image.network(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.title),
                          subtitle: Text("${product.price} €"),
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          ProductDetailScreen(product: product),
                                ),
                              ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => ProductFormScreen(
                                            product: product,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await Provider.of<ProductViewModel>(
                                    context,
                                    listen: false,
                                  ).deleteProduct(product.id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductFormScreen()),
          );
        },
      ),
    );
  }
}
