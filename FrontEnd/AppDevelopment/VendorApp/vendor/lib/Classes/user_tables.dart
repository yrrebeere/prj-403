class UserTables {
  final int userId;
  final int phoneNumber;
  final String name;
  // final String password;
  final String username;
  final String language;
  final String userType;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  UserTables({
    required this.userId,
    required this.phoneNumber,
    required this.name,
    // required this.password,
    required this.username,
    required this.language,
    required this.userType,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory UserTables.fromJson(Map<String, dynamic> json) {
    return UserTables(
      userId: json['user_id'],
      phoneNumber: json['phone_number'],
      name: json['name'],
      // password: json['password'],
      username: json['username'],
      language: json['language'],
      userType: json['user_type'],
      // createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
    );
  }
}