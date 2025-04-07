
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_track/GoRouter/gorouter.dart';
import 'package:uuid/uuid.dart';

import '../../../application/expense_bloc/expense_bloc.dart';
import '../../../application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart';
import '../../../domain/db/model/expense.dart';

class ExpenseDetailsPageController {
  static TextEditingController titelController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController amountController = TextEditingController();

  static createExpenseActon({required BuildContext? context}) {
    final selectedValue =
        context!.read<ExpenseDropDownMenuBloc>().state.selectedExpense;

    log("Createtion functon");

    final cexpens = Expense(
        uuid: Uuid().v4().toString(),
        title: ExpenseDetailsPageController.titelController.text.trim() ?? "",
        description:
            ExpenseDetailsPageController.descriptionController.text.trim() ?? "",
        expTitel: selectedValue.toString() ?? "",
        amount:
            double.tryParse(ExpenseDetailsPageController.amountController.text.trim()) ??
                0.0,
        createdDate: DateTime.now().toString(),
        sync: false);

    context
        .read<ExpenseBloc>()
        .add(ExpenseEvent.createExpense(createExpense: cexpens));
    //  AppRouter.closeBottomSheet();
    context.read<ExpenseBloc>().add(ExpenseEvent.getExpensesByIdList(expTitel: selectedValue.toString()));
        context.read<ExpenseBloc>().add(ExpenseEvent.getTottelAmountExpensesById(expTitel: selectedValue.toString()));
    context.read<ExpenseBloc>().add(ExpenseEvent.getAllAmountExpenses());


  }



  static updateExpenseById({required BuildContext? context,required expId}){
        final selectedValue =
        context!.read<ExpenseDropDownMenuBloc>().state.selectedExpense;

    log("update functon");

    final cexpens = Expense(
        uuid: Uuid().v4().toString(),
        title: ExpenseDetailsPageController.titelController.text.trim() ?? "",
        description:
            ExpenseDetailsPageController.descriptionController.text.trim() ?? "",
        expTitel: selectedValue.toString() ?? "",
        amount:
            double.tryParse(ExpenseDetailsPageController.amountController.text.trim()) ??
                0.0,
        createdDate: DateTime.now().toString(),
        sync: false);

    context
        .read<ExpenseBloc>()
        .add(ExpenseEvent.updateExpenseById(expId:expId ,updateExpense: cexpens,));
    //  AppRouter.closeBottomSheet();
    context.read<ExpenseBloc>().add(ExpenseEvent.getExpensesByIdList(expTitel: selectedValue.toString()));
        context.read<ExpenseBloc>().add(ExpenseEvent.getTottelAmountExpensesById(expTitel: selectedValue.toString()));
    context.read<ExpenseBloc>().add(ExpenseEvent.getAllAmountExpenses());

  }

  static clear() {
    titelController.text="";
    descriptionController.text="";
    amountController.text="";
    

      AppRouter.currentStateContext()!.read<ExpenseDropDownMenuBloc>().add(ExpenseDropDownMenuEvent.changeDropdownValue(selectedValue: null));
  
  }
}
