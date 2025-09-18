class AppConstants {
  // App Info
  static const String appName = 'YT Creator Boost';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Grow Your YouTube Channel';

  // API/Backend URLs (for future use)
  static const String baseUrl = 'https://api.ytcreatorboost.com';
  static const String youtubeApiBaseUrl = 'https://www.googleapis.com/youtube/v3';

  // Points System
  static const int pointsForSubscription = 100;
  static const int pointsForGettingSubscriber = 50;
  static const int pointsForDailyLogin = 20;
  static const int pointsForWeeklyChallenge = 300;
  static const int pointsForWatchingAd = 50;

  // Content Categories
  static const List<String> contentCategories = [
    'Islamic',
    'Gaming',
    'Education',
    'Technology',
    'Entertainment',
    'Music',
    'Sports',
    'Cooking',
    'Travel',
    'Lifestyle',
    'Comedy',
    'News',
    'Science',
    'Health & Fitness',
    'Beauty & Fashion',
    'DIY & Crafts',
    'Automotive',
    'Finance',
    'Real Estate',
    'Business',
  ];

  // Competition
  static const int leaderboardLimit = 10;
  static const int weeklyLeaderboardLimit = 100;
  static const int globalHallOfFameLimit = 10;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 2;
  static const int maxUsernameLength = 30;
  static const int maxEmailLength = 100;

  // UI
  static const double defaultPadding = 24.0;
  static const double defaultBorderRadius = 16.0;
  static const double cardElevation = 2.0;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 3);

  // YouTube
  static const int minSubscriberCount = 0;
  static const int maxSubscriberCount = 1000000000; // 1 billion
  static const String youtubeChannelUrlPattern = r'https?:\/\/(www\.)?youtube\.com\/(channel\/|c\/|@)[\w-]+';

  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';

  // Error Messages
  static const String networkErrorMessage = 'Please check your internet connection and try again.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String unknownErrorMessage = 'An unknown error occurred. Please try again.';
  static const String invalidEmailMessage = 'Please enter a valid email address.';
  static const String invalidPasswordMessage = 'Password must be at least 6 characters long.';
  static const String passwordMismatchMessage = 'Passwords do not match.';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registerSuccessMessage = 'Account created successfully!';
  static const String passwordResetEmailSentMessage = 'Password reset email sent! Check your inbox.';
  static const String profileUpdatedMessage = 'Profile updated successfully!';

  // Feature Flags (for future use)
  static const bool enableGoogleSignIn = true;
  static const bool enableAppleSignIn = false; // Disabled as requested
  static const bool enableFacebookSignIn = false;
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
  static const bool enableAnalytics = true;

  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 1);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}