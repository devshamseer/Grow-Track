import 'package:json_annotation/json_annotation.dart';

part 'success_status_model.g.dart';

@JsonSerializable()
class SuccessStatusModel {
  bool? success;
  String? message;
  bool? isvalidated;

  SuccessStatusModel({this.success, this.message, this.isvalidated});

  factory SuccessStatusModel.fromJson(Map<String, dynamic> json) {
    return _$SuccessStatusModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SuccessStatusModelToJson(this);
}
