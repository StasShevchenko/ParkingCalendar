import 'package:parking_project/models/offices.dart';

class Admin {
  final String? name;
  final Office office;

  Admin(this.name, this.office);
}

List<Admin> admins = [
  Admin("Юля", ofisi[0]),
  Admin("Олег", ofisi[1]),
  Admin("Катя", ofisi[2]),
  Admin("Вика", ofisi[3]),
];
