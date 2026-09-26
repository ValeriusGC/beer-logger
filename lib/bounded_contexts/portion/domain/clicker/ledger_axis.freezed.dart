// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_axis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerAxis {

 LedgerAxisKind get kind; double get enteredValue; String get enteredInId; AxisSign get sign;
/// Create a copy of LedgerAxis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerAxisCopyWith<LedgerAxis> get copyWith => _$LedgerAxisCopyWithImpl<LedgerAxis>(this as LedgerAxis, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerAxis&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.enteredValue, enteredValue) || other.enteredValue == enteredValue)&&(identical(other.enteredInId, enteredInId) || other.enteredInId == enteredInId)&&(identical(other.sign, sign) || other.sign == sign));
}


@override
int get hashCode => Object.hash(runtimeType,kind,enteredValue,enteredInId,sign);

@override
String toString() {
  return 'LedgerAxis(kind: $kind, enteredValue: $enteredValue, enteredInId: $enteredInId, sign: $sign)';
}


}

/// @nodoc
abstract mixin class $LedgerAxisCopyWith<$Res>  {
  factory $LedgerAxisCopyWith(LedgerAxis value, $Res Function(LedgerAxis) _then) = _$LedgerAxisCopyWithImpl;
@useResult
$Res call({
 LedgerAxisKind kind, double enteredValue, String enteredInId, AxisSign sign
});




}
/// @nodoc
class _$LedgerAxisCopyWithImpl<$Res>
    implements $LedgerAxisCopyWith<$Res> {
  _$LedgerAxisCopyWithImpl(this._self, this._then);

  final LedgerAxis _self;
  final $Res Function(LedgerAxis) _then;

/// Create a copy of LedgerAxis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? enteredValue = null,Object? enteredInId = null,Object? sign = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerAxisKind,enteredValue: null == enteredValue ? _self.enteredValue : enteredValue // ignore: cast_nullable_to_non_nullable
as double,enteredInId: null == enteredInId ? _self.enteredInId : enteredInId // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as AxisSign,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerAxis].
extension LedgerAxisPatterns on LedgerAxis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerAxis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerAxis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerAxis value)  $default,){
final _that = this;
switch (_that) {
case _LedgerAxis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerAxis value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerAxis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LedgerAxisKind kind,  double enteredValue,  String enteredInId,  AxisSign sign)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerAxis() when $default != null:
return $default(_that.kind,_that.enteredValue,_that.enteredInId,_that.sign);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LedgerAxisKind kind,  double enteredValue,  String enteredInId,  AxisSign sign)  $default,) {final _that = this;
switch (_that) {
case _LedgerAxis():
return $default(_that.kind,_that.enteredValue,_that.enteredInId,_that.sign);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LedgerAxisKind kind,  double enteredValue,  String enteredInId,  AxisSign sign)?  $default,) {final _that = this;
switch (_that) {
case _LedgerAxis() when $default != null:
return $default(_that.kind,_that.enteredValue,_that.enteredInId,_that.sign);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerAxis implements LedgerAxis {
  const _LedgerAxis({required this.kind, required this.enteredValue, required this.enteredInId, required this.sign});
  

@override final  LedgerAxisKind kind;
@override final  double enteredValue;
@override final  String enteredInId;
@override final  AxisSign sign;

/// Create a copy of LedgerAxis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerAxisCopyWith<_LedgerAxis> get copyWith => __$LedgerAxisCopyWithImpl<_LedgerAxis>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerAxis&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.enteredValue, enteredValue) || other.enteredValue == enteredValue)&&(identical(other.enteredInId, enteredInId) || other.enteredInId == enteredInId)&&(identical(other.sign, sign) || other.sign == sign));
}


@override
int get hashCode => Object.hash(runtimeType,kind,enteredValue,enteredInId,sign);

@override
String toString() {
  return 'LedgerAxis(kind: $kind, enteredValue: $enteredValue, enteredInId: $enteredInId, sign: $sign)';
}


}

/// @nodoc
abstract mixin class _$LedgerAxisCopyWith<$Res> implements $LedgerAxisCopyWith<$Res> {
  factory _$LedgerAxisCopyWith(_LedgerAxis value, $Res Function(_LedgerAxis) _then) = __$LedgerAxisCopyWithImpl;
@override @useResult
$Res call({
 LedgerAxisKind kind, double enteredValue, String enteredInId, AxisSign sign
});




}
/// @nodoc
class __$LedgerAxisCopyWithImpl<$Res>
    implements _$LedgerAxisCopyWith<$Res> {
  __$LedgerAxisCopyWithImpl(this._self, this._then);

  final _LedgerAxis _self;
  final $Res Function(_LedgerAxis) _then;

/// Create a copy of LedgerAxis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? enteredValue = null,Object? enteredInId = null,Object? sign = null,}) {
  return _then(_LedgerAxis(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerAxisKind,enteredValue: null == enteredValue ? _self.enteredValue : enteredValue // ignore: cast_nullable_to_non_nullable
as double,enteredInId: null == enteredInId ? _self.enteredInId : enteredInId // ignore: cast_nullable_to_non_nullable
as String,sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as AxisSign,
  ));
}


}

// dart format on
