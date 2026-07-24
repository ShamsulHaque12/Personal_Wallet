import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:personal_wallet/auth_screens/log_in_screen/views/log_in_screen.dart';
import 'package:personal_wallet/auth_screens/online_registration/views/online_registration_screen.dart';
import 'package:personal_wallet/auth_screens/sign_up_screen/views/sign_up_screen.dart';
import 'package:personal_wallet/features/home_screen/views/home_screen.dart';
import 'package:personal_wallet/features/onboarding_screen/views/onboarding_screen.dart';
import 'package:personal_wallet/features/splash_screen/views/splash_screen.dart';
import 'package:personal_wallet/features/edit_profile/screen/edit_profile_screen.dart';
import 'package:personal_wallet/features/help_center/views/help_center_screen.dart';
import 'package:personal_wallet/features/navigation_bar/views/navigation_bar_view.dart';
import 'package:personal_wallet/features/profile_screen/screen/profile_screen.dart';
import 'package:personal_wallet/features/security/views/security_screen.dart';
import 'package:personal_wallet/features/settings/views/settings_screen.dart';
import 'package:personal_wallet/route/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.logInScreen, page: () => LogInScreen()),
    GetPage(
      name: AppRoutes.onlineRegistrationScreen,
      page: () => OnlineRegistrationScreen(),
    ),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.navigationBar, page: () => NavigationBarView()),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.profileScreen, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.editProfile, page: () => EditProfileScreen()),
    GetPage(name: AppRoutes.securityScreen, page: () => SecurityScreen()),
    GetPage(name: AppRoutes.settingsScreen, page: () => SettingsScreen()),
    GetPage(name: AppRoutes.helpCenter, page: () => HelpCenterScreen()),
  ];
}

    