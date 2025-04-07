// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_home_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseHomePageModel _$ExpenseHomePageModelFromJson(
        Map<String, dynamic> json) =>
    ExpenseHomePageModel(
      expTitel: json['expTitel'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ExpenseHomePageModelToJson(
        ExpenseHomePageModel instance) =>
    <String, dynamic>{
      'expTitel': instance.expTitel,
      'totalAmount': instance.totalAmount,
    };
