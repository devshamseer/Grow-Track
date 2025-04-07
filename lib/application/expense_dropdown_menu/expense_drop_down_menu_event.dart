part of 'expense_drop_down_menu_bloc.dart';

@freezed
class ExpenseDropDownMenuEvent with _$ExpenseDropDownMenuEvent {
  // const factory ExpenseDropDownMenuEvent.started() = _Started;

  const factory ExpenseDropDownMenuEvent.changeDropdownValue(
      {required String? selectedValue}) = _changeDropdownValue;
}
