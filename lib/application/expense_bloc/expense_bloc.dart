import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grow_track/GoRouter/gorouter.dart';
import 'package:grow_track/application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart';
import 'package:grow_track/domain/expense/expense_service.dart';
import 'package:grow_track/domain/expense/models/expense_home_page_model/expense_home_page_model.dart';
import 'package:grow_track/domain/status/model/success_status_model/success_status_model.dart';
import 'package:grow_track/main.dart';
import 'package:grow_track/presentation/expense_details/controller/expense_details_controller.dart';
import 'package:grow_track/presentation/expense_details/expense_details_page.dart';
import 'package:grow_track/presentation/home/controllers/home_controllers.dart';
import 'package:grow_track/services/notifications/notifi_service.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/dependencies_injection/injectable.dart';
import '../../domain/db/model/expense.dart';
import '../../domain/expense/models/expense_amount_model/expense_amount_model.dart';

part 'expense_event.dart';
part 'expense_state.dart';
part 'expense_bloc.freezed.dart';

@injectable
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseService expenseService;

  ExpenseBloc(this.expenseService) : super(ExpenseState.initial()) {
    on<_getAllExpenses>(_onGetAllExpenses);
    on<_getExpensesByCategory>(_onGetExpensesByCategory);
    on<_getGroupedExpensesWithTotal>(_onGetGroupedExpensesWithTotal);
    on<_createExpense>(_onCreateExpense);
    on<_getExpensesByIdList>(_onGetExpensesByIdList);
    on<_getAllAmountExpenses>(_onGetAllAmountExpenses);
    on<_getTottelAmountExpensesById>(_onGetTottelAmountExpensesById);
    on<_updateExpenseById>(_onUpdateExpenseById);
   on<_deleteExpenseByUuid>(_ondeleteExpenseByUuid);
    on< _sercheExpens>(_onsercheExpens);
   
  }

  // Handle fetching all expenses
  Future<void> _onGetAllExpenses(
      _getAllExpenses event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isloading: true));
    final result = await expenseService.getAllExpenses();

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) => emit(state.copyWith(
        ExpensesByCategoryList: expenses,
        isloading: false,
      )),
    );
  }

  // Handle fetching expenses by category
  Future<void> _onGetExpensesByCategory(
      _getExpensesByCategory event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isloading: true));
    final result =
        await expenseService.getExpensesByCategory(expTitel: event.expTitle);

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) {
        expenses.forEach((element) {
          log(element
              .expTitel); // You can refine or remove this log in production
        });
        emit(state.copyWith(
          ExpensesByCategoryList: expenses,
          isloading: false,
        ));
      },
    );
  }

  // Handle fetching grouped expenses with total
  Future<void> _onGetGroupedExpensesWithTotal(
      _getGroupedExpensesWithTotal event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isloading: true));
    final result = await expenseService.getGroupedExpensesWithTotal();

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) => emit(state.copyWith(
        GroupedExpensesWithTotal: expenses,
        isloading: false,
      )),
    );
  }

  // Handle creating a new expense
  Future<void> _onCreateExpense(
      _createExpense event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isloading: true));
    final result = await expenseService.createExpense(
        createExpenseList: event.createExpense);

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) {
        //    emit(state.copyWith(
        //   createExpense: expenses,

        // ));

        if (expenses.isvalidated!) {
          //       getIt<ExpenseBloc>().add(ExpenseEvent.getAllAmountExpenses());
          //  getIt<ExpenseBloc>().add(ExpenseEvent.getGroupedExpensesWithTotal());

          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error, // You can use any icon you want here
                  color: Colors.white,
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    "${expenses.message!.toString()}", // Your message
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
           
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            behavior: SnackBarBehavior
                .floating, // Optional, makes the snack bar float
            duration: Duration(seconds: 3), // Duration to show the snackbar
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          // AppRouter.showSnackbar(
          //   snackBar: snackBar,
          // );

//  NotificationService.showInstantNotification(title: "New Expense Added 💸", body: "You spent ");

 NotificationService.showNotification( title: "New Expense Added 💸", body: "You spent ");
          AppRouter.closeBottomSheet();
          HomePageControllers.clear();
          ExpenseDetailsPageController.clear();
        } else {
          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error, // You can use any icon you want here
                  color: Colors.white,
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    "${expenses.message!.toString()}", // Your message
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            behavior: SnackBarBehavior
                .floating, // Optional, makes the snack bar float
            duration: Duration(seconds: 1), // Duration to show the snackbar
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    //   AppRouter.showSnackbar(snackBar: snackBar);
        }
      },
    );
  }

  // Handle fetching expenses by id list
  Future<void> _onGetExpensesByIdList(
      _getExpensesByIdList event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isloading: true));
    final result =
        await expenseService.getExpensesByIdList(expTitel: event.expTitel);

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) => emit(state.copyWith(
        ExpensesByIdList: expenses,
        isloading: false,
      )),
    );
  }

  Future<void> _onGetAllAmountExpenses(
      _getAllAmountExpenses event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isloading: true));
    final result = await expenseService.getTottelAmountExpenses();

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) {
        log(expenses.toString() + "All Amount Calling");
        emit(state.copyWith(
            tottelAmount: ExpenseAmountModel(
                detailsAmount:
                    expenses.detailsAmount ?? state.tottelAmount!.detailsAmount,
                fullTotelAmount: expenses.fullTotelAmount ??
                    state.tottelAmount!.fullTotelAmount)));
      },
    );
  }

  Future<void> _onGetTottelAmountExpensesById(
      _getTottelAmountExpensesById event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isloading: true));
    final result = await expenseService.getTottelAmountExpensesById(
        expTitel: event.expTitel);

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) {
        log(expenses.toString() + "ID Amount Calling");
        emit(state.copyWith(
            tottelAmount: ExpenseAmountModel(
                detailsAmount:
                    expenses.detailsAmount ?? state.tottelAmount!.detailsAmount,
                fullTotelAmount: expenses.fullTotelAmount ??
                    state.tottelAmount!.fullTotelAmount)));
      },
    );
  }

  Future<void> _onUpdateExpenseById(
      _updateExpenseById event, Emitter<ExpenseState> emit) async {
    final result = await expenseService.UpdateExpenseById(
        expId: event.expId, updateExpenseList: event.updateExpense);

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) {
        //    emit(state.copyWith(
        //   createExpense: expenses,

        // ));

        if (expenses.isvalidated!) {
          //       getIt<ExpenseBloc>().add(ExpenseEvent.getAllAmountExpenses());
          //  getIt<ExpenseBloc>().add(ExpenseEvent.getGroupedExpensesWithTotal());

          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error, // You can use any icon you want here
                  color: Colors.white,
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    "${expenses.message!.toString()}", // Your message
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            behavior: SnackBarBehavior
                .floating, // Optional, makes the snack bar float
            duration: Duration(seconds: 3), // Duration to show the snackbar
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          // AppRouter.showSnackbar(
          //   snackBar: snackBar,
          // );

          AppRouter.closeBottomSheet();
       HomePageControllers.clear();
          ExpenseDetailsPageController.clear();
        } else {
          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error, // You can use any icon you want here
                  color: Colors.white,
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    "${expenses.message!.toString()}", // Your message
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            behavior: SnackBarBehavior
                .floating, // Optional, makes the snack bar float
            duration: Duration(seconds: 1), // Duration to show the snackbar
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          // AppRouter.showSnackbar(snackBar: snackBar);
        }
      },
    );
  }



  Future<void> _ondeleteExpenseByUuid(
      _deleteExpenseByUuid event, Emitter<ExpenseState> emit) async {
    final result = await expenseService.deleteExpenseByUuid(uuid: event.uuid);

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) {
        //    emit(state.copyWith(
        //   createExpense: expenses,

        // ));

        if (expenses.isvalidated!) {
          //       getIt<ExpenseBloc>().add(ExpenseEvent.getAllAmountExpenses());
          //  getIt<ExpenseBloc>().add(ExpenseEvent.getGroupedExpensesWithTotal());

          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error, // You can use any icon you want here
                  color: Colors.white,
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    "${expenses.message!.toString()}", // Your message
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            behavior: SnackBarBehavior
                .floating, // Optional, makes the snack bar float
            duration: Duration(seconds: 3), // Duration to show the snackbar
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
        // /  AppRouter.showSnackbar(
        //     snackBar: snackBar,
        //   );
    
          // AppRouter.closeBottomSheet();
          ExpenseDetailsPageController.clear();
        } else {
          final snackBar = SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error, // You can use any icon you want here
                  color: Colors.white,
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    "${expenses.message!.toString()}", // Your message
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            behavior: SnackBarBehavior
                .floating, // Optional, makes the snack bar float
            duration: Duration(seconds: 1), // Duration to show the snackbar
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          // AppRouter.showSnackbar(snackBar: snackBar);
        }
      },
    );
  }




  Future<void>_onsercheExpens(_sercheExpens event, Emitter<ExpenseState> emit)async{
emit(state.copyWith(isloading: true));
    final result =
        await expenseService.SercheExpense(Qery: event.serchQery, expTitel: event.expTitel);

    result.fold(
      (failure) => emit(state.copyWith(isloading: false)),
      (expenses) => emit(state.copyWith(
        ExpensesByIdList: expenses,
        isloading: false,
      )),
    );
  }
}
