import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String password;

  const UserProfile(
      {required this.id, required this.name, required this.password});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      password: json['password'],
    );
  }

  const UserProfile.empty(): this(id: "", name: "",password: "");


  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'password': password};
  }

  @override
  List<Object?> get props => [id];
}
