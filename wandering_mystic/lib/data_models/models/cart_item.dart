import 'package:flutter/material.dart';

class CartItem {
  final int productId;
  final String productName;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem ({
    @required this.productId,
    @required this.quantity,
    @required this.imageUrl,
    @required this.price,
    @required this.productName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json["id"],
      quantity: int.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
      productName: json['name'],
    );
  }
}