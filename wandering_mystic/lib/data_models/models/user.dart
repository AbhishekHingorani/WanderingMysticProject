import 'package:flutter/material.dart';

class User{
  final String id;
  final String name;
  final String email;
  final String phoneNo;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phoneNo,
    @required this.addressLine1,
    @required this.addressLine2,
    @required this.city,
    @required this.state,
    @required this.country,
    @required this.zipCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phoneNo: json["phoneNo"],
      addressLine1: json["addressLine1"],
      addressLine2: json["addressLine2"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      zipCode: json["zipCode"]
    );
  }
}