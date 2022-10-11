import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class Coffe {
  const Coffe({
    required this.name,
    required this.coffee,
    required this.azucar,
    required this.stevia,
    required this.email,
  });

  Coffe.fromJson(Map<String, Object?> json)
      : this(
          azucar: json['azucar']! as int,
          name: json['name']! as String,
          email: json['email']! as String,
          stevia: json['stevia']! as int,
          coffee: json['coffee']! as int,
        );

  final String name;
  final int azucar;
  final int stevia;
  final String email;
  final int coffee;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'azucar': azucar,
      'email': email,
      'stevia': stevia,
      'coffee': coffee
    };
  }
}
