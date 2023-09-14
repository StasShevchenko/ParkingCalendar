class RegisterUserDto {
  final String firstName;
  final String secondName;
  final String email;
  final bool isStaff;
  final bool isQueueUser;

  RegisterUserDto(
      {required this.firstName,
      required this.secondName,
      required this.email,
      required this.isStaff,
      required this.isQueueUser});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'is_staff': isStaff,
      'is_queue_user': isQueueUser
    };
  }
}
