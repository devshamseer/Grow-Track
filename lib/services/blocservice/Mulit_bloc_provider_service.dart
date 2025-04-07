import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_track/application/expense_bloc/expense_bloc.dart';
import 'package:grow_track/application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart';
import 'package:grow_track/domain/core/dependencies_injection/injectable.dart';

class Mulit_bloc_provider_service extends StatelessWidget {
  Widget child;

  Mulit_bloc_provider_service({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ExpenseBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ExpenseDropDownMenuBloc>(),
        )
      ],
      child: child,
    );
  }
}
