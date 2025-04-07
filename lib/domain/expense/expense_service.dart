import 'package:grow_track/domain/db/model/expense.dart';
import 'package:grow_track/domain/expense/models/expense_amount_model/expense_amount_model.dart';
import 'package:grow_track/domain/expense/models/expense_home_page_model/expense_home_page_model.dart';

import '../failures/main_failures.dart';
import 'package:dartz/dartz.dart';

import '../status/model/success_status_model/success_status_model.dart';

abstract class ExpenseService {
  Future<Either<MainFailures, List<Expense>>> getAllExpenses();
  Future<Either<MainFailures, List<Expense>>> getExpensesByCategory(
      {required String? expTitel});
  Future<Either<MainFailures, List<ExpenseHomePageModel>>>
      getGroupedExpensesWithTotal();

  Future<Either<MainFailures, SuccessStatusModel>> createExpense(
      {required Expense createExpenseList});

  Future<Either<MainFailures, List<Expense>>> getExpensesByIdList(
      {required String? expTitel});

  // Tottel Amount
  Future<Either<MainFailures, ExpenseAmountModel>> getTottelAmountExpensesById(
      {required String? expTitel});
  Future<Either<MainFailures, ExpenseAmountModel>> getTottelAmountExpenses();

  // update
   Future<Either<MainFailures, SuccessStatusModel>> UpdateExpenseById({required String expId,required Expense updateExpenseList});
   // Delete
      Future<Either<MainFailures, SuccessStatusModel>> deleteExpenseByUuid({required uuid});
   // Search

     Future<Either<MainFailures, List<Expense>>> SercheExpense(
      {required String? Qery, required String? expTitel});
}
