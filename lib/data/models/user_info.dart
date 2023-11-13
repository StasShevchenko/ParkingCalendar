import '../../utils/roles.dart';

class UserInfo {
  final String email;
  final String firstName;
  final String secondName;
  final int id;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? lastActiveDate;
  final bool isSuperUser;
  final bool isStaff;
  final bool isUser;
  final bool isActive;
  final String? avatar;
  final int? previousUserId;
  final int? nextUserId;

  UserInfo({
    required this.email,
    required this.id,
    this.isStaff = false,
    required this.firstName,
    required this.secondName,
    this.startDate,
    this.endDate,
    this.lastActiveDate,
    this.avatar,
    this.isSuperUser = false,
    required this.isUser,
    required this.isActive,
    this.previousUserId,
    this.nextUserId,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['firstName'],
      secondName: json['secondName'],
      startDate: json['start_active_time'] != null
          ? DateTime.parse(json['start_active_time'])
          : DateTime(2024),
      endDate: json['end_active_time'] != null
          ? DateTime.parse(json['end_active_time'])
          : null,
      lastActiveDate: json['last_active_period'] != null
          ? DateTime.parse(json['last_active_period'])
          : null,
      avatar: json['avatar'] != null
          ? 'https://back.parking-project.ru/static/${json['avatar'].trim()}'
          : null,
      isActive: json['active'] ?? false,
      isSuperUser: json['is_superuser'] ?? false,
      email: json['email'],
      isUser: json['in_queue'] ?? false,
      id: json['id'],
      isStaff: json['is_staff'] ?? false,
      previousUserId: json['previous_active'],
      nextUserId: json['next_active']
    );
  }

  String get userRolesString {
    List<Role> userRoles = [];
    if (isStaff) userRoles.add(Role.Admin);
    if (isSuperUser) userRoles.add(Role.SuperAdmin);
    if (isUser) userRoles.add(Role.User);
    String rolesString = '';
    for (int i = 0; i < userRoles.length; i++) {
      String suffix = i == userRoles.length - 1 ? ' ' : ', ';
      if (userRoles[i] == Role.User) {
        String stringRole = 'пользователь очереди$suffix';
        rolesString += stringRole;
      }
      if (userRoles[i] == Role.Admin && !userRoles.contains(Role.SuperAdmin)) {
        String stringRole = 'администратор$suffix';
        rolesString += stringRole;
      }
      if (userRoles[i] == Role.SuperAdmin) {
        String stringRole = 'старший администратор$suffix';
        rolesString += stringRole;
      }
    }
    return rolesString;
  }
}
