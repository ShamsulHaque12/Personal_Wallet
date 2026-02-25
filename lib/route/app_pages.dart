import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:personal_wallet/auth_screens/log_in_screen/views/log_in_screen.dart';
import 'package:personal_wallet/features/onboarding_screen/views/onboarding_screen.dart';
import 'package:personal_wallet/features/splash_screen/views/splash_screen.dart';
import 'package:personal_wallet/route/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboardingScreen,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.logInScreen,
      page: () => LogInScreen(),
    ),
  ];
}