import 'package:json_annotation/json_annotation.dart';

part 'expense_amount_model.g.dart';

@JsonSerializable()
class ExpenseAmountModel {
   double? fullTotelAmount;
   double? detailsAmount;

  ExpenseAmountModel({this.fullTotelAmount, this.detailsAmount});

  @override
  String toString() {
    return 'ExpenseAmountModel(fullTotelAmount: $fullTotelAmount, detailsAmount: $detailsAmount)';
  }

  factory ExpenseAmountModel.fromJson(Map<String, dynamic> json) {
    return _$ExpenseAmountModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExpenseAmountModelToJson(this);
}
