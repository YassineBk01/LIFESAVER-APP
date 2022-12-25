// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MedicalFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalFile _$MedicalFileFromJson(Map<String, dynamic> json) => MedicalFile(
      json['id'] as String,
      json['idUser'] as String,
      json['height'] as String,
      json['weight'] as String,
      json['age'] as int,
      json['alergies'] as String?,
      json['DIABETES'] as String,
      json['HEART_DISEASE'] as String,
      json['bloodGroup'] as String?,
      json['covidVaccine'] as String,
      json['otherDisease'] as String?,
    );

Map<String, dynamic> _$MedicalFileToJson(MedicalFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'age': instance.age,
      'idUser': instance.idUser,
      'alergies': instance.alergies,
      'DIABETES': instance.DIABETES,
      'HEART_DISEASE': instance.HEART_DISEASE,
      'height': instance.height,
      'weight': instance.weight,
      'bloodGroup': instance.bloodGroup,
      'covidVaccine': instance.covidVaccine,
      'otherDisease': instance.otherDisease,
    };
