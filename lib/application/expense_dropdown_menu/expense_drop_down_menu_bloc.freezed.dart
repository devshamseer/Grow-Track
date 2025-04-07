// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_drop_down_menu_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExpenseDropDownMenuEvent {
  String? get selectedValue => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? selectedValue) changeDropdownValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? selectedValue)? changeDropdownValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? selectedValue)? changeDropdownValue,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_changeDropdownValue value) changeDropdownValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_changeDropdownValue value)? changeDropdownValue,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_changeDropdownValue value)? changeDropdownValue,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpenseDropDownMenuEventCopyWith<ExpenseDropDownMenuEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseDropDownMenuEventCopyWith<$Res> {
  factory $ExpenseDropDownMenuEventCopyWith(ExpenseDropDownMenuEvent value,
          $Res Function(ExpenseDropDownMenuEvent) then) =
      _$ExpenseDropDownMenuEventCopyWithImpl<$Res, ExpenseDropDownMenuEvent>;
  @useResult
  $Res call({String? selectedValue});
}

/// @nodoc
class _$ExpenseDropDownMenuEventCopyWithImpl<$Res,
        $Val extends ExpenseDropDownMenuEvent>
    implements $ExpenseDropDownMenuEventCopyWith<$Res> {
  _$ExpenseDropDownMenuEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedValue = freezed,
  }) {
    return _then(_value.copyWith(
      selectedValue: freezed == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$changeDropdownValueImplCopyWith<$Res>
    implements $ExpenseDropDownMenuEventCopyWith<$Res> {
  factory _$$changeDropdownValueImplCopyWith(_$changeDropdownValueImpl value,
          $Res Function(_$changeDropdownValueImpl) then) =
      __$$changeDropdownValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? selectedValue});
}

/// @nodoc
class __$$changeDropdownValueImplCopyWithImpl<$Res>
    extends _$ExpenseDropDownMenuEventCopyWithImpl<$Res,
        _$changeDropdownValueImpl>
    implements _$$changeDropdownValueImplCopyWith<$Res> {
  __$$changeDropdownValueImplCopyWithImpl(_$changeDropdownValueImpl _value,
      $Res Function(_$changeDropdownValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedValue = freezed,
  }) {
    return _then(_$changeDropdownValueImpl(
      selectedValue: freezed == selectedValue
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$changeDropdownValueImpl
    with DiagnosticableTreeMixin
    implements _changeDropdownValue {
  const _$changeDropdownValueImpl({required this.selectedValue});

  @override
  final String? selectedValue;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExpenseDropDownMenuEvent.changeDropdownValue(selectedValue: $selectedValue)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'ExpenseDropDownMenuEvent.changeDropdownValue'))
      ..add(DiagnosticsProperty('selectedValue', selectedValue));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$changeDropdownValueImpl &&
            (identical(other.selectedValue, selectedValue) ||
                other.selectedValue == selectedValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$changeDropdownValueImplCopyWith<_$changeDropdownValueImpl> get copyWith =>
      __$$changeDropdownValueImplCopyWithImpl<_$changeDropdownValueImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? selectedValue) changeDropdownValue,
  }) {
    return changeDropdownValue(selectedValue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? selectedValue)? changeDropdownValue,
  }) {
    return changeDropdownValue?.call(selectedValue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? selectedValue)? changeDropdownValue,
    required TResult orElse(),
  }) {
    if (changeDropdownValue != null) {
      return changeDropdownValue(selectedValue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_changeDropdownValue value) changeDropdownValue,
  }) {
    return changeDropdownValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_changeDropdownValue value)? changeDropdownValue,
  }) {
    return changeDropdownValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_changeDropdownValue value)? changeDropdownValue,
    required TResult orElse(),
  }) {
    if (changeDropdownValue != null) {
      return changeDropdownValue(this);
    }
    return orElse();
  }
}

abstract class _changeDropdownValue implements ExpenseDropDownMenuEvent {
  const factory _changeDropdownValue({required final String? selectedValue}) =
      _$changeDropdownValueImpl;

  @override
  String? get selectedValue;
  @override
  @JsonKey(ignore: true)
  _$$changeDropdownValueImplCopyWith<_$changeDropdownValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpenseDropDownMenuState {
  String? get selectedExpense => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpenseDropDownMenuStateCopyWith<ExpenseDropDownMenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseDropDownMenuStateCopyWith<$Res> {
  factory $ExpenseDropDownMenuStateCopyWith(ExpenseDropDownMenuState value,
          $Res Function(ExpenseDropDownMenuState) then) =
      _$ExpenseDropDownMenuStateCopyWithImpl<$Res, ExpenseDropDownMenuState>;
  @useResult
  $Res call({String? selectedExpense});
}

/// @nodoc
class _$ExpenseDropDownMenuStateCopyWithImpl<$Res,
        $Val extends ExpenseDropDownMenuState>
    implements $ExpenseDropDownMenuStateCopyWith<$Res> {
  _$ExpenseDropDownMenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedExpense = freezed,
  }) {
    return _then(_value.copyWith(
      selectedExpense: freezed == selectedExpense
          ? _value.selectedExpense
          : selectedExpense // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseDropDownMenuStateImplCopyWith<$Res>
    implements $ExpenseDropDownMenuStateCopyWith<$Res> {
  factory _$$ExpenseDropDownMenuStateImplCopyWith(
          _$ExpenseDropDownMenuStateImpl value,
          $Res Function(_$ExpenseDropDownMenuStateImpl) then) =
      __$$ExpenseDropDownMenuStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? selectedExpense});
}

/// @nodoc
class __$$ExpenseDropDownMenuStateImplCopyWithImpl<$Res>
    extends _$ExpenseDropDownMenuStateCopyWithImpl<$Res,
        _$ExpenseDropDownMenuStateImpl>
    implements _$$ExpenseDropDownMenuStateImplCopyWith<$Res> {
  __$$ExpenseDropDownMenuStateImplCopyWithImpl(
      _$ExpenseDropDownMenuStateImpl _value,
      $Res Function(_$ExpenseDropDownMenuStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedExpense = freezed,
  }) {
    return _then(_$ExpenseDropDownMenuStateImpl(
      selectedExpense: freezed == selectedExpense
          ? _value.selectedExpense
          : selectedExpense // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExpenseDropDownMenuStateImpl
    with DiagnosticableTreeMixin
    implements _ExpenseDropDownMenuState {
  const _$ExpenseDropDownMenuStateImpl({this.selectedExpense});

  @override
  final String? selectedExpense;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExpenseDropDownMenuState(selectedExpense: $selectedExpense)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExpenseDropDownMenuState'))
      ..add(DiagnosticsProperty('selectedExpense', selectedExpense));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseDropDownMenuStateImpl &&
            (identical(other.selectedExpense, selectedExpense) ||
                other.selectedExpense == selectedExpense));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedExpense);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseDropDownMenuStateImplCopyWith<_$ExpenseDropDownMenuStateImpl>
      get copyWith => __$$ExpenseDropDownMenuStateImplCopyWithImpl<
          _$ExpenseDropDownMenuStateImpl>(this, _$identity);
}

abstract class _ExpenseDropDownMenuState implements ExpenseDropDownMenuState {
  const factory _ExpenseDropDownMenuState({final String? selectedExpense}) =
      _$ExpenseDropDownMenuStateImpl;

  @override
  String? get selectedExpense;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseDropDownMenuStateImplCopyWith<_$ExpenseDropDownMenuStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
