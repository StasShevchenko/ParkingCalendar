class User {
  final String email;
  final int id;
  final bool isStaff;

  User({required this.email, required this.id, required this.isStaff});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['id'],
      isStaff: json['is_staff'],
    );
  }
}
