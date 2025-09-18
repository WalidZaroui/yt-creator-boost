import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    super.displayName,
    super.photoURL,
    super.youtubeChannelId,
    super.youtubeChannelUrl,
    super.contentCategories = const [],
    super.totalPoints = 0,
    super.weeklyPoints = 0,
    super.subscriberCount = 0,
    super.isVerified = false,
    required super.createdAt,
    required super.lastActive,
  });

  // From Firebase Auth User
  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoURL: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      lastActive: DateTime.now(),
    );
  }

  // From Firestore Document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      youtubeChannelId: data['youtubeChannelId'],
      youtubeChannelUrl: data['youtubeChannelUrl'],
      contentCategories: List<String>.from(data['contentCategories'] ?? []),
      totalPoints: data['totalPoints'] ?? 0,
      weeklyPoints: data['weeklyPoints'] ?? 0,
      subscriberCount: data['subscriberCount'] ?? 0,
      isVerified: data['isVerified'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastActive: (data['lastActive'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
      youtubeChannelId: json['youtubeChannelId'],
      youtubeChannelUrl: json['youtubeChannelUrl'],
      contentCategories: List<String>.from(json['contentCategories'] ?? []),
      totalPoints: json['totalPoints'] ?? 0,
      weeklyPoints: json['weeklyPoints'] ?? 0,
      subscriberCount: json['subscriberCount'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      lastActive: DateTime.parse(json['lastActive']),
    );
  }

  // To Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'youtubeChannelId': youtubeChannelId,
      'youtubeChannelUrl': youtubeChannelUrl,
      'contentCategories': contentCategories,
      'totalPoints': totalPoints,
      'weeklyPoints': weeklyPoints,
      'subscriberCount': subscriberCount,
      'isVerified': isVerified,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastActive': Timestamp.fromDate(lastActive),
    };
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'youtubeChannelId': youtubeChannelId,
      'youtubeChannelUrl': youtubeChannelUrl,
      'contentCategories': contentCategories,
      'totalPoints': totalPoints,
      'weeklyPoints': weeklyPoints,
      'subscriberCount': subscriberCount,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive.toIso8601String(),
    };
  }

  UserModel copyWith({
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
    return UserModel(
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