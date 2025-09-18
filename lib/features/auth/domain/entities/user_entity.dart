import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? youtubeChannelId;
  final String? youtubeChannelUrl;
  final List<String> contentCategories;
  final int totalPoints;
  final int weeklyPoints;
  final int subscriberCount;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime lastActive;

  const UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
    this.youtubeChannelId,
    this.youtubeChannelUrl,
    this.contentCategories = const [],
    this.totalPoints = 0,
    this.weeklyPoints = 0,
    this.subscriberCount = 0,
    this.isVerified = false,
    required this.createdAt,
    required this.lastActive,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    displayName,
    photoURL,
    youtubeChannelId,
    youtubeChannelUrl,
    contentCategories,
    totalPoints,
    weeklyPoints,
    subscriberCount,
    isVerified,
    createdAt,
    lastActive,
  ];

  UserEntity copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? youtubeChannelId,
    String? youtubeChannelUrl,
    List<String>? contentCategories,
    int? totalPoints,
    int? weeklyPoints,
    int? subscriberCount,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? lastActive,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      youtubeChannelId: youtubeChannelId ?? this.youtubeChannelId,
      youtubeChannelUrl: youtubeChannelUrl ?? this.youtubeChannelUrl,
      contentCategories: contentCategories ?? this.contentCategories,
      totalPoints: totalPoints ?? this.totalPoints,
      weeklyPoints: weeklyPoints ?? this.weeklyPoints,
      subscriberCount: subscriberCount ?? this.subscriberCount,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}