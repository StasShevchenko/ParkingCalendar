import 'package:parking_project/data/models/offices.dart';

class Admin {
  final String? name;
  final Office office;
  Admin(this.name, this.office);
}

List<Admin> admins = [
  Admin("Юля", offices[0]),
  Admin("Олег", offices[1]),
  Admin("Катя", offices[2]),
  Admin("Вика", offices[3]),
  Admin("ДИМАНОИД", offices[4]),
];
