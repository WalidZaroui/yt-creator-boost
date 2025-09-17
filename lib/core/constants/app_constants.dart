class AppConstants {
  static const String appName = 'YT Creator Boost';
  static const String appVersion = '1.0.0';

  // Point Values
  static const int subscriptionPoints = 100;
  static const int dailyLoginPoints = 20;
  static const int weeklyChallenge = 300;
  static const int adWatchPoints = 50;

  // Leaderboard
  static const int globalTop10Limit = 10;
  static const int weeklyDisplayLimit = 50;

  // Storage Keys
  static const String hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
}

enum ContentType {
  islamic,
  gaming,
  education,
  tech,
  cooking,
  fitness,
  music,
  comedy,
  travel,
  business,
  art,
  lifestyle
}

extension ContentTypeExtension on ContentType {
  String get displayName {
    switch (this) {
      case ContentType.islamic:
        return 'Islamic Content';
      case ContentType.gaming:
        return 'Gaming';
      case ContentType.education:
        return 'Education';
      case ContentType.tech:
        return 'Technology';
      case ContentType.cooking:
        return 'Cooking';
      case ContentType.fitness:
        return 'Fitness';
      case ContentType.music:
        return 'Music';
      case ContentType.comedy:
        return 'Comedy';
      case ContentType.travel:
        return 'Travel';
      case ContentType.business:
        return 'Business';
      case ContentType.art:
        return 'Art & Design';
      case ContentType.lifestyle:
        return 'Lifestyle';
    }
  }
}