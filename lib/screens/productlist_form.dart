import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Product Form')),
        backgroundColor: Color.fromARGB(255, 243, 231, 155),
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // === Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Item Name",
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _name = value),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Name cannot be empty!" : null,
                ),
              ),

              // === Price ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Item Price",
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) =>
                      setState(() => _price = int.tryParse(value) ?? 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Price cannot be empty!";
                    }
                    final number = int.tryParse(value);
                    if (number == null) return "Price must be a number!";
                    if (number <= 0) return "Price must be positive!";
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Item Description",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _description = value),
                  validator: (value) => value == null || value.isEmpty
                      ? "Description cannot be empty!"
                      : null,
                ),
              ),

              // === Thumbnail ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Image URL",
                    labelText: "Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _thumbnail = value),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Thumbnail URL required!" : null,
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category.isEmpty ? null : _category,
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat[0].toUpperCase() + cat.substring(1)),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _category = value!),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Please select a category!" : null,
                ),
              ),

              // === Is Featured ===
              SwitchListTile(
                title: const Text("Featured Item"),
                value: _isFeatured,
                onChanged: (value) => setState(() => _isFeatured = value),
              ),

              // === Stock ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Stock Quantity",
                    labelText: "Stock",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) =>
                      setState(() => _stock = int.tryParse(value) ?? 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Stock cannot be empty!";
                    final number = int.tryParse(value);
                    if (number == null) return "Stock must be a number!";
                    if (number <= 0) return "Stock must be positive!";
                    return null;
                  },
                ),
              ),

              // === Rating ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Rating (0.0 - 5.0)",
                    labelText: "Rating",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) =>
                      setState(() => _rating = double.tryParse(value) ?? 0.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Rating cannot be empty!";
                    }
                    final number = double.tryParse(value);
                    if (number == null) return "Rating must be a number!";
                    if (number < 0) return "Rating must be positive!";
                    if (number > 5) return "Maximum rating is 5!";
                    return null;
                  },
                ),
              ),

              // === Save Button ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 235, 206, 14),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Product saved successfully!"),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Name: $_name"),
                                Text("Description: $_description"),
                                Text("Category: $_category"),
                                Text("Thumbnail: $_thumbnail"),
                                Text("Price: $_price"),
                                Text("Stock: $_stock"),
                                Text("Rating: $_rating"),
                                Text("Featured: ${_isFeatured ? "Yes" : "No"}"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
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
