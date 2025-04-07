part of 'expense_drop_down_menu_bloc.dart';

@freezed
class ExpenseDropDownMenuState with _$ExpenseDropDownMenuState {
  // const factory ExpenseDropDownMenuState.initial() = _Initial;

  const factory ExpenseDropDownMenuState({
    String? selectedExpense,
  }) = _ExpenseDropDownMenuState;

  factory ExpenseDropDownMenuState.initial() => ExpenseDropDownMenuState(
      selectedExpense: null); // CardIconsUtils.ExpCardData[0].titel!
}
