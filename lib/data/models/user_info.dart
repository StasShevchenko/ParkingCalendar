class UserInfo {
  final String email;
  final String firstName;
  final String secondName;
  final int id;
  final String startDate;
  final String endDate;
  final bool isSuperUser;
  final bool isStaff;
  final bool isActive;

  UserInfo(
      {required this.email,
      required this.id,
      required this.isStaff,
      required this.firstName,
      required this.secondName,
      required this.startDate,
      required this.endDate,
      required this.isSuperUser,
      this.isActive = true});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['firstName'],
      secondName: json['secondName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isSuperUser: json['is_superuser'],
      email: json['email'],
      id: json['id'],
      isStaff: json['is_staff'],
    );
  }
}
