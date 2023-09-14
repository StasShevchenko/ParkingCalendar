class AppRoutes {
  static const initial = '/loginPage';
  static const forgotPassword = 'forgot_password';

  //User routes: prefix user
  static const userHome = '/home';
  static const userRequests = '/requests';
  static const userProfile = '/profile';

  //Super admin routes: prefix superAdmin
  static const superAdminOffices = '/offices_list';
  static const superAdminAdminsList = '/admins_list';
  static const superAdminAdminsDetail = 'details/:userId';

  //Admin routes: prefix Admin
  static const adminHome = '/admin_home';
}
