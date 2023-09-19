class AppRoutes {
  static const initial = '/loginPage';
  static const forgotPassword = 'forgot_password';

  //User routes: prefix user
  static const userHome = '/home';
  static const userRequests = '/requests';
  static const userProfile = '/profile';

  //Super admin routes: prefix superAdmin
  static const superAdminAdminsList = '/admins_list';
  static const userDetails = 'details/:userId';
  static const queueDetails = 'queue_details/:userId';
}
