import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/utils/cards/cards_icon_utils.dart';

part 'expense_drop_down_menu_event.dart';
part 'expense_drop_down_menu_state.dart';
part 'expense_drop_down_menu_bloc.freezed.dart';

@injectable
class ExpenseDropDownMenuBloc
    extends Bloc<ExpenseDropDownMenuEvent, ExpenseDropDownMenuState> {
  ExpenseDropDownMenuBloc() : super(ExpenseDropDownMenuState.initial()) {
    on<_changeDropdownValue>((event, emit) {
      log(event.selectedValue!);
      emit(state.copyWith(selectedExpense: event.selectedValue));
    });
  }
}
