import 'package:json_annotation/json_annotation.dart';

part 'MedicalFile.g.dart';

@JsonSerializable()
class MedicalFile {


  MedicalFile(
      this.id,
      this.idUser,
      this.height,
      this.weight,
      this.age,
      this.alergies,
      this.DIABETES,
      this.HEART_DISEASE,
      this.bloodGroup,
      this.covidVaccine,
      this.dozeNumber,

      );

  String id;
  int age;
  String idUser;
  String alergies;
  String DIABETES;
  String HEART_DISEASE;
  String height;
  String weight;
  String bloodGroup;
  String covidVaccine;
  int dozeNumber;

  factory MedicalFile.fromJson(Map<String, Object?> json) => _$MedicalFileFromJson(json);

  Map<String, Object?> toJson() => _$MedicalFileToJson(this);
}