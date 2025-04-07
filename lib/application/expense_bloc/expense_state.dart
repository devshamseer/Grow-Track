part of 'expense_bloc.dart';


enum expenaseStatus{succses,error,loading,}

@freezed
class ExpenseState with _$ExpenseState {
  // const factory ExpenseState.initial() = _Initial;

  const factory ExpenseState({
    required bool isloading,
    required List<Expense> ExpensesByCategoryList,
    required List<Expense> ExpensesByIdList,
    required List<ExpenseHomePageModel> GroupedExpensesWithTotal,
    SuccessStatusModel? createExpense,

    ExpenseAmountModel? tottelAmount,
  }) = _ExpenseState;

  factory ExpenseState.initial() => ExpenseState(
      isloading: false,
      ExpensesByCategoryList: [],
      GroupedExpensesWithTotal: [],
      ExpensesByIdList: [],
      tottelAmount: ExpenseAmountModel(detailsAmount: 0,fullTotelAmount: 0));

        factory ExpenseState.loded() => ExpenseState(
      isloading: false,
      ExpensesByCategoryList: [],
      GroupedExpensesWithTotal: [],
      ExpensesByIdList: [],
      tottelAmount: ExpenseAmountModel(detailsAmount: 0,fullTotelAmount: 0));
}
