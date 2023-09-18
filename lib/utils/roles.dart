// ignore_for_file: constant_identifier_names

enum Role {User, Admin, SuperAdmin}

extension RoleExtension on Role{
  String getName(){
    if(this == Role.User) return 'user';
    if(this == Role.Admin) return 'admin';
    if(this == Role.SuperAdmin) return 'super_admin';
    return 'user';
  }
}