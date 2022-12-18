

import 'package:json_annotation/json_annotation.dart';

part 'UserApp.g.dart';

@JsonSerializable()
class UserApp {
  UserApp({
    required this.id,
    required this.fullname,
    required this.age,
    required this.cin,
    required this.phone,
    required this.email,
    required this.password

  });



  final String fullname ;
  String id;
  final int age;
  final String email;
  final String password;
  final String cin;
  final String phone;


  factory UserApp.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  Map<String, Object?> toJson() => _$UserToJson(this);

}