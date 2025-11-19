import 'package:flutter/material.dart';
import 'package:football_shop/models/product_entry.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_shop/screens/product_detail.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    final response = await request.get("http://localhost:8000/json/");
    List<ProductEntry> list = [];
    for (var item in response) {
      if (item != null) list.add(ProductEntry.fromJson(item));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Soft gray background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF0D1B2A)),
        title: const Text(
          "Crampons ⭐ Étoiles",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF0D1B2A), // Navy
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFFE4B100)));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No products available yet.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            );
          }

          List<ProductEntry> products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,            // 2 products per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 0.56,       // Taller product cards
            ),
            itemCount: products.length,
            itemBuilder: (_, index) {
              return ProductEntryCard(
                product: snapshot.data![index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(product: snapshot.data![index],),
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF0D1B2A),
                        content: Text(
                          "Opening ${products[index].name}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        duration: const Duration(milliseconds: 900),
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
