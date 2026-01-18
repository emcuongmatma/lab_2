class UserProfile {
  final String id;
  final String name;
  final String password;

  UserProfile({
    required this.id,
    required this.name,
    required this.password,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }
}
