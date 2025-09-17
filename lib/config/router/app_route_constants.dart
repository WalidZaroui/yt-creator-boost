import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_creator_boost/config/router/app_route.dart';

import '../../core/constants/app_constants.dart';
import '../../injection_container.dart';
import '../../presentation/bloc/auth/login/login_cubit.dart';
import '../../presentation/bloc/auth/signup/signup_cubit.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/onboarding_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import 'app_route_constants.dart';

class AppRouter {
  AppRouter(this._hasSeenOnboarding, this._isAuthenticated);

  final bool _hasSeenOnboarding;
  final bool _isAuthenticated;

  String get initialLocation {
    if (_isAuthenticated) {
      return AppRoutePath.dashboard;
    } else if (_hasSeenOnboarding) {
      return AppRoutePath.login;
    } else {
      return AppRoutePath.onboarding;
    }
  }

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      // Onboarding Route
      GoRoute(
        path: AppRoutePath.onboarding,
        name: AppRouteName.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Auth Routes
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (context) => sl<LoginCubit>(),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutePath.login,
            name: AppRouteName.login,
            builder: (context, state) => const LoginScreen(),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (context) => sl<SignupCubit>(),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutePath.signup,
            name: AppRouteName.signup,
            builder: (context, state) => const SignupScreen(),
          ),
        ],
      ),

      // Main App Routes (Protected)
      GoRoute(
        path: AppRoutePath.dashboard,
        name: AppRouteName.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingToAuth = state.matchedLocation == AppRoutePath.login ||
          state.matchedLocation == AppRoutePath.signup ||
          state.matchedLocation == AppRoutePath.forgotPassword;

      final isGoingToOnboarding = state.matchedLocation == AppRoutePath.onboarding;

      // If user is authenticated and trying to go to auth pages, redirect to dashboard
      if (_isAuthenticated && isGoingToAuth) {
        return AppRoutePath.dashboard;
      }

      // If user hasn't seen onboarding and trying to go anywhere else, redirect to onboarding
      if (!_hasSeenOnboarding && !isGoingToOnboarding) {
        return AppRoutePath.onboarding;
      }

      // If user is not authenticated and trying to go to protected pages, redirect to login
      if (!_isAuthenticated && !isGoingToAuth && !isGoingToOnboarding) {
        return AppRoutePath.login;
      }

      return null; // No redirect needed
    },
  );
}

// Temporary placeholder for dashboard
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Icon(
                  Icons.dashboard,
                  size: 60.w,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Welcome to Dashboard!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Authentication successful',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () async {
                  // Sign out functionality
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('user_token');
                  if (context.mounted) {
                    context.go(AppRoutePath.login);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}