// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IncompatibleUnits value)?  incompatibleUnits,TResult Function( InvalidPeriod value)?  invalidPeriod,TResult Function( UnknownUnitId value)?  unknownUnitId,TResult Function( EmptyId value)?  emptyId,TResult Function( StorageFailure value)?  storage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IncompatibleUnits() when incompatibleUnits != null:
return incompatibleUnits(_that);case InvalidPeriod() when invalidPeriod != null:
return invalidPeriod(_that);case UnknownUnitId() when unknownUnitId != null:
return unknownUnitId(_that);case EmptyId() when emptyId != null:
return emptyId(_that);case StorageFailure() when storage != null:
return storage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IncompatibleUnits value)  incompatibleUnits,required TResult Function( InvalidPeriod value)  invalidPeriod,required TResult Function( UnknownUnitId value)  unknownUnitId,required TResult Function( EmptyId value)  emptyId,required TResult Function( StorageFailure value)  storage,}){
final _that = this;
switch (_that) {
case IncompatibleUnits():
return incompatibleUnits(_that);case InvalidPeriod():
return invalidPeriod(_that);case UnknownUnitId():
return unknownUnitId(_that);case EmptyId():
return emptyId(_that);case StorageFailure():
return storage(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IncompatibleUnits value)?  incompatibleUnits,TResult? Function( InvalidPeriod value)?  invalidPeriod,TResult? Function( UnknownUnitId value)?  unknownUnitId,TResult? Function( EmptyId value)?  emptyId,TResult? Function( StorageFailure value)?  storage,}){
final _that = this;
switch (_that) {
case IncompatibleUnits() when incompatibleUnits != null:
return incompatibleUnits(_that);case InvalidPeriod() when invalidPeriod != null:
return invalidPeriod(_that);case UnknownUnitId() when unknownUnitId != null:
return unknownUnitId(_that);case EmptyId() when emptyId != null:
return emptyId(_that);case StorageFailure() when storage != null:
return storage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String fromId,  String toId)?  incompatibleUnits,TResult Function( DateTime from,  DateTime to)?  invalidPeriod,TResult Function( String id)?  unknownUnitId,TResult Function()?  emptyId,TResult Function( String operation,  Object? cause)?  storage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IncompatibleUnits() when incompatibleUnits != null:
return incompatibleUnits(_that.fromId,_that.toId);case InvalidPeriod() when invalidPeriod != null:
return invalidPeriod(_that.from,_that.to);case UnknownUnitId() when unknownUnitId != null:
return unknownUnitId(_that.id);case EmptyId() when emptyId != null:
return emptyId();case StorageFailure() when storage != null:
return storage(_that.operation,_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String fromId,  String toId)  incompatibleUnits,required TResult Function( DateTime from,  DateTime to)  invalidPeriod,required TResult Function( String id)  unknownUnitId,required TResult Function()  emptyId,required TResult Function( String operation,  Object? cause)  storage,}) {final _that = this;
switch (_that) {
case IncompatibleUnits():
return incompatibleUnits(_that.fromId,_that.toId);case InvalidPeriod():
return invalidPeriod(_that.from,_that.to);case UnknownUnitId():
return unknownUnitId(_that.id);case EmptyId():
return emptyId();case StorageFailure():
return storage(_that.operation,_that.cause);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String fromId,  String toId)?  incompatibleUnits,TResult? Function( DateTime from,  DateTime to)?  invalidPeriod,TResult? Function( String id)?  unknownUnitId,TResult? Function()?  emptyId,TResult? Function( String operation,  Object? cause)?  storage,}) {final _that = this;
switch (_that) {
case IncompatibleUnits() when incompatibleUnits != null:
return incompatibleUnits(_that.fromId,_that.toId);case InvalidPeriod() when invalidPeriod != null:
return invalidPeriod(_that.from,_that.to);case UnknownUnitId() when unknownUnitId != null:
return unknownUnitId(_that.id);case EmptyId() when emptyId != null:
return emptyId();case StorageFailure() when storage != null:
return storage(_that.operation,_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class IncompatibleUnits implements Failure {
  const IncompatibleUnits({required this.fromId, required this.toId});
  

 final  String fromId;
 final  String toId;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncompatibleUnitsCopyWith<IncompatibleUnits> get copyWith => _$IncompatibleUnitsCopyWithImpl<IncompatibleUnits>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncompatibleUnits&&(identical(other.fromId, fromId) || other.fromId == fromId)&&(identical(other.toId, toId) || other.toId == toId));
}


@override
int get hashCode => Object.hash(runtimeType,fromId,toId);

@override
String toString() {
  return 'Failure.incompatibleUnits(fromId: $fromId, toId: $toId)';
}


}

/// @nodoc
abstract mixin class $IncompatibleUnitsCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $IncompatibleUnitsCopyWith(IncompatibleUnits value, $Res Function(IncompatibleUnits) _then) = _$IncompatibleUnitsCopyWithImpl;
@useResult
$Res call({
 String fromId, String toId
});




}
/// @nodoc
class _$IncompatibleUnitsCopyWithImpl<$Res>
    implements $IncompatibleUnitsCopyWith<$Res> {
  _$IncompatibleUnitsCopyWithImpl(this._self, this._then);

  final IncompatibleUnits _self;
  final $Res Function(IncompatibleUnits) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fromId = null,Object? toId = null,}) {
  return _then(IncompatibleUnits(
fromId: null == fromId ? _self.fromId : fromId // ignore: cast_nullable_to_non_nullable
as String,toId: null == toId ? _self.toId : toId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidPeriod implements Failure {
  const InvalidPeriod({required this.from, required this.to});
  

 final  DateTime from;
 final  DateTime to;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidPeriodCopyWith<InvalidPeriod> get copyWith => _$InvalidPeriodCopyWithImpl<InvalidPeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidPeriod&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'Failure.invalidPeriod(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $InvalidPeriodCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $InvalidPeriodCopyWith(InvalidPeriod value, $Res Function(InvalidPeriod) _then) = _$InvalidPeriodCopyWithImpl;
@useResult
$Res call({
 DateTime from, DateTime to
});




}
/// @nodoc
class _$InvalidPeriodCopyWithImpl<$Res>
    implements $InvalidPeriodCopyWith<$Res> {
  _$InvalidPeriodCopyWithImpl(this._self, this._then);

  final InvalidPeriod _self;
  final $Res Function(InvalidPeriod) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(InvalidPeriod(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class UnknownUnitId implements Failure {
  const UnknownUnitId({required this.id});
  

 final  String id;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownUnitIdCopyWith<UnknownUnitId> get copyWith => _$UnknownUnitIdCopyWithImpl<UnknownUnitId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownUnitId&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'Failure.unknownUnitId(id: $id)';
}


}

/// @nodoc
abstract mixin class $UnknownUnitIdCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnknownUnitIdCopyWith(UnknownUnitId value, $Res Function(UnknownUnitId) _then) = _$UnknownUnitIdCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$UnknownUnitIdCopyWithImpl<$Res>
    implements $UnknownUnitIdCopyWith<$Res> {
  _$UnknownUnitIdCopyWithImpl(this._self, this._then);

  final UnknownUnitId _self;
  final $Res Function(UnknownUnitId) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(UnknownUnitId(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmptyId implements Failure {
  const EmptyId();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyId);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.emptyId()';
}


}




/// @nodoc


class StorageFailure implements Failure {
  const StorageFailure({required this.operation, this.cause});
  

 final  String operation;
 final  Object? cause;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageFailureCopyWith<StorageFailure> get copyWith => _$StorageFailureCopyWithImpl<StorageFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageFailure&&(identical(other.operation, operation) || other.operation == operation)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,operation,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'Failure.storage(operation: $operation, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $StorageFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageFailureCopyWith(StorageFailure value, $Res Function(StorageFailure) _then) = _$StorageFailureCopyWithImpl;
@useResult
$Res call({
 String operation, Object? cause
});




}
/// @nodoc
class _$StorageFailureCopyWithImpl<$Res>
    implements $StorageFailureCopyWith<$Res> {
  _$StorageFailureCopyWithImpl(this._self, this._then);

  final StorageFailure _self;
  final $Res Function(StorageFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? operation = null,Object? cause = freezed,}) {
  return _then(StorageFailure(
operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

// dart format on
