class AppRoutes {
  // Root routes
  static const String initial = '/';
  static const String auth = '/auth';
  static const String home = '/home';

  // Auth routes
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // Main app routes
  static const String dashboard = '/dashboard';
  static const String discovery = '/discovery';
  static const String leaderboard = '/leaderboard';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Channel routes
  static const String channelDetails = '/channel/:channelId';
  static const String subscriptions = '/subscriptions';

  // Competition routes
  static const String weeklyLeaderboard = '/weekly-leaderboard';
  static const String globalHallOfFame = '/hall-of-fame';

  // Profile routes
  static const String editProfile = '/profile/edit';
  static const String achievements = '/profile/achievements';
  static const String statistics = '/profile/statistics';
}