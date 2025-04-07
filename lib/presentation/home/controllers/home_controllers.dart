import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_track/GoRouter/gorouter.dart';
import 'package:uuid/uuid.dart';

import '../../../application/expense_bloc/expense_bloc.dart';
import '../../../application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart';
import '../../../domain/db/model/expense.dart';
import '../../../domain/utils/validates/validate.dart';

class HomePageControllers {
  static TextEditingController titelController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController amountController = TextEditingController();

  static createExpenseActon({required BuildContext? context}) {
    final selectedValue =
        context!.read<ExpenseDropDownMenuBloc>().state.selectedExpense;

    log("Createtion functon");

    final cexpens = Expense(
        uuid: Uuid().v4().toString(),
        title: HomePageControllers.titelController.text.trim() ?? "",
        description:
            HomePageControllers.descriptionController.text.trim() ?? "",
        expTitel: selectedValue.toString() ?? "",
        amount:
            double.tryParse(HomePageControllers.amountController.text.trim()) ??
                0.0,
        createdDate: DateTime.now().toString(),
        sync: false);

    context
        .read<ExpenseBloc>()
        .add(ExpenseEvent.createExpense(createExpense: cexpens));
    //  AppRouter.closeBottomSheet();
    context.read<ExpenseBloc>().add(ExpenseEvent.getGroupedExpensesWithTotal());
    context.read<ExpenseBloc>().add(ExpenseEvent.getAllAmountExpenses());
  }

  static clear() {
    titelController.text="";
    descriptionController.text="";
    amountController.text="";
    

      AppRouter.currentStateContext()!.read<ExpenseDropDownMenuBloc>().add(ExpenseDropDownMenuEvent.changeDropdownValue(selectedValue: null));
  
  }
}
