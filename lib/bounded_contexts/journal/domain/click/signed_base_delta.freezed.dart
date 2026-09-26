// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_base_delta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignedBaseDelta {

 double get signedBase;
/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignedBaseDeltaCopyWith<SignedBaseDelta> get copyWith => _$SignedBaseDeltaCopyWithImpl<SignedBaseDelta>(this as SignedBaseDelta, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedBaseDelta&&(identical(other.signedBase, signedBase) || other.signedBase == signedBase));
}


@override
int get hashCode => Object.hash(runtimeType,signedBase);

@override
String toString() {
  return 'SignedBaseDelta(signedBase: $signedBase)';
}


}

/// @nodoc
abstract mixin class $SignedBaseDeltaCopyWith<$Res>  {
  factory $SignedBaseDeltaCopyWith(SignedBaseDelta value, $Res Function(SignedBaseDelta) _then) = _$SignedBaseDeltaCopyWithImpl;
@useResult
$Res call({
 double signedBase
});




}
/// @nodoc
class _$SignedBaseDeltaCopyWithImpl<$Res>
    implements $SignedBaseDeltaCopyWith<$Res> {
  _$SignedBaseDeltaCopyWithImpl(this._self, this._then);

  final SignedBaseDelta _self;
  final $Res Function(SignedBaseDelta) _then;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signedBase = null,}) {
  return _then(_self.copyWith(
signedBase: null == signedBase ? _self.signedBase : signedBase // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SignedBaseDelta].
extension SignedBaseDeltaPatterns on SignedBaseDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VolumeDelta value)?  volume,TResult Function( EnergyDelta value)?  energy,TResult Function( MoneyDelta value)?  money,TResult Function( JoyDelta value)?  joy,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VolumeDelta() when volume != null:
return volume(_that);case EnergyDelta() when energy != null:
return energy(_that);case MoneyDelta() when money != null:
return money(_that);case JoyDelta() when joy != null:
return joy(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VolumeDelta value)  volume,required TResult Function( EnergyDelta value)  energy,required TResult Function( MoneyDelta value)  money,required TResult Function( JoyDelta value)  joy,}){
final _that = this;
switch (_that) {
case VolumeDelta():
return volume(_that);case EnergyDelta():
return energy(_that);case MoneyDelta():
return money(_that);case JoyDelta():
return joy(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VolumeDelta value)?  volume,TResult? Function( EnergyDelta value)?  energy,TResult? Function( MoneyDelta value)?  money,TResult? Function( JoyDelta value)?  joy,}){
final _that = this;
switch (_that) {
case VolumeDelta() when volume != null:
return volume(_that);case EnergyDelta() when energy != null:
return energy(_that);case MoneyDelta() when money != null:
return money(_that);case JoyDelta() when joy != null:
return joy(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double signedBase)?  volume,TResult Function( double signedBase)?  energy,TResult Function( double signedBase)?  money,TResult Function( double signedBase)?  joy,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VolumeDelta() when volume != null:
return volume(_that.signedBase);case EnergyDelta() when energy != null:
return energy(_that.signedBase);case MoneyDelta() when money != null:
return money(_that.signedBase);case JoyDelta() when joy != null:
return joy(_that.signedBase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double signedBase)  volume,required TResult Function( double signedBase)  energy,required TResult Function( double signedBase)  money,required TResult Function( double signedBase)  joy,}) {final _that = this;
switch (_that) {
case VolumeDelta():
return volume(_that.signedBase);case EnergyDelta():
return energy(_that.signedBase);case MoneyDelta():
return money(_that.signedBase);case JoyDelta():
return joy(_that.signedBase);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double signedBase)?  volume,TResult? Function( double signedBase)?  energy,TResult? Function( double signedBase)?  money,TResult? Function( double signedBase)?  joy,}) {final _that = this;
switch (_that) {
case VolumeDelta() when volume != null:
return volume(_that.signedBase);case EnergyDelta() when energy != null:
return energy(_that.signedBase);case MoneyDelta() when money != null:
return money(_that.signedBase);case JoyDelta() when joy != null:
return joy(_that.signedBase);case _:
  return null;

}
}

}

/// @nodoc


class VolumeDelta extends SignedBaseDelta {
  const VolumeDelta(this.signedBase): super._();
  

@override final  double signedBase;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VolumeDeltaCopyWith<VolumeDelta> get copyWith => _$VolumeDeltaCopyWithImpl<VolumeDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VolumeDelta&&(identical(other.signedBase, signedBase) || other.signedBase == signedBase));
}


@override
int get hashCode => Object.hash(runtimeType,signedBase);

@override
String toString() {
  return 'SignedBaseDelta.volume(signedBase: $signedBase)';
}


}

