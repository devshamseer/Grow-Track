// expense_impl.dart
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:grow_track/GoRouter/gorouter.dart';
import 'package:grow_track/application/expense_bloc/expense_bloc.dart';
import 'package:grow_track/domain/expense/models/expense_amount_model/expense_amount_model.dart';
import 'package:grow_track/domain/expense/models/expense_home_page_model/expense_home_page_model.dart';
import 'package:grow_track/domain/status/model/success_status_model/success_status_model.dart';
import 'package:grow_track/domain/utils/validates/validate.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:grow_track/domain/db/model/expense.dart';
import 'package:grow_track/domain/expense/expense_service.dart';
import 'package:grow_track/domain/failures/main_failures.dart';

import '../../main.dart';
import '../db/objectbox.dart';

@LazySingleton(as: ExpenseService)
class ExpenseImpl extends ExpenseService {
  // ExpenseImpl({required this.objectBox});

  @override
  Future<Either<MainFailures, List<Expense>>> getAllExpenses() async {
    try {
      final expenses = objectBox!.getAllExpenses();
      return Right(expenses);
    } catch (e) {
      log("Error ${e}");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, List<Expense>>> getExpensesByCategory(
      {required String? expTitel}) async {
    try {
      final expensest = objectBox!.getExpensesByCategory(category: expTitel);

      return Right(expensest);
    } catch (e) {
      log("Error ${e}");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, List<ExpenseHomePageModel>>>
      getGroupedExpensesWithTotal() async {
    try {
      final expenses = objectBox!.getGroupedExpensesWithTotal();

      return Right(expenses);
    } catch (e) {
      log("Error ${e}");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, SuccessStatusModel>> createExpense(
      {required Expense createExpenseList}) async {
    try {
      log("Impl Dri");
      final title = createExpenseList.title;
      final description = createExpenseList.description;
      final amount = createExpenseList.amount;
      final expTitel = createExpenseList.expTitel;

      if (!AppValidateCon.isValidString(expTitel)) {
        log("FIld 1");
        return Right(SuccessStatusModel(
            success: false,
            message: "Plese Select Expense",
            isvalidated: false));
      } else if (!AppValidateCon.isValidAmount(amount.toString())) {
        log("FIld 2");
        return Right(SuccessStatusModel(
            success: false, message: "Plese enter amount", isvalidated: false));
      } else if (!AppValidateCon.isValidString(title)) {
        log("FIld 3");
        return Right(SuccessStatusModel(
            success: false, message: "Plese enter title", isvalidated: false));
      } else if (!AppValidateCon.isValidString(description)) {
        log("FIld 4");
        return Right(SuccessStatusModel(
            success: false,
            message: "Plese enter description",
            isvalidated: false));
      } else {
        log("✅");
        objectBox!.addExpense(createExpenseList);

        return Right(SuccessStatusModel(
            success: true, message: "Created", isvalidated: true));
      }
    } catch (e) {
      log("${e}");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, List<Expense>>> getExpensesByIdList(
      {required String? expTitel}) async {
    try {
      final expDatad = objectBox!.getExpensesByCategory(category: expTitel);

// log(expDatad.toString());
      // Use compute to run the getExpensesByCategory function in an isolate
      //  final expData = await compute(IsolateFunctions.getExpensesByCategoryIsolate, expTitel!);
      final expData = objectBox!.getExpensesByCategory(category: expTitel);
      ;
      return Right(expData);
    } catch (e) {
      log("Error while fetching expenses: $e");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, ExpenseAmountModel>>
      getTottelAmountExpenses() async {
    try {
      final expDatadAmount = objectBox!.getTotalExpenseAmount();

      final amount = ExpenseAmountModel(
        fullTotelAmount: expDatadAmount,
      );
      log(amount.toString());
      return Right(amount);
    } catch (e) {
      log("Error while fetching expenses: $e");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, ExpenseAmountModel>> getTottelAmountExpensesById(
      {required String? expTitel}) async {
    try {
      final expDatadAmount =
          objectBox!.getTotalAmountByCategory(category: expTitel!);

      final amount = ExpenseAmountModel(detailsAmount: expDatadAmount);
      log(amount.toString());
      return Right(amount);
    } catch (e) {
      log("Error while fetching expenses: $e");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, SuccessStatusModel>> UpdateExpenseById(
      {required String expId, required Expense updateExpenseList}) async {
    try {
      log("Impl Dri");
      final title = updateExpenseList.title;
      final description = updateExpenseList.description;
      final amount = updateExpenseList.amount;
      final expTitel = updateExpenseList.expTitel;

      if (!AppValidateCon.isValidString(expTitel)) {
        log("FIld 1");
        return Right(SuccessStatusModel(
            success: false,
            message: "Plese Select Expense",
            isvalidated: false));
      } else if (!AppValidateCon.isValidAmount(amount.toString())) {
        log("FIld 2");
        return Right(SuccessStatusModel(
            success: false, message: "Plese enter amount", isvalidated: false));
      } else if (!AppValidateCon.isValidString(title)) {
        log("FIld 3");
        return Right(SuccessStatusModel(
            success: false, message: "Plese enter title", isvalidated: false));
      } else if (!AppValidateCon.isValidString(description)) {
        log("FIld 4");
        return Right(SuccessStatusModel(
            success: false,
            message: "Plese enter description",
            isvalidated: false));
      } else {
        log("✅");
        objectBox!.updateExpenseByUuid(expId, updateExpenseList);

        return Right(SuccessStatusModel(
            success: true, message: "Updated", isvalidated: true));
      }
    } catch (e) {
      log("${e}");
      return Left(MainFailures.clientFailures());
    }
  }

  @override
  Future<Either<MainFailures, SuccessStatusModel>> deleteExpenseByUuid(
      {required uuid}) async {
    try {
      log("✅");
      objectBox!.deleteExpenseByUuid(uuid);

      return Right(SuccessStatusModel(
          success: true, message: "Deleted", isvalidated: true));
    } catch (e) {
      log("${e}");
      return Right(SuccessStatusModel(
          success: false, message: "Deleate Error", isvalidated: false));
      ;
    }
  }

  @override
  Future<Either<MainFailures, List<Expense>>> SercheExpense(
      {required String? Qery, required String? expTitel}) async {
    try {
      //  expenseList = expenseList
      //         .map(() => User.fromJson(userJson))
      //         .where((user) {
      //       String query = searchController.text.toLowerCase();
      //       return user.name.toLowerCase().contains(query) ||
      //           user.email.toLowerCase().contains(query) ||
      //           user.phone.contains(query);
      //     }).toList();

 var expenseList=objectBox!.getExpensesByCategory(category: expTitel);

      expenseList = expenseList.where((expense) {
        return expense.title.toLowerCase().contains(Qery!) ||
            expense.amount.toString().toLowerCase().contains(Qery!);
      }).toList();

      return Right(expenseList);
    } catch (e) {
      log("Error while fetching expenses: $e");
      return Left(MainFailures.clientFailures());
    }
  }
}

class IsolateFunctions {
  // This function runs in a background isolate
  static Future<List<Expense>> getExpensesByCategoryIsolate(
      String expTitle) async {
    log("Isolate call");
    log(expTitle);
    // Perform the database query in the background

    final expData = await objectBox!.getExpensesByCategory(category: expTitle);

    log(expData.toString());
    return expData;
  }
}
