import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_carousel_screen.dart';
import '../../features/auth/screens/auth_screen.dart';
import '../../features/auth/screens/verify_otp_screen.dart';
import '../../features/auth/screens/profile_setup_screen.dart';
import '../../features/auth/screens/permissions_screen.dart';
import '../../features/company/screens/company_selection_screen.dart';
import '../../features/company/screens/manual_submission_screen.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const auth = '/auth';
  static const verifyOtp = '/auth/verify-otp';
  static const profileSetup = '/onboarding/profile';
  static const companySelection = '/onboarding/company';
  static const manualCompanySubmission = '/onboarding/company/suggest';
  static const permissions = '/onboarding/permissions';
  static const dashboard = '/dashboard';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      final isAuthenticated = authState.token != null;
      final isOnboarded = authState.user?.onboardingCompleted ?? false;

      const publicRoutes = [AppRoutes.splash, AppRoutes.onboarding, AppRoutes.auth, AppRoutes.verifyOtp];
      const onboardingRoutes = [
        AppRoutes.profileSetup,
        AppRoutes.companySelection,
        AppRoutes.manualCompanySubmission,
        AppRoutes.permissions,
      ];

      final path = state.uri.path;

      if (!isAuthenticated && !publicRoutes.contains(path) && !onboardingRoutes.contains(path)) {
        return AppRoutes.auth;
      }
      if (isAuthenticated && !isOnboarded && !onboardingRoutes.contains(path)) {
        return AppRoutes.profileSetup;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: AppRoutes.onboarding, builder: (_, __) => const OnboardingCarouselScreen()),
      GoRoute(path: AppRoutes.auth, builder: (_, __) => const AuthScreen()),
      GoRoute(
        path: AppRoutes.verifyOtp,
        builder: (_, state) => VerifyOtpScreen(contact: state.extra as String? ?? ''),
      ),
      GoRoute(path: AppRoutes.profileSetup, builder: (_, __) => const ProfileSetupScreen()),
      GoRoute(path: AppRoutes.companySelection, builder: (_, __) => const CompanySelectionScreen()),
      GoRoute(path: AppRoutes.manualCompanySubmission, builder: (_, __) => const ManualSubmissionScreen()),
      GoRoute(path: AppRoutes.permissions, builder: (_, __) => const PermissionsScreen()),
      GoRoute(path: AppRoutes.dashboard, builder: (_, __) => const _DashboardPlaceholder()),
    ],
  );
});

class _DashboardPlaceholder extends StatelessWidget {
  const _DashboardPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Dashboard')));
  }
}
