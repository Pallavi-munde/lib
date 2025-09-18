class UserModel {
  final String id;
  final String email;
  final String? name;

  const UserModel({required this.id, required this.email, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        email: json['email'] as String,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
      };
}


