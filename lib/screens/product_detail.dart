import 'package:flutter/material.dart';
import 'package:football_shop/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFD4AF37);
    const navy = Color(0xFF0A1A2F);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: navy,
        foregroundColor: gold,
        elevation: 3,
      ),
      backgroundColor: const Color(0xFFF4F5F7),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ⭐ Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 260,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 48),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ⭐ Product name
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 6),

            // ⭐ Category
            Text(
              product.category,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 20),

            // ⭐ Price
            Text(
              "\$${product.price.toString()}",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
              ),
            ),

            const SizedBox(height: 16),

            // ⭐ Stock / Featured / Rating
            Row(
              children: [
                Text(
                  "Stock: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(product.stock.toString()),
                const SizedBox(width: 20),

                Text(
                  "Featured: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(product.isFeatured ? "Yes" : "No"),
                const SizedBox(width: 20),

                Text(
                  "Rating: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                Text(product.rating.toStringAsFixed(1)),
              ],
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 16),

            // ⭐ Description
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Color(0xFF2E2E2E),
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),

            // ⭐ Back button (HCI friendly)
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: navy,
                  elevation: 1,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: navy.withValues(alpha: 0.4)),
                  ),
                ),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back to list"),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
