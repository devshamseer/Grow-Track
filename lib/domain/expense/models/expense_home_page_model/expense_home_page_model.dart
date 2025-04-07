import 'package:json_annotation/json_annotation.dart';

part 'expense_home_page_model.g.dart';

@JsonSerializable()
class ExpenseHomePageModel {
  String? expTitel;
 double?  totalAmount;

  ExpenseHomePageModel({this.expTitel, this.totalAmount});

  factory ExpenseHomePageModel.fromJson(Map<String, dynamic> json) {
    return _$ExpenseHomePageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExpenseHomePageModelToJson(this);
}
