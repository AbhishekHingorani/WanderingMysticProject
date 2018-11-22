import 'package:flutter/material.dart';

class Address{
  final int id;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  Address({
    @required this.id,
    @required this.addressLine1,
    @required this.addressLine2,
    @required this.city,
    @required this.state,
    @required this.country,
    @required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      addressLine1: json["line1"],
      addressLine2: json["line2"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      zipCode: json["zip"]
    );
  }
}