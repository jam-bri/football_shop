import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/productlist_form.dart';


class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 206, 14),
            ),
            child: Column(
              children: [
                Text(
                  'Crampons Etoiles',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Browse in the App!",
                ),
              ],
            ),
          ),
          ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          // Redirect to MyHomePage
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
           },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context)=>ProductFormPage(),
                ));
            },
          )
        ],
      ),
    );
  }
}