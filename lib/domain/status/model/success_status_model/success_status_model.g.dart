// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessStatusModel _$SuccessStatusModelFromJson(Map<String, dynamic> json) =>
    SuccessStatusModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      isvalidated: json['isvalidated'] as bool?,
    );

Map<String, dynamic> _$SuccessStatusModelToJson(SuccessStatusModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'isvalidated': instance.isvalidated,
    };
