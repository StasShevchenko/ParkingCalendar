import '../../utils/roles.dart';

class User {
  final String email;
  final int id;
  final List<Role> roles;

  User({required this.email, required this.id, required this.roles});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['id'],
      roles: [
        if (json['is_user'] ?? false) Role.User,
        if (json['is_staff'] ?? false) Role.SuperAdmin,
        if (json['is_staff'] ?? false) Role.SuperAdmin
      ],
    );
  }
}
