import 'package:flutter/material.dart';

import 'screens/auth/auth_screen.dart';
import 'screens/auth/fake_google_signin_screen.dart';
import 'screens/details/place_details_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/shell/shell_screen.dart';
import 'screens/splash/landing_screen.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alimama',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: LandingScreen.routeName,
      routes: {
        LandingScreen.routeName: (_) => const LandingScreen(),
        AuthScreen.routeName: (_) => const AuthScreen(),
        FakeGoogleSignInScreen.routeName: (_) => const FakeGoogleSignInScreen(),
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
        ShellScreen.routeName: (_) => const ShellScreen(),
        PlaceDetailsScreen.routeName: (_) => const PlaceDetailsScreen(),
      },
    );
  }
}
