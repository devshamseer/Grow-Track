// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_amount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseAmountModel _$ExpenseAmountModelFromJson(Map<String, dynamic> json) =>
    ExpenseAmountModel(
      fullTotelAmount: (json['fullTotelAmount'] as num?)?.toDouble(),
      detailsAmount: (json['detailsAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ExpenseAmountModelToJson(ExpenseAmountModel instance) =>
    <String, dynamic>{
      'fullTotelAmount': instance.fullTotelAmount,
      'detailsAmount': instance.detailsAmount,
    };
