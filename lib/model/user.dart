import 'dart:convert';

class User {
  /// User for Restaurant Owner

  final String id;
  final String name;
  final String email;
  final String restaurantName;
  final String? image;
  final String role;

  static String restaurantOwnerRole = 'Restaurant Owner';

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.restaurantName,
    required this.role,
    this.image,
  });

  User copyWith(
      {String? id,
      String? name,
      String? email,
      String? restaurantName,
      String? image,
      String? role}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        restaurantName: restaurantName ?? this.restaurantName,
        image: image ?? this.image,
        role: role ?? this.role);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'restaurantName': restaurantName,
      'image': image,
      'role': role
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      email: map['email'] ?? '',
      restaurantName: map['restaurantName'] ?? '',
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, role: $role , email: $email, restaurantName: $restaurantName, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.restaurantName == restaurantName &&
        other.image == image &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        restaurantName.hashCode ^
        image.hashCode ^
        role.hashCode;
  }
}
