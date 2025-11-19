import 'package:flutter/material.dart';
import 'package:football_shop/screens/productlist_form.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/product_list.dart';
import 'package:football_shop/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/screens/my_products.dart';


class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (item.name == "Add Product") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductFormPage(),
                ));
          }
          else if (item.name == "All Products") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductListPage(),
                ));
          }
          else if (item.name == "My Products") {
            if (request.loggedIn) {
              String username = request.jsonData['username'] ?? 'user';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProductsPage(username: username),
                  ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please log in first"),
                ),
              );
            }
            return;
          }
          else if (item.name == "Logout") {
            final response = await request.logout(
                    "http://localhost:8000/auth/logout/");
                String message = response["message"];
                if (context.mounted) {
                    if (response['status']) {
                        String uname = response["username"];
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$message See you again, $uname."),
                        ));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                    } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(message),
                            ),
                        );
                    }
                }
            }  
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("You have pressed the ${item.name} button!"),
                duration: const Duration(seconds: 1),
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
