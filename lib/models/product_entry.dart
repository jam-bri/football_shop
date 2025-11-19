// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    String description;
    String category;
    String thumbnail;
    bool isFeatured;
    int stock;
    double rating;
    int userId;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.category,
        required this.thumbnail,
        required this.isFeatured,
        required this.stock,
        required this.rating,
        required this.userId,
    });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"].toString(),
        name: json["name"] ?? 'null',
        price: (json["price"] is int)
            ? json["price"]
            : int.tryParse(json["price"].toString()) ?? 0,
        description: json["description"] ?? 'null',
        category: json["category"] ?? 'null',
        thumbnail: json["thumbnail"] ?? 'null',
        isFeatured: json["is_featured"] ?? false,
        stock: (json["stock"] is int)
            ? json["stock"]
            : int.tryParse(json["stock"].toString()) ?? 0,
        rating: (json["rating"] is double)
            ? json["rating"]
            : double.tryParse(json["rating"].toString()) ?? 0.0,
        userId: (json["user_id"] is int)
            ? json["user_id"]
            : int.tryParse(json["user_id"].toString()) ?? 0,
      );


    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "is_featured": isFeatured,
        "stock": stock,
        "rating": rating,
        "user_id": userId,
    };
}
