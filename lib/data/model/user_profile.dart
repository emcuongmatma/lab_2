import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String password;
  final String? backgroundColor;

  const UserProfile({
    required this.id,
    required this.name,
    required this.password,
    this.backgroundColor,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      backgroundColor: json['backgroundColor'],
    );
  }

  const UserProfile.empty()
    : this(id: "", name: "", password: "", backgroundColor: "");

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'backgroundColor': backgroundColor,
    };
  }

  @override
  List<Object?> get props => [id];
}
