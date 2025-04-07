// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../application/expense_bloc/expense_bloc.dart' as _i6;
import '../../../application/expense_dropdown_menu/expense_drop_down_menu_bloc.dart'
    as _i3;
import '../../../infrastructure/expense/expense_impl.dart' as _i5;
import '../../expense/expense_service.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.ExpenseDropDownMenuBloc>(
        () => _i3.ExpenseDropDownMenuBloc());
    gh.lazySingleton<_i4.ExpenseService>(() => _i5.ExpenseImpl());
    gh.factory<_i6.ExpenseBloc>(
        () => _i6.ExpenseBloc(gh<_i4.ExpenseService>()));
    return this;
  }
}
