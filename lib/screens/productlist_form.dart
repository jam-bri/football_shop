import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_shop/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "";
  bool _isFeatured = false;
  int _stock = 0;
  double _rating = 0.0;

  final List<String> _categories = [
    'cleats & boots',
    'jerseys & apparel',
    'ball',
    'accessories',
    'art prints',
    'limited editions',
  ];

  Widget buildField({
    required String label,
    required Widget field,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: field,
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      drawer: const LeftDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF0D1B2A)),
        title: const Text(
          "Add New Product",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF0D1B2A),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            children: [

              buildField(
                label: "Name",
                field: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Product Name",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => setState(() => _name = value),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Name cannot be empty!" : null,
                ),
              ),

              buildField(
                label: "Price",
                field: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) =>
                      setState(() => _price = int.tryParse(value) ?? 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Price cannot be empty!";
                    final num = int.tryParse(value);
                    if (num == null) return "Price must be a number!";
                    if (num <= 0) return "Price must be positive!";
                    return null;
                  },
                ),
              ),

              buildField(
                label: "Description",
                field: TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => setState(() => _description = value),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Description cannot be empty!" : null,
                ),
              ),

              buildField(
                label: "Thumbnail",
                field: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Thumbnail URL",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => setState(() => _thumbnail = value),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Thumbnail URL required!" : null,
                ),
              ),
              buildField(
                label: "Category",
                field: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: InputBorder.none,
                  ),
                  initialValue: _category.isEmpty ? null : _category,
                  items: _categories
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e[0].toUpperCase() + e.substring(1),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _category = value!),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Please select a category!" : null,
                ),
              ),

              buildField(
                label: "Featured",
                field: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "Featured Product",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  value: _isFeatured,
                  onChanged: (value) => setState(() => _isFeatured = value),
                ),
              ),

              buildField(
                label: "Stock",
                field: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Stock Quantity",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) =>
                      setState(() => _stock = int.tryParse(value) ?? 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Stock cannot be empty!";
                    final num = int.tryParse(value);
                    if (num == null) return "Stock must be a number!";
                    if (num <= 0) return "Stock must be positive!";
                    return null;
                  },
                ),
              ),

              buildField(
                label: "Rating",
                field: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Rating (0 - 10)",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) =>
                      setState(() => _rating = double.tryParse(value) ?? 0.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Rating cannot be empty!";
                    final num = double.tryParse(value);
                    if (num == null) return "Rating must be a number!";
                    if (num < 0) return "Min rating is 0";
                    if (num > 10) return "Max rating is 10";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE4B100),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        "http://localhost:8000/create-flutter/",
                        jsonEncode({
                          "name": _name,
                          "description": _description,
                          "category": _category,
                          "thumbnail": _thumbnail,
                          "price": _price,
                          "stock": _stock,
                          "rating": _rating,
                          "is_featured": _isFeatured,
                        }),
                      );

                      if (!context.mounted) return;

                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Product successfully saved!")),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MyHomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Something went wrong, please try again.")),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
