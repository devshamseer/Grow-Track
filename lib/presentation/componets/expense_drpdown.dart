import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_track/application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart';

import '../../domain/utils/cards/cards_icon_utils.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';

class ExpenseDropdown extends StatelessWidget {
  ExpenseDropdown({super.key});

  // This will hold the selected value (string 'titel' of the selected ExpenseCardModel)
  // String? selectedValue;

  // Text editing controller for the search functionality in the dropdown
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseDropDownMenuBloc, ExpenseDropDownMenuState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: Form(
            child: DropdownButton2<String>(
              enableFeedback: true,
              isExpanded: true,

              hint: Row(
                mainAxisSize: MainAxisSize
                    .min, // Adjusts the width of the row to fit its children
                children: [
                  Image.asset(
                    "${ImageIconPathSet.basePath}/spending.png",
                    width: 30, // Control the width of the image
                    height: 30, // Control the height of the image
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Select Expense',
                    style: TextStyle(
                      fontSize: 16, // Adjust font size here
                      color: AppColors.textColor1,
                    ),
                  ),
                ],
              ),
              // Map over the list of ExpenseCardModel and use the titel (String)
              items: CardIconsUtils.ExpCardData.map(
                  (item) => DropdownMenuItem<String>(
                        value: item.titel, // Use the 'titel' (String) as value
                        child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset(item.imageIcon!), // Show the image
                                SizedBox(width: 8),
                                Text(
                                  item.titel!, // Show the title of the expense
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )).toList(),

              value: state.selectedExpense, // Set the current selected value

              onChanged: (value) {
                // Handle the change in selection

                context.read<ExpenseDropDownMenuBloc>().add(
                    ExpenseDropDownMenuEvent.changeDropdownValue(
                        selectedValue: value!));
                // selectedValue = value;
              },

              buttonStyleData: ButtonStyleData(
                height: 60,
                padding: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.cardColor2,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.cardColor1,
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 50,
                customHeights: List.generate(
                  CardIconsUtils.ExpCardData.length,
                  (index) {
                    // Generate custom heights for each item (based on index)
                    return 65; // 60 for the first item, increment by 20 for each subsequent item
                  },
                ),
              ),

              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        prefixIconColor: Colors.white,
                        filled: true,
                        fillColor: AppColors.cardColor2,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(
                                146, 255, 255, 255)), // hint text color yellow
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.white), // border color white
                        ),
                      ),
                      style:
                          TextStyle(color: Colors.white), // text color yellow
                      cursorColor: Colors.white, // cursor color white
                    )),
                searchMatchFn: (item, searchValue) {
                  // Search functionality based on 'titel' (String) field
                  return item.value
                      .toString()
                      .toLowerCase()
                      .contains(searchValue.toLowerCase());
                },
              ),
              // This clears the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
