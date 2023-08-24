class UserInfo {
  final String email;
  final String firstName;
  final String secondName;
  final int id;
  final String? startDate;
  final String? endDate;
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
      this.isSuperUser = false,
      this.isActive = true});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['firstName'],
      secondName: json['secondName'],
      startDate: json['startDate'] ?? '24.08.2023',
      endDate: json['endDate'] ?? '25.08.2023',
      isSuperUser: json['is_superuser'] ?? false,
      email: json['email'],
      id: json['id'],
      isStaff: json['is_staff'] ?? false,
    );
  }
}
