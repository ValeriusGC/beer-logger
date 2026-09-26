// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clicker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Clicker {

 ClickerId get id; String get title; List<LedgerAxis> get axes;
/// Create a copy of Clicker
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClickerCopyWith<Clicker> get copyWith => _$ClickerCopyWithImpl<Clicker>(this as Clicker, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Clicker&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.axes, axes));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(axes));

@override
String toString() {
  return 'Clicker(id: $id, title: $title, axes: $axes)';
}


}

/// @nodoc
abstract mixin class $ClickerCopyWith<$Res>  {
  factory $ClickerCopyWith(Clicker value, $Res Function(Clicker) _then) = _$ClickerCopyWithImpl;
@useResult
$Res call({
 ClickerId id, String title, List<LedgerAxis> axes
});


$ClickerIdCopyWith<$Res> get id;

}
/// @nodoc
class _$ClickerCopyWithImpl<$Res>
    implements $ClickerCopyWith<$Res> {
  _$ClickerCopyWithImpl(this._self, this._then);

  final Clicker _self;
  final $Res Function(Clicker) _then;

/// Create a copy of Clicker
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? axes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as ClickerId,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,axes: null == axes ? _self.axes : axes // ignore: cast_nullable_to_non_nullable
as List<LedgerAxis>,
  ));
}
/// Create a copy of Clicker
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickerIdCopyWith<$Res> get id {
  
  return $ClickerIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}
}


/// Adds pattern-matching-related methods to [Clicker].
extension ClickerPatterns on Clicker {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Clicker value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Clicker() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Clicker value)  $default,){
final _that = this;
switch (_that) {
case _Clicker():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Clicker value)?  $default,){
final _that = this;
switch (_that) {
case _Clicker() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClickerId id,  String title,  List<LedgerAxis> axes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Clicker() when $default != null:
return $default(_that.id,_that.title,_that.axes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClickerId id,  String title,  List<LedgerAxis> axes)  $default,) {final _that = this;
switch (_that) {
case _Clicker():
return $default(_that.id,_that.title,_that.axes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClickerId id,  String title,  List<LedgerAxis> axes)?  $default,) {final _that = this;
switch (_that) {
case _Clicker() when $default != null:
return $default(_that.id,_that.title,_that.axes);case _:
  return null;

}
}

}

/// @nodoc


class _Clicker implements Clicker {
  const _Clicker({required this.id, required this.title, required this.axes});
  

@override final  ClickerId id;
@override final  String title;
@override final  List<LedgerAxis> axes;

/// Create a copy of Clicker
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClickerCopyWith<_Clicker> get copyWith => __$ClickerCopyWithImpl<_Clicker>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Clicker&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.axes, axes));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(axes));

@override
String toString() {
  return 'Clicker(id: $id, title: $title, axes: $axes)';
}


}

/// @nodoc
abstract mixin class _$ClickerCopyWith<$Res> implements $ClickerCopyWith<$Res> {
  factory _$ClickerCopyWith(_Clicker value, $Res Function(_Clicker) _then) = __$ClickerCopyWithImpl;
@override @useResult
$Res call({
 ClickerId id, String title, List<LedgerAxis> axes
});


@override $ClickerIdCopyWith<$Res> get id;

}
/// @nodoc
class __$ClickerCopyWithImpl<$Res>
    implements _$ClickerCopyWith<$Res> {
  __$ClickerCopyWithImpl(this._self, this._then);

  final _Clicker _self;
  final $Res Function(_Clicker) _then;

/// Create a copy of Clicker
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? axes = null,}) {
  return _then(_Clicker(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as ClickerId,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,axes: null == axes ? _self.axes : axes // ignore: cast_nullable_to_non_nullable
as List<LedgerAxis>,
  ));
}

/// Create a copy of Clicker
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickerIdCopyWith<$Res> get id {
  
  return $ClickerIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}
}

// dart format on
