import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../view_models/product_view_model.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product?.title ?? '');
    _priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
    _imageController = TextEditingController(text: widget.product?.image ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id ?? 0, // l'API génère l'ID si 0
        title: _titleController.text,
        price: double.parse(_priceController.text),
        image: _imageController.text,
      );

      final vm = Provider.of<ProductViewModel>(context, listen: false);
      if (widget.product == null) {
        vm.addProduct(product);
      } else {
        vm.updateProduct(product);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Modifier" : "Ajouter")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Titre"),
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Prix"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: "URL image"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text(isEditing ? "Mettre à jour" : "Créer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
