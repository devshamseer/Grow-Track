
import 'package:flutter/material.dart';
import 'package:grow_track/presentation/expense_details/controller/expense_details_controller.dart';

import '../../widgets/bootom_sheet_widget.dart';

import 'package:flutter/material.dart';
import '../../widgets/bootom_sheet_widget.dart';

void createExpenseBottomSheetById({required BuildContext context, required String expTitel}) {
  // Declare the PersistentBottomSheetController
  PersistentBottomSheetController? bottomSheetController;

  // Show the bottom sheet
showModalBottomSheet(
    elevation: 0,
    useRootNavigator: false,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true, // Ensures the height is flexible
    context: context,
    builder: (BuildContext context) {
      return BottomSheetExpenseWidget.ConditionBasedSheet(
        condition: BottomSheetExpenseConditons.idBasedCreateExpense(expTitel: expTitel, titelController: ExpenseDetailsPageController.titelController, descriptionController:ExpenseDetailsPageController. descriptionController, amountController:ExpenseDetailsPageController. amountController),
      );
    },
  ) ;

}
 