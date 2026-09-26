// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_balances.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeriodBalances {

 Map<LedgerAxisKind, SignedBaseDelta> get totalsInBase;
/// Create a copy of PeriodBalances
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodBalancesCopyWith<PeriodBalances> get copyWith => _$PeriodBalancesCopyWithImpl<PeriodBalances>(this as PeriodBalances, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodBalances&&const DeepCollectionEquality().equals(other.totalsInBase, totalsInBase));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(totalsInBase));

@override
String toString() {
  return 'PeriodBalances(totalsInBase: $totalsInBase)';
}


}

/// @nodoc
abstract mixin class $PeriodBalancesCopyWith<$Res>  {
  factory $PeriodBalancesCopyWith(PeriodBalances value, $Res Function(PeriodBalances) _then) = _$PeriodBalancesCopyWithImpl;
@useResult
$Res call({
 Map<LedgerAxisKind, SignedBaseDelta> totalsInBase
});




}
/// @nodoc
class _$PeriodBalancesCopyWithImpl<$Res>
    implements $PeriodBalancesCopyWith<$Res> {
  _$PeriodBalancesCopyWithImpl(this._self, this._then);

  final PeriodBalances _self;
  final $Res Function(PeriodBalances) _then;

/// Create a copy of PeriodBalances
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalsInBase = null,}) {
  return _then(_self.copyWith(
totalsInBase: null == totalsInBase ? _self.totalsInBase : totalsInBase // ignore: cast_nullable_to_non_nullable
as Map<LedgerAxisKind, SignedBaseDelta>,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodBalances].
extension PeriodBalancesPatterns on PeriodBalances {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodBalances value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodBalances() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodBalances value)  $default,){
final _that = this;
switch (_that) {
case _PeriodBalances():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodBalances value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodBalances() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<LedgerAxisKind, SignedBaseDelta> totalsInBase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodBalances() when $default != null:
return $default(_that.totalsInBase);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<LedgerAxisKind, SignedBaseDelta> totalsInBase)  $default,) {final _that = this;
switch (_that) {
case _PeriodBalances():
return $default(_that.totalsInBase);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<LedgerAxisKind, SignedBaseDelta> totalsInBase)?  $default,) {final _that = this;
switch (_that) {
case _PeriodBalances() when $default != null:
return $default(_that.totalsInBase);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodBalances extends PeriodBalances {
  const _PeriodBalances({required this.totalsInBase}): super._();
  

@override final  Map<LedgerAxisKind, SignedBaseDelta> totalsInBase;

/// Create a copy of PeriodBalances
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodBalancesCopyWith<_PeriodBalances> get copyWith => __$PeriodBalancesCopyWithImpl<_PeriodBalances>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodBalances&&const DeepCollectionEquality().equals(other.totalsInBase, totalsInBase));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(totalsInBase));

@override
String toString() {
  return 'PeriodBalances(totalsInBase: $totalsInBase)';
}


}

/// @nodoc
abstract mixin class _$PeriodBalancesCopyWith<$Res> implements $PeriodBalancesCopyWith<$Res> {
  factory _$PeriodBalancesCopyWith(_PeriodBalances value, $Res Function(_PeriodBalances) _then) = __$PeriodBalancesCopyWithImpl;
@override @useResult
$Res call({
 Map<LedgerAxisKind, SignedBaseDelta> totalsInBase
});




}
/// @nodoc
class __$PeriodBalancesCopyWithImpl<$Res>
    implements _$PeriodBalancesCopyWith<$Res> {
  __$PeriodBalancesCopyWithImpl(this._self, this._then);

  final _PeriodBalances _self;
  final $Res Function(_PeriodBalances) _then;

/// Create a copy of PeriodBalances
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalsInBase = null,}) {
  return _then(_PeriodBalances(
totalsInBase: null == totalsInBase ? _self.totalsInBase : totalsInBase // ignore: cast_nullable_to_non_nullable
as Map<LedgerAxisKind, SignedBaseDelta>,
  ));
}


}

// dart format on
