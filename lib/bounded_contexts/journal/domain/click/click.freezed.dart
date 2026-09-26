// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'click.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Click {

 ClickId get id; ClickerId get clickerId; DateTime get at; double get factor; List<AxisContribution> get contributions;
/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClickCopyWith<Click> get copyWith => _$ClickCopyWithImpl<Click>(this as Click, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Click&&(identical(other.id, id) || other.id == id)&&(identical(other.clickerId, clickerId) || other.clickerId == clickerId)&&(identical(other.at, at) || other.at == at)&&(identical(other.factor, factor) || other.factor == factor)&&const DeepCollectionEquality().equals(other.contributions, contributions));
}


@override
int get hashCode => Object.hash(runtimeType,id,clickerId,at,factor,const DeepCollectionEquality().hash(contributions));

@override
String toString() {
  return 'Click(id: $id, clickerId: $clickerId, at: $at, factor: $factor, contributions: $contributions)';
}


}

/// @nodoc
abstract mixin class $ClickCopyWith<$Res>  {
  factory $ClickCopyWith(Click value, $Res Function(Click) _then) = _$ClickCopyWithImpl;
@useResult
$Res call({
 ClickId id, ClickerId clickerId, DateTime at, double factor, List<AxisContribution> contributions
});


$ClickIdCopyWith<$Res> get id;$ClickerIdCopyWith<$Res> get clickerId;

}
/// @nodoc
class _$ClickCopyWithImpl<$Res>
    implements $ClickCopyWith<$Res> {
  _$ClickCopyWithImpl(this._self, this._then);

  final Click _self;
  final $Res Function(Click) _then;

/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clickerId = null,Object? at = null,Object? factor = null,Object? contributions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as ClickId,clickerId: null == clickerId ? _self.clickerId : clickerId // ignore: cast_nullable_to_non_nullable
as ClickerId,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,factor: null == factor ? _self.factor : factor // ignore: cast_nullable_to_non_nullable
as double,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<AxisContribution>,
  ));
}
/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickIdCopyWith<$Res> get id {
  
  return $ClickIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickerIdCopyWith<$Res> get clickerId {
  
  return $ClickerIdCopyWith<$Res>(_self.clickerId, (value) {
    return _then(_self.copyWith(clickerId: value));
  });
}
}


/// Adds pattern-matching-related methods to [Click].
extension ClickPatterns on Click {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Click value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Click() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Click value)  $default,){
final _that = this;
switch (_that) {
case _Click():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Click value)?  $default,){
final _that = this;
switch (_that) {
case _Click() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClickId id,  ClickerId clickerId,  DateTime at,  double factor,  List<AxisContribution> contributions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Click() when $default != null:
return $default(_that.id,_that.clickerId,_that.at,_that.factor,_that.contributions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClickId id,  ClickerId clickerId,  DateTime at,  double factor,  List<AxisContribution> contributions)  $default,) {final _that = this;
switch (_that) {
case _Click():
return $default(_that.id,_that.clickerId,_that.at,_that.factor,_that.contributions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClickId id,  ClickerId clickerId,  DateTime at,  double factor,  List<AxisContribution> contributions)?  $default,) {final _that = this;
switch (_that) {
case _Click() when $default != null:
return $default(_that.id,_that.clickerId,_that.at,_that.factor,_that.contributions);case _:
  return null;

}
}

}

/// @nodoc


class _Click extends Click {
  const _Click({required this.id, required this.clickerId, required this.at, this.factor = 1.0, required this.contributions}): super._();
  

@override final  ClickId id;
@override final  ClickerId clickerId;
@override final  DateTime at;
@override@JsonKey() final  double factor;
@override final  List<AxisContribution> contributions;

/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClickCopyWith<_Click> get copyWith => __$ClickCopyWithImpl<_Click>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Click&&(identical(other.id, id) || other.id == id)&&(identical(other.clickerId, clickerId) || other.clickerId == clickerId)&&(identical(other.at, at) || other.at == at)&&(identical(other.factor, factor) || other.factor == factor)&&const DeepCollectionEquality().equals(other.contributions, contributions));
}


@override
int get hashCode => Object.hash(runtimeType,id,clickerId,at,factor,const DeepCollectionEquality().hash(contributions));

@override
String toString() {
  return 'Click(id: $id, clickerId: $clickerId, at: $at, factor: $factor, contributions: $contributions)';
}


}

/// @nodoc
abstract mixin class _$ClickCopyWith<$Res> implements $ClickCopyWith<$Res> {
  factory _$ClickCopyWith(_Click value, $Res Function(_Click) _then) = __$ClickCopyWithImpl;
@override @useResult
$Res call({
 ClickId id, ClickerId clickerId, DateTime at, double factor, List<AxisContribution> contributions
});


@override $ClickIdCopyWith<$Res> get id;@override $ClickerIdCopyWith<$Res> get clickerId;

}
/// @nodoc
class __$ClickCopyWithImpl<$Res>
    implements _$ClickCopyWith<$Res> {
  __$ClickCopyWithImpl(this._self, this._then);

  final _Click _self;
  final $Res Function(_Click) _then;

/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clickerId = null,Object? at = null,Object? factor = null,Object? contributions = null,}) {
  return _then(_Click(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as ClickId,clickerId: null == clickerId ? _self.clickerId : clickerId // ignore: cast_nullable_to_non_nullable
as ClickerId,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,factor: null == factor ? _self.factor : factor // ignore: cast_nullable_to_non_nullable
as double,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<AxisContribution>,
  ));
}

/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickIdCopyWith<$Res> get id {
  
  return $ClickIdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of Click
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickerIdCopyWith<$Res> get clickerId {
  
  return $ClickerIdCopyWith<$Res>(_self.clickerId, (value) {
    return _then(_self.copyWith(clickerId: value));
  });
}
}

// dart format on
