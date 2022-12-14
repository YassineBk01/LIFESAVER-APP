// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserApp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApp _$UserFromJson(Map<String, dynamic> json) => UserApp(
      id: json['id'] as String,
      fullname: json['fullname'] as String,
      age: json['age'] as int,
      cin: json['cin'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profileImg: json['profileImg'] as String? ?? "assets/images/profile.jpg",
      isVerified: json['isVerified'] as bool? ?? false,
      hasMedicalFile: json['hasMedicalFile'] as bool? ?? false,
    );

Map<String, dynamic> _$UserToJson(UserApp instance) => <String, dynamic>{
      'fullname': instance.fullname,
      'id': instance.id,
      'age': instance.age,
      'email': instance.email,
      'password': instance.password,
      'cin': instance.cin,
      'phone': instance.phone,
      'isVerified': instance.isVerified,
      'hasMedicalFile': instance.hasMedicalFile,
      'profileImg': instance.profileImg,
    };
