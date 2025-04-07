part of 'expense_bloc.dart';

@freezed
class ExpenseEvent with _$ExpenseEvent {
  // const factory ExpenseEvent.started() = _Started;

  const factory ExpenseEvent.getAllExpenses() = _getAllExpenses;
  const factory ExpenseEvent.getExpensesByCategory({required String expTitle}) =
      _getExpensesByCategory;

  const factory ExpenseEvent.getGroupedExpensesWithTotal() =
      _getGroupedExpensesWithTotal;

  const factory ExpenseEvent.getExpensesByIdList({required String expTitel}) =
      _getExpensesByIdList;

        const factory ExpenseEvent.updateExpenseById({required String expId,required Expense updateExpense}) =
      _updateExpenseById;

  const factory ExpenseEvent.createExpense({required Expense createExpense}) =
      _createExpense;

        const factory ExpenseEvent.getTottelAmountExpensesById({required String expTitel}) =
      _getTottelAmountExpensesById;

        const factory ExpenseEvent.deleteExpenseByUuid({required String uuid}) =
      _deleteExpenseByUuid;


        const factory ExpenseEvent.getAllAmountExpenses() =
      _getAllAmountExpenses;


 const factory ExpenseEvent.sercheExpens({required String serchQery, required String? expTitel}) =
      _sercheExpens;

}
