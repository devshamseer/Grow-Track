import 'package:json_annotation/json_annotation.dart';

part 'expense_card_model.g.dart';

@JsonSerializable()
class ExpenseCardModel {
  @JsonKey(name: 'ImageIcon')
  String? imageIcon;
  @JsonKey(name: 'Titel')
  String? titel;

  ExpenseCardModel({this.imageIcon, this.titel});

  factory ExpenseCardModel.fromJson(Map<String, String> json) {
    return _$ExpenseCardModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExpenseCardModelToJson(this);
}
