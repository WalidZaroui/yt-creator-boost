import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yt_creator_boost/core/routes/app_router.dart';
import '../di/injection_container.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'app_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: AppRoutes.auth,
      redirect: (context, state) {
        final authCubit = sl<AuthCubit>();
        final authState = authCubit.state;

        final isAuthRoute = state.matchedLocation.startsWith('/auth');
        final isAuthenticated = authState is AuthAuthenticated;

        // If user is authenticated and trying to access auth routes, redirect to home
        if (isAuthenticated && isAuthRoute) {
          return AppRoutes.home;
        }

        // If user is not authenticated and trying to access protected routes, redirect to auth
        if (!isAuthenticated && !isAuthRoute) {
          return AppRoutes.auth;
        }

        // No redirect needed
        return null;
      },
      routes: [
        // Auth Routes
        GoRoute(
          path: AppRoutes.auth,
          name: 'auth',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthCubit>()..checkAuthStatus(),
            child: const AuthPage(),
          ),
        ),

        // Home Route
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthCubit>()..checkAuthStatus(),
            child: const HomePage(),
          ),
        ),

        // Dashboard Route (Future)
        GoRoute(
          path: AppRoutes.dashboard,
          name: 'dashboard',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthCubit>()..checkAuthStatus(),
            child: const Scaffold(
              body: Center(
                child: Text('Dashboard - Coming Soon!'),
              ),
            ),
          ),
        ),

        // Discovery Route (Future)
        GoRoute(
          path: AppRoutes.discovery,
          name: 'discovery',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthCubit>()..checkAuthStatus(),
            child: const Scaffold(
              body: Center(
                child: Text('Discovery - Coming Soon!'),
              ),
            ),
          ),
        ),

        // Leaderboard Route (Future)
        GoRoute(
          path: AppRoutes.leaderboard,
          name: 'leaderboard',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthCubit>()..checkAuthStatus(),
            child: const Scaffold(
              body: Center(
                child: Text('Leaderboard - Coming Soon!'),
              ),
            ),
          ),
        ),

        // Profile Route (Future)
        GoRoute(
          path: AppRoutes.profile,
          name: 'profile',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthCubit>()..checkAuthStatus(),
            child: const Scaffold(
              body: Center(
                child: Text('Profile - Coming Soon!'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}