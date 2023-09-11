import '../../utils/roles.dart';

class User {
  final String email;
  final int id;
  final List<Role> roles;
  final String firstName;
  final String secondName;

  User(
      {required this.email,
      required this.firstName,
      required this.secondName,
      required this.id,
      required this.roles});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['id'],
      firstName: json['first_name'],
      secondName: json['second_name'],
      roles: [
        if (json['in_queue'] ?? false) Role.User,
        if (json['is_staff'] ?? false) Role.Admin,
        if (json['is_superuser'] ?? false) Role.SuperAdmin
      ],
    );
  }

  String get userRolesString {
    String rolesString = '';
    for (int i = 0; i < roles.length; i++) {
      String suffix = i == roles.length - 1 ? ' ' : ', ';
      if (roles[i] == Role.User) {
        String stringRole = 'пользователь очереди$suffix';
        rolesString += stringRole;
      }
      if (roles[i] == Role.Admin && !roles.contains(Role.SuperAdmin)) {
        String stringRole = 'администратор$suffix';
        rolesString += stringRole;
      }
      if (roles[i] == Role.SuperAdmin) {
        String stringRole = 'старший администратор$suffix';
        rolesString += stringRole;
      }
    }
    return rolesString;
  }
}
