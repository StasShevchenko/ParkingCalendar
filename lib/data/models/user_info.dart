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
  final bool isActive;

  UserInfo(
      {required this.email,
      required this.id,
      this.isStaff = false,
      required this.firstName,
      required this.secondName,
      this.startDate,
      this.endDate,
      this.lastActiveDate,
      this.isSuperUser = false,
      required this.isActive});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['firstName'],
      secondName: json['secondName'],
      startDate: json['start_active_time'] != null
          ? DateTime.parse(json['start_active_time'])
          : null,
      endDate: json['end_active_time'] != null
          ? DateTime.parse(json['end_active_time'])
          : null,
      lastActiveDate: json['last_active_period'] != null
          ? DateTime.parse(json['last_active_period'])
          : null,
      isActive: json['active'] ?? false,
      isSuperUser: json['is_superuser'] ?? false,
      email: json['email'],
      id: json['id'],
      isStaff: json['is_staff'] ?? false,
    );
  }
}
