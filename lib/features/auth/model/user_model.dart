class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final Map<String, dynamic>? statistics;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.statistics,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'],
      statistics: json['statistics'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'statistics': statistics,
    };
  }
}
