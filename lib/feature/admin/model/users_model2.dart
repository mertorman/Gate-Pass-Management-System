class UserModel2 {
  final String id;
  final String username;
  final String email;
  final String password;
  final String phone;
  bool isApproved;
  bool isBlocked;
  final String role;
  final String createdAt;
  final String updatedAt;

  UserModel2({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.isApproved,
    required this.isBlocked,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel2.fromJson(Map<String, dynamic> json) {
    return UserModel2(
      id: json["_id"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      isApproved: json["isApproved"],
      isBlocked: json["isBlocked"] ,
      role: json["role"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}
