

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grow_track/domain/utils/cards/cards_icon_utils.dart';
import 'package:grow_track/objectbox.g.dart';
import 'package:grow_track/presentation/componets/expense_drpdown.dart';
import 'package:grow_track/presentation/expense_details/controller/expense_details_controller.dart';
import 'package:grow_track/presentation/expense_details/expense_details_page.dart';
import 'package:grow_track/presentation/widgets/text_filed_wdget.dart';
import 'package:objectbox/objectbox.dart';

import '../../application/expense_bloc/expense_bloc.dart';
import '../../application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart';
import '../../theme/app_colors.dart';
import '../home/controllers/home_controllers.dart';

class BottomSheetExpenseConditons {
  final String title;
  final String buttonText;
  final bool showDropdown;
  final bool showContent;

  final String? expTitel;
  
 final TextEditingController titelController;
 
 final TextEditingController descriptionController;
  
 final TextEditingController amountController;
 
final String? expId;

  const BottomSheetExpenseConditons({
    required this.title,
    required this.buttonText,
    required this.showDropdown,
    required this.showContent,
    
    this.expTitel,
    this.expId,
    required this.titelController,
    required this.descriptionController,
    required this.amountController,

  });

  static customCreateExpense({required TextEditingController titelController, required TextEditingController descriptionController, required TextEditingController amountController}) {
    return BottomSheetExpenseConditons(
      title: "Create Expense",
      buttonText: "Save",
      showDropdown: true,
      showContent: true, titelController: titelController, descriptionController: descriptionController, amountController: amountController
    );
  }

  static idBasedCreateExpense({required String expTitel, required TextEditingController titelController, required TextEditingController descriptionController, required TextEditingController amountController}) {
    return BottomSheetExpenseConditons(
        title: "Create Expense ID Based",
        buttonText: "Save",
        showDropdown: false,
        showContent: true,
        expTitel: expTitel, titelController: titelController, descriptionController: descriptionController, amountController: amountController);
  }

  static updateBasedCreateExpense({ required TextEditingController titelController, required TextEditingController descriptionController, required TextEditingController amountController, required expId,required expTitel}) {
    return BottomSheetExpenseConditons(
      title: "Update Expense",
      buttonText: "Update",
      showDropdown: false,
      expId: expId,
      expTitel: expTitel,
      showContent: true, titelController: titelController, descriptionController: descriptionController, amountController: amountController
    );
  }
}

class BottomSheetExpenseWidget {
  static ConditionBasedSheet({required BottomSheetExpenseConditons condition}) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DraggableScrollableSheet(
        initialChildSize: 1, // Initial size of the sheet
        minChildSize: 0.8, // Minimum size the sheet can shrink to
        maxChildSize: 1, // Maximum size the sheet can expand to
        builder: (BuildContext context, ScrollController scrollController) {
          if (!condition.showDropdown) {
            context.read<ExpenseDropDownMenuBloc>().add(
                ExpenseDropDownMenuEvent.changeDropdownValue(
                    selectedValue: condition.expTitel!));
          }
          return Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor, // Your custom background color
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 5),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          condition.title,
                          style: GoogleFonts.getFont('Maven Pro',
                              color: AppColors.textColor1,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (condition.showContent) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldHeadingWidget(
                              title: "Title",
                              hintText: 'Enter Title',
                              controller:condition.titelController ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldHeadingWidget(
                              title: "Description",
                              hintText: 'Enter description',
                              controller:
                                  condition.descriptionController),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldHeadingWidget(
                              isAmountField: true,
                              title: "Expense amount",
                              hintText: 'Amount',
                              controller: condition.amountController),
                        ),
                        if (condition.showDropdown) ...{
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpenseDropdown(),
                          ),
                        } else ...{
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 11, right: 11, top: 12),
                            child: Container(
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.cardColor2,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Image.asset(
                                    CardIconsUtils.getImageIconByTitle(
                                            title:
                                                condition.expTitel.toString())
                                        .toString(),
                                    width: 29,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "${condition.expTitel.toString()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        }
                      ],
                    ],
                  ),
                ),
                BlocListener<ExpenseBloc, ExpenseState>(
                  listener: (blocContext, state) {
                    debugPrint('ExpenseBloc state changed: $state');
                    // HomePageControllers.ValidationAllerts(
                    //     succsesStatus: state,
                    //     context: context,
                    //     blocContex: blocContext);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CupertinoButton(
                            disabledColor: AppColors.cardColor1,
                            color: Colors.white,
                            child: Text(
                              condition.buttonText,
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              if (condition.title == "Create Expense") {
                                HomePageControllers.createExpenseActon(
                                    context: context);
                              } else if (condition.title ==
                                  "Create Expense ID Based") {
                                  ExpenseDetailsPageController.createExpenseActon(
                                    context: context);
                              } else if (condition.title == "Update Expense") {

                                 ExpenseDetailsPageController.updateExpenseById(context: context, expId:condition.expId);
                              }
                            }),
                      ) 
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