/// @nodoc
abstract mixin class $VolumeDeltaCopyWith<$Res> implements $SignedBaseDeltaCopyWith<$Res> {
  factory $VolumeDeltaCopyWith(VolumeDelta value, $Res Function(VolumeDelta) _then) = _$VolumeDeltaCopyWithImpl;
@override @useResult
$Res call({
 double signedBase
});




}
/// @nodoc
class _$VolumeDeltaCopyWithImpl<$Res>
    implements $VolumeDeltaCopyWith<$Res> {
  _$VolumeDeltaCopyWithImpl(this._self, this._then);

  final VolumeDelta _self;
  final $Res Function(VolumeDelta) _then;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signedBase = null,}) {
  return _then(VolumeDelta(
null == signedBase ? _self.signedBase : signedBase // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class EnergyDelta extends SignedBaseDelta {
  const EnergyDelta(this.signedBase): super._();
  

@override final  double signedBase;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnergyDeltaCopyWith<EnergyDelta> get copyWith => _$EnergyDeltaCopyWithImpl<EnergyDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnergyDelta&&(identical(other.signedBase, signedBase) || other.signedBase == signedBase));
}


@override
int get hashCode => Object.hash(runtimeType,signedBase);

@override
String toString() {
  return 'SignedBaseDelta.energy(signedBase: $signedBase)';
}


}

/// @nodoc
abstract mixin class $EnergyDeltaCopyWith<$Res> implements $SignedBaseDeltaCopyWith<$Res> {
  factory $EnergyDeltaCopyWith(EnergyDelta value, $Res Function(EnergyDelta) _then) = _$EnergyDeltaCopyWithImpl;
@override @useResult
$Res call({
 double signedBase
});




}
/// @nodoc
class _$EnergyDeltaCopyWithImpl<$Res>
    implements $EnergyDeltaCopyWith<$Res> {
  _$EnergyDeltaCopyWithImpl(this._self, this._then);

  final EnergyDelta _self;
  final $Res Function(EnergyDelta) _then;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signedBase = null,}) {
  return _then(EnergyDelta(
null == signedBase ? _self.signedBase : signedBase // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class MoneyDelta extends SignedBaseDelta {
  const MoneyDelta(this.signedBase): super._();
  

@override final  double signedBase;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoneyDeltaCopyWith<MoneyDelta> get copyWith => _$MoneyDeltaCopyWithImpl<MoneyDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoneyDelta&&(identical(other.signedBase, signedBase) || other.signedBase == signedBase));
}


@override
int get hashCode => Object.hash(runtimeType,signedBase);

@override
String toString() {
  return 'SignedBaseDelta.money(signedBase: $signedBase)';
}


}

/// @nodoc
abstract mixin class $MoneyDeltaCopyWith<$Res> implements $SignedBaseDeltaCopyWith<$Res> {
  factory $MoneyDeltaCopyWith(MoneyDelta value, $Res Function(MoneyDelta) _then) = _$MoneyDeltaCopyWithImpl;
@override @useResult
$Res call({
 double signedBase
});




}
/// @nodoc
class _$MoneyDeltaCopyWithImpl<$Res>
    implements $MoneyDeltaCopyWith<$Res> {
  _$MoneyDeltaCopyWithImpl(this._self, this._then);

  final MoneyDelta _self;
  final $Res Function(MoneyDelta) _then;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signedBase = null,}) {
  return _then(MoneyDelta(
null == signedBase ? _self.signedBase : signedBase // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class JoyDelta extends SignedBaseDelta {
  const JoyDelta(this.signedBase): super._();
  

@override final  double signedBase;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoyDeltaCopyWith<JoyDelta> get copyWith => _$JoyDeltaCopyWithImpl<JoyDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoyDelta&&(identical(other.signedBase, signedBase) || other.signedBase == signedBase));
}


@override
int get hashCode => Object.hash(runtimeType,signedBase);

@override
String toString() {
  return 'SignedBaseDelta.joy(signedBase: $signedBase)';
}


}

/// @nodoc
abstract mixin class $JoyDeltaCopyWith<$Res> implements $SignedBaseDeltaCopyWith<$Res> {
  factory $JoyDeltaCopyWith(JoyDelta value, $Res Function(JoyDelta) _then) = _$JoyDeltaCopyWithImpl;
@override @useResult
$Res call({
 double signedBase
});




}
/// @nodoc
class _$JoyDeltaCopyWithImpl<$Res>
    implements $JoyDeltaCopyWith<$Res> {
  _$JoyDeltaCopyWithImpl(this._self, this._then);

  final JoyDelta _self;
  final $Res Function(JoyDelta) _then;

/// Create a copy of SignedBaseDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signedBase = null,}) {
  return _then(JoyDelta(
null == signedBase ? _self.signedBase : signedBase // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
