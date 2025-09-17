import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_creator_boost/config/router/app_route_constants.dart';

import 'config/router/app_route.dart';
import 'core/constants/app_constants.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully');

    await di.init();
    print('✅ Dependencies initialized successfully');

  } catch (e) {
    print('❌ Initialization error: $e');
  }

  runApp(const YTCreatorBoostApp());
}

class YTCreatorBoostApp extends StatelessWidget {
  const YTCreatorBoostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FutureBuilder<bool>(
          future: _checkOnboardingStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                home: _buildLoadingScreen(),
              );
            }

            final hasSeenOnboarding = snapshot.data ?? false;
            const isAuthenticated = false;

            final appRouter = AppRouter(hasSeenOnboarding, isAuthenticated);

            return MaterialApp.router(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
                useMaterial3: true,
              ),
              routerConfig: appRouter.router,
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Icon(
                Icons.rocket_launch,
                size: 60.w,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'YT Creator Boost',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40.h),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _checkOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(AppConstants.hasSeenOnboardingKey) ?? false;
    } catch (e) {
      return false;
    }
  }
}