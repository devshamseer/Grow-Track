import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grow_track/application/expense_bloc/expense_bloc.dart';
import 'package:grow_track/application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart';
import 'package:grow_track/domain/db/model/expense.dart';
import 'package:grow_track/domain/expense/models/expense_card_model/expense_card_model.dart';
import 'package:grow_track/domain/utils/validates/validate.dart';
import 'package:grow_track/presentation/componets/expense_drpdown.dart';
import 'package:grow_track/presentation/home/controllers/home_controllers.dart';
import 'package:grow_track/presentation/widgets/bootom_sheet_widget.dart';
import 'package:grow_track/theme/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:grow_track/theme/app_icons.dart';
import 'package:uuid/uuid.dart';
import '../../domain/utils/cards/cards_icon_utils.dart';
import '../widgets/text_filed_wdget.dart';

void createExpenseBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    elevation: 0,
     useRootNavigator: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true, // Ensures the height is flexible
    context: context,
    builder: (BuildContext context) {
      return BottomSheetExpenseWidget.ConditionBasedSheet(condition: BottomSheetExpenseConditons.customCreateExpense(titelController:HomePageControllers.titelController, descriptionController:HomePageControllers. descriptionController, amountController:HomePageControllers. amountController));
    },
  );
}
