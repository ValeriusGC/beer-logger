// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'click_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClickId {

 String get value;
/// Create a copy of ClickId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClickIdCopyWith<ClickId> get copyWith => _$ClickIdCopyWithImpl<ClickId>(this as ClickId, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClickId&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ClickId(value: $value)';
}


}

/// @nodoc
abstract mixin class $ClickIdCopyWith<$Res>  {
  factory $ClickIdCopyWith(ClickId value, $Res Function(ClickId) _then) = _$ClickIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$ClickIdCopyWithImpl<$Res>
    implements $ClickIdCopyWith<$Res> {
  _$ClickIdCopyWithImpl(this._self, this._then);

  final ClickId _self;
  final $Res Function(ClickId) _then;

/// Create a copy of ClickId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClickId].
extension ClickIdPatterns on ClickId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ClickId value)?  known,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClickId() when known != null:
return known(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ClickId value)  known,}){
final _that = this;
switch (_that) {
case _ClickId():
return known(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ClickId value)?  known,}){
final _that = this;
switch (_that) {
case _ClickId() when known != null:
return known(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  known,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClickId() when known != null:
return known(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  known,}) {final _that = this;
switch (_that) {
case _ClickId():
return known(_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  known,}) {final _that = this;
switch (_that) {
case _ClickId() when known != null:
return known(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _ClickId extends ClickId {
  const _ClickId(this.value): super._();
  

@override final  String value;

/// Create a copy of ClickId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClickIdCopyWith<_ClickId> get copyWith => __$ClickIdCopyWithImpl<_ClickId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClickId&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ClickId.known(value: $value)';
}


}

/// @nodoc
abstract mixin class _$ClickIdCopyWith<$Res> implements $ClickIdCopyWith<$Res> {
  factory _$ClickIdCopyWith(_ClickId value, $Res Function(_ClickId) _then) = __$ClickIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$ClickIdCopyWithImpl<$Res>
    implements _$ClickIdCopyWith<$Res> {
  __$ClickIdCopyWithImpl(this._self, this._then);

  final _ClickId _self;
  final $Res Function(_ClickId) _then;

/// Create a copy of ClickId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_ClickId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
