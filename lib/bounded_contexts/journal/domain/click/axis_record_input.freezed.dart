// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'axis_record_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AxisRecordInput {

 LedgerAxisKind get kind; double get enteredValue; String get enteredInId; int get signMultiplier;
/// Create a copy of AxisRecordInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AxisRecordInputCopyWith<AxisRecordInput> get copyWith => _$AxisRecordInputCopyWithImpl<AxisRecordInput>(this as AxisRecordInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AxisRecordInput&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.enteredValue, enteredValue) || other.enteredValue == enteredValue)&&(identical(other.enteredInId, enteredInId) || other.enteredInId == enteredInId)&&(identical(other.signMultiplier, signMultiplier) || other.signMultiplier == signMultiplier));
}


@override
int get hashCode => Object.hash(runtimeType,kind,enteredValue,enteredInId,signMultiplier);

@override
String toString() {
  return 'AxisRecordInput(kind: $kind, enteredValue: $enteredValue, enteredInId: $enteredInId, signMultiplier: $signMultiplier)';
}


}

/// @nodoc
abstract mixin class $AxisRecordInputCopyWith<$Res>  {
  factory $AxisRecordInputCopyWith(AxisRecordInput value, $Res Function(AxisRecordInput) _then) = _$AxisRecordInputCopyWithImpl;
@useResult
$Res call({
 LedgerAxisKind kind, double enteredValue, String enteredInId, int signMultiplier
});




}
/// @nodoc
class _$AxisRecordInputCopyWithImpl<$Res>
    implements $AxisRecordInputCopyWith<$Res> {
  _$AxisRecordInputCopyWithImpl(this._self, this._then);

  final AxisRecordInput _self;
  final $Res Function(AxisRecordInput) _then;

/// Create a copy of AxisRecordInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? enteredValue = null,Object? enteredInId = null,Object? signMultiplier = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerAxisKind,enteredValue: null == enteredValue ? _self.enteredValue : enteredValue // ignore: cast_nullable_to_non_nullable
as double,enteredInId: null == enteredInId ? _self.enteredInId : enteredInId // ignore: cast_nullable_to_non_nullable
as String,signMultiplier: null == signMultiplier ? _self.signMultiplier : signMultiplier // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AxisRecordInput].
extension AxisRecordInputPatterns on AxisRecordInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AxisRecordInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AxisRecordInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AxisRecordInput value)  $default,){
final _that = this;
switch (_that) {
case _AxisRecordInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AxisRecordInput value)?  $default,){
final _that = this;
switch (_that) {
case _AxisRecordInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LedgerAxisKind kind,  double enteredValue,  String enteredInId,  int signMultiplier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AxisRecordInput() when $default != null:
return $default(_that.kind,_that.enteredValue,_that.enteredInId,_that.signMultiplier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LedgerAxisKind kind,  double enteredValue,  String enteredInId,  int signMultiplier)  $default,) {final _that = this;
switch (_that) {
case _AxisRecordInput():
return $default(_that.kind,_that.enteredValue,_that.enteredInId,_that.signMultiplier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LedgerAxisKind kind,  double enteredValue,  String enteredInId,  int signMultiplier)?  $default,) {final _that = this;
switch (_that) {
case _AxisRecordInput() when $default != null:
return $default(_that.kind,_that.enteredValue,_that.enteredInId,_that.signMultiplier);case _:
  return null;

}
}

}

/// @nodoc


class _AxisRecordInput implements AxisRecordInput {
  const _AxisRecordInput({required this.kind, required this.enteredValue, required this.enteredInId, required this.signMultiplier});
  

@override final  LedgerAxisKind kind;
@override final  double enteredValue;
@override final  String enteredInId;
@override final  int signMultiplier;

/// Create a copy of AxisRecordInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AxisRecordInputCopyWith<_AxisRecordInput> get copyWith => __$AxisRecordInputCopyWithImpl<_AxisRecordInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AxisRecordInput&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.enteredValue, enteredValue) || other.enteredValue == enteredValue)&&(identical(other.enteredInId, enteredInId) || other.enteredInId == enteredInId)&&(identical(other.signMultiplier, signMultiplier) || other.signMultiplier == signMultiplier));
}


@override
int get hashCode => Object.hash(runtimeType,kind,enteredValue,enteredInId,signMultiplier);

@override
String toString() {
  return 'AxisRecordInput(kind: $kind, enteredValue: $enteredValue, enteredInId: $enteredInId, signMultiplier: $signMultiplier)';
}


}

/// @nodoc
abstract mixin class _$AxisRecordInputCopyWith<$Res> implements $AxisRecordInputCopyWith<$Res> {
  factory _$AxisRecordInputCopyWith(_AxisRecordInput value, $Res Function(_AxisRecordInput) _then) = __$AxisRecordInputCopyWithImpl;
@override @useResult
$Res call({
 LedgerAxisKind kind, double enteredValue, String enteredInId, int signMultiplier
});




}
/// @nodoc
class __$AxisRecordInputCopyWithImpl<$Res>
    implements _$AxisRecordInputCopyWith<$Res> {
  __$AxisRecordInputCopyWithImpl(this._self, this._then);

  final _AxisRecordInput _self;
  final $Res Function(_AxisRecordInput) _then;

/// Create a copy of AxisRecordInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? enteredValue = null,Object? enteredInId = null,Object? signMultiplier = null,}) {
  return _then(_AxisRecordInput(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerAxisKind,enteredValue: null == enteredValue ? _self.enteredValue : enteredValue // ignore: cast_nullable_to_non_nullable
as double,enteredInId: null == enteredInId ? _self.enteredInId : enteredInId // ignore: cast_nullable_to_non_nullable
as String,signMultiplier: null == signMultiplier ? _self.signMultiplier : signMultiplier // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
