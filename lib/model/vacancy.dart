import 'dart:convert';

import 'package:flutter/foundation.dart';

class Vacancy {
  static String magangType = 'Magang';
  static String kerjaType = 'Kerja';
  static List<String> listType = [magangType, kerjaType];

  final String id;
  final String name;
  final DateTime postedAt;
  final String description;
  final List<String> requirement;
  final int salary;
  final String type;
  final String restaurantPhoto;
  final String ownerId;

  Vacancy({
    required this.id,
    required this.name,
    required this.postedAt,
    required this.description,
    required this.requirement,
    required this.salary,
    required this.type,
    required this.restaurantPhoto,
    required this.ownerId,
  });

  Vacancy copyWith({
    String? id,
    String? name,
    DateTime? postedAt,
    String? description,
    List<String>? requirement,
    int? salary,
    String? type,
    String? restaurantPhoto,
    String? ownerId,
  }) {
    return Vacancy(
      id: id ?? this.id,
      name: name ?? this.name,
      postedAt: postedAt ?? this.postedAt,
      description: description ?? this.description,
      requirement: requirement ?? this.requirement,
      salary: salary ?? this.salary,
      type: type ?? this.type,
      restaurantPhoto: restaurantPhoto ?? this.restaurantPhoto,
      ownerId: ownerId ?? this.ownerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'postedAt': postedAt.millisecondsSinceEpoch,
      'description': description,
      'requirement': requirement,
      'salary': salary,
      'type': type,
      'restaurantPhoto': restaurantPhoto,
      'ownerId': ownerId,
    };
  }

  factory Vacancy.fromMap(Map<String, dynamic> map) {
    return Vacancy(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      postedAt: DateTime.fromMillisecondsSinceEpoch(map['postedAt']),
      description: map['description'] ?? '',
      requirement: List<String>.from(map['requirement']),
      salary: map['salary']?.toInt() ?? 0,
      type: map['type'] ?? '',
      restaurantPhoto: map['restaurantPhoto'] ?? '',
      ownerId: map['ownerId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Vacancy.fromJson(String source) =>
      Vacancy.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vacancy(id: $id, name: $name, postedAt: $postedAt, description: $description, requirement: $requirement, salary: $salary, type: $type, restaurantPhoto: $restaurantPhoto, ownerId: $ownerId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vacancy &&
        other.id == id &&
        other.name == name &&
        other.postedAt == postedAt &&
        other.description == description &&
        listEquals(other.requirement, requirement) &&
        other.salary == salary &&
        other.type == type &&
        other.restaurantPhoto == restaurantPhoto &&
        other.ownerId == ownerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        postedAt.hashCode ^
        description.hashCode ^
        requirement.hashCode ^
        salary.hashCode ^
        type.hashCode ^
        restaurantPhoto.hashCode ^
        ownerId.hashCode;
  }
}
