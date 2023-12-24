class UserTables {
  // final int userId;
  final int phoneNumber;
  final String name;
  final String username;
  final String language;
  final String userType;

  UserTables({
    // required this.userId,
    required this.phoneNumber,
    required this.name,
    required this.username,
    required this.language,
    required this.userType,
  });

  factory UserTables.fromJson(Map<String, dynamic> json) {
    return UserTables(
      // userId: json['user_id'],
      phoneNumber: json['phone_number'],
      name: json['name'],
      username: json['username'],
      language: json['language'],
      userType: json['user_type'],
    );
  }
}