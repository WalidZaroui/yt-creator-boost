import 'package:equatable/equatable.dart';
import '../../../core/constants/app_constants.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? youtubeChannelId;
  final String? youtubeChannelUrl;
  final String? channelName;
  final List<ContentType> contentInterests;
  final List<ContentType> channelContentTypes;
  final int points;
  final int weeklyPoints;
  final int subscriberCount;
  final DateTime createdAt;
  final DateTime? lastActive;
  final bool verified;
  final bool isEmailVerified;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.youtubeChannelId,
    this.youtubeChannelUrl,
    this.channelName,
    this.contentInterests = const [],
    this.channelContentTypes = const [],
    this.points = 0,
    this.weeklyPoints = 0,
    this.subscriberCount = 0,
    required this.createdAt,
    this.lastActive,
    this.verified = false,
    this.isEmailVerified = false,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    String? youtubeChannelId,
    String? youtubeChannelUrl,
    String? channelName,
    List<ContentType>? contentInterests,
    List<ContentType>? channelContentTypes,
    int? points,
    int? weeklyPoints,
    int? subscriberCount,
    DateTime? createdAt,
    DateTime? lastActive,
    bool? verified,
    bool? isEmailVerified,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      youtubeChannelId: youtubeChannelId ?? this.youtubeChannelId,
      youtubeChannelUrl: youtubeChannelUrl ?? this.youtubeChannelUrl,
      channelName: channelName ?? this.channelName,
      contentInterests: contentInterests ?? this.contentInterests,
      channelContentTypes: channelContentTypes ?? this.channelContentTypes,
      points: points ?? this.points,
      weeklyPoints: weeklyPoints ?? this.weeklyPoints,
      subscriberCount: subscriberCount ?? this.subscriberCount,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      verified: verified ?? this.verified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
    photoURL,
    youtubeChannelId,
    youtubeChannelUrl,
    channelName,
    contentInterests,
    channelContentTypes,
    points,
    weeklyPoints,
    subscriberCount,
    createdAt,
    lastActive,
    verified,
    isEmailVerified,
  ];
}