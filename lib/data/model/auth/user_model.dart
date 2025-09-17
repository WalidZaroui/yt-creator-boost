import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/auth/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoURL,
    super.youtubeChannelId,
    super.youtubeChannelUrl,
    super.channelName,
    super.contentInterests = const [],
    super.channelContentTypes = const [],
    super.points = 0,
    super.weeklyPoints = 0,
    super.subscriberCount = 0,
    required super.createdAt,
    super.lastActive,
    super.verified = false,
    super.isEmailVerified = false,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      youtubeChannelId: data['youtubeChannelId'],
      youtubeChannelUrl: data['youtubeChannelUrl'],
      channelName: data['channelName'],
      contentInterests: _parseContentTypes(data['contentInterests']),
      channelContentTypes: _parseContentTypes(data['channelContentTypes']),
      points: data['points'] ?? 0,
      weeklyPoints: data['weeklyPoints'] ?? 0,
      subscriberCount: data['subscriberCount'] ?? 0,
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toIso8601String()),
      lastActive: data['lastActive'] != null ? DateTime.parse(data['lastActive']) : null,
      verified: data['verified'] ?? false,
      isEmailVerified: data['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'youtubeChannelId': youtubeChannelId,
      'youtubeChannelUrl': youtubeChannelUrl,
      'channelName': channelName,
      'contentInterests': contentInterests.map((e) => e.name).toList(),
      'channelContentTypes': channelContentTypes.map((e) => e.name).toList(),
      'points': points,
      'weeklyPoints': weeklyPoints,
      'subscriberCount': subscriberCount,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive?.toIso8601String(),
      'verified': verified,
      'isEmailVerified': isEmailVerified,
    };
  }

  static List<ContentType> _parseContentTypes(dynamic data) {
    if (data == null) return [];
    if (data is List) {
      return data
          .where((item) => item is String)
          .map((item) => _parseContentType(item as String))
          .where((type) => type != null)
          .cast<ContentType>()
          .toList();
    }
    return [];
  }

  static ContentType? _parseContentType(String value) {
    try {
      return ContentType.values.firstWhere((type) => type.name == value);
    } catch (e) {
      return null;
    }
  }

  @override
  UserModel copyWith({
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
    return UserModel(
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
}