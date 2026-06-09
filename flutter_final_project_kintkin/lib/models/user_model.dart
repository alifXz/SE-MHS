class UserModel {
  final String id;
  final String name;
  final String email;
  final int? age;
  final String? phoneNumber;
  final String role;
  final DateTime? joinDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.phoneNumber,
    required this.role,
    this.joinDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'],
      phoneNumber: json['phone_number'],
      role: json['role'] ?? 'user',
      joinDate: json['join_date'] != null
          ? DateTime.tryParse(json['join_date'])
          : null,
    );
  }
}