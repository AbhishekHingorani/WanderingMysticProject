import 'package:flutter/material.dart';

class OrderItem {
  final String productId;
  final String productName;
  final double price;
  final String imageUrl;
  final int quantity;
  final String date;
  final String status;

  OrderItem ({
    @required this.productId,
    @required this.quantity,
    @required this.imageUrl,
    @required this.price,
    @required this.productName,
    @required this.date,
    @required this.status,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json["productId"],
      quantity: int.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
      productName: json['productName'],
      status: json['status'],
      date: json['date'],
    );
  }
}