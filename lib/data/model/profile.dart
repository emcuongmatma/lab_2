import 'package:equatable/equatable.dart';

/// name : "Cường"
/// avatar : "https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/avatar-anh-meo-cute-3.jpg"
/// backgroundColor : "0xFF3393FF"
/// id : "1"

class Profile extends Equatable {
  Profile({
    String? name,
    String? avatar,
    String? backgroundColor,
    String? id,
  }) {
    _name = name;
    _avatar = avatar;
    _backgroundColor = backgroundColor;
    _id = id;
  }

  Profile.fromJson(dynamic json) {
    _name = json['name'];
    _avatar = json['avatar'];
    _backgroundColor = json['backgroundColor'];
    _id = json['id'];
  }

  String? _name;
  String? _avatar;
  String? _backgroundColor;
  String? _id;

  Profile copyWith({
    String? name,
    String? avatar,
    String? backgroundColor,
    String? id,
  }) => Profile(
    name: name ?? _name,
    avatar: avatar ?? _avatar,
    backgroundColor: backgroundColor ?? _backgroundColor,
    id: id ?? _id,
  );

  String? get name => _name;

  String? get avatar => _avatar;

  String? get backgroundColor => _backgroundColor;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['avatar'] = _avatar;
    map['backgroundColor'] = _backgroundColor;
    map['id'] = _id;
    return map;
  }

  @override
  List<Object> get props => [];
}
