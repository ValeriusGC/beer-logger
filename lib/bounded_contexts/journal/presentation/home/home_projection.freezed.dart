// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_projection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeBalanceProjection {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeBalanceProjection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeBalanceProjection()';
}


}

/// @nodoc
class $HomeBalanceProjectionCopyWith<$Res>  {
$HomeBalanceProjectionCopyWith(HomeBalanceProjection _, $Res Function(HomeBalanceProjection) __);
}


/// Adds pattern-matching-related methods to [HomeBalanceProjection].
extension HomeBalanceProjectionPatterns on HomeBalanceProjection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeBalanceProjectionLoading value)?  loading,TResult Function( HomeBalanceProjectionError value)?  error,TResult Function( HomeBalanceProjectionReady value)?  ready,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeBalanceProjectionLoading() when loading != null:
return loading(_that);case HomeBalanceProjectionError() when error != null:
return error(_that);case HomeBalanceProjectionReady() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeBalanceProjectionLoading value)  loading,required TResult Function( HomeBalanceProjectionError value)  error,required TResult Function( HomeBalanceProjectionReady value)  ready,}){
final _that = this;
switch (_that) {
case HomeBalanceProjectionLoading():
return loading(_that);case HomeBalanceProjectionError():
return error(_that);case HomeBalanceProjectionReady():
return ready(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeBalanceProjectionLoading value)?  loading,TResult? Function( HomeBalanceProjectionError value)?  error,TResult? Function( HomeBalanceProjectionReady value)?  ready,}){
final _that = this;
switch (_that) {
case HomeBalanceProjectionLoading() when loading != null:
return loading(_that);case HomeBalanceProjectionError() when error != null:
return error(_that);case HomeBalanceProjectionReady() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  error,TResult Function( PeriodBalances balances)?  ready,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeBalanceProjectionLoading() when loading != null:
return loading();case HomeBalanceProjectionError() when error != null:
return error();case HomeBalanceProjectionReady() when ready != null:
return ready(_that.balances);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  error,required TResult Function( PeriodBalances balances)  ready,}) {final _that = this;
switch (_that) {
case HomeBalanceProjectionLoading():
return loading();case HomeBalanceProjectionError():
return error();case HomeBalanceProjectionReady():
return ready(_that.balances);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  error,TResult? Function( PeriodBalances balances)?  ready,}) {final _that = this;
switch (_that) {
case HomeBalanceProjectionLoading() when loading != null:
return loading();case HomeBalanceProjectionError() when error != null:
return error();case HomeBalanceProjectionReady() when ready != null:
return ready(_that.balances);case _:
  return null;

}
}

}

/// @nodoc


class HomeBalanceProjectionLoading implements HomeBalanceProjection {
  const HomeBalanceProjectionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeBalanceProjectionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeBalanceProjection.loading()';
}


}




/// @nodoc


class HomeBalanceProjectionError implements HomeBalanceProjection {
  const HomeBalanceProjectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeBalanceProjectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeBalanceProjection.error()';
}


}




/// @nodoc


class HomeBalanceProjectionReady implements HomeBalanceProjection {
  const HomeBalanceProjectionReady(this.balances);
  

 final  PeriodBalances balances;

/// Create a copy of HomeBalanceProjection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeBalanceProjectionReadyCopyWith<HomeBalanceProjectionReady> get copyWith => _$HomeBalanceProjectionReadyCopyWithImpl<HomeBalanceProjectionReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeBalanceProjectionReady&&(identical(other.balances, balances) || other.balances == balances));
}


@override
int get hashCode => Object.hash(runtimeType,balances);

@override
String toString() {
  return 'HomeBalanceProjection.ready(balances: $balances)';
}


}

/// @nodoc
abstract mixin class $HomeBalanceProjectionReadyCopyWith<$Res> implements $HomeBalanceProjectionCopyWith<$Res> {
  factory $HomeBalanceProjectionReadyCopyWith(HomeBalanceProjectionReady value, $Res Function(HomeBalanceProjectionReady) _then) = _$HomeBalanceProjectionReadyCopyWithImpl;
@useResult
$Res call({
 PeriodBalances balances
});


$PeriodBalancesCopyWith<$Res> get balances;

}
/// @nodoc
class _$HomeBalanceProjectionReadyCopyWithImpl<$Res>
    implements $HomeBalanceProjectionReadyCopyWith<$Res> {
  _$HomeBalanceProjectionReadyCopyWithImpl(this._self, this._then);

  final HomeBalanceProjectionReady _self;
  final $Res Function(HomeBalanceProjectionReady) _then;

/// Create a copy of HomeBalanceProjection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? balances = null,}) {
  return _then(HomeBalanceProjectionReady(
null == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as PeriodBalances,
  ));
}

/// Create a copy of HomeBalanceProjection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeriodBalancesCopyWith<$Res> get balances {
  
  return $PeriodBalancesCopyWith<$Res>(_self.balances, (value) {
    return _then(_self.copyWith(balances: value));
  });
}
}

/// @nodoc
mixin _$HomeJournalProjection {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeJournalProjection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeJournalProjection()';
}


}

/// @nodoc
class $HomeJournalProjectionCopyWith<$Res>  {
$HomeJournalProjectionCopyWith(HomeJournalProjection _, $Res Function(HomeJournalProjection) __);
}


/// Adds pattern-matching-related methods to [HomeJournalProjection].
extension HomeJournalProjectionPatterns on HomeJournalProjection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeJournalProjectionLoading value)?  loading,TResult Function( HomeJournalProjectionError value)?  error,TResult Function( HomeJournalProjectionEmpty value)?  empty,TResult Function( HomeJournalProjectionItems value)?  items,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeJournalProjectionLoading() when loading != null:
return loading(_that);case HomeJournalProjectionError() when error != null:
return error(_that);case HomeJournalProjectionEmpty() when empty != null:
return empty(_that);case HomeJournalProjectionItems() when items != null:
return items(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeJournalProjectionLoading value)  loading,required TResult Function( HomeJournalProjectionError value)  error,required TResult Function( HomeJournalProjectionEmpty value)  empty,required TResult Function( HomeJournalProjectionItems value)  items,}){
final _that = this;
switch (_that) {
case HomeJournalProjectionLoading():
return loading(_that);case HomeJournalProjectionError():
return error(_that);case HomeJournalProjectionEmpty():
return empty(_that);case HomeJournalProjectionItems():
return items(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeJournalProjectionLoading value)?  loading,TResult? Function( HomeJournalProjectionError value)?  error,TResult? Function( HomeJournalProjectionEmpty value)?  empty,TResult? Function( HomeJournalProjectionItems value)?  items,}){
final _that = this;
switch (_that) {
case HomeJournalProjectionLoading() when loading != null:
return loading(_that);case HomeJournalProjectionError() when error != null:
return error(_that);case HomeJournalProjectionEmpty() when empty != null:
return empty(_that);case HomeJournalProjectionItems() when items != null:
return items(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  error,TResult Function()?  empty,TResult Function( HomeJournalClickList clicks)?  items,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeJournalProjectionLoading() when loading != null:
return loading();case HomeJournalProjectionError() when error != null:
return error();case HomeJournalProjectionEmpty() when empty != null:
return empty();case HomeJournalProjectionItems() when items != null:
return items(_that.clicks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  error,required TResult Function()  empty,required TResult Function( HomeJournalClickList clicks)  items,}) {final _that = this;
switch (_that) {
case HomeJournalProjectionLoading():
return loading();case HomeJournalProjectionError():
return error();case HomeJournalProjectionEmpty():
return empty();case HomeJournalProjectionItems():
return items(_that.clicks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  error,TResult? Function()?  empty,TResult? Function( HomeJournalClickList clicks)?  items,}) {final _that = this;
switch (_that) {
case HomeJournalProjectionLoading() when loading != null:
return loading();case HomeJournalProjectionError() when error != null:
return error();case HomeJournalProjectionEmpty() when empty != null:
return empty();case HomeJournalProjectionItems() when items != null:
return items(_that.clicks);case _:
  return null;

}
}

}

/// @nodoc


class HomeJournalProjectionLoading implements HomeJournalProjection {
  const HomeJournalProjectionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeJournalProjectionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeJournalProjection.loading()';
}


}




/// @nodoc


class HomeJournalProjectionError implements HomeJournalProjection {
  const HomeJournalProjectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeJournalProjectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeJournalProjection.error()';
}


}




/// @nodoc


class HomeJournalProjectionEmpty implements HomeJournalProjection {
  const HomeJournalProjectionEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeJournalProjectionEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeJournalProjection.empty()';
}


}




/// @nodoc


class HomeJournalProjectionItems implements HomeJournalProjection {
  const HomeJournalProjectionItems(this.clicks);
  

 final  HomeJournalClickList clicks;

/// Create a copy of HomeJournalProjection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeJournalProjectionItemsCopyWith<HomeJournalProjectionItems> get copyWith => _$HomeJournalProjectionItemsCopyWithImpl<HomeJournalProjectionItems>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeJournalProjectionItems&&(identical(other.clicks, clicks) || other.clicks == clicks));
}


@override
int get hashCode => Object.hash(runtimeType,clicks);

@override
String toString() {
  return 'HomeJournalProjection.items(clicks: $clicks)';
}


}

/// @nodoc
abstract mixin class $HomeJournalProjectionItemsCopyWith<$Res> implements $HomeJournalProjectionCopyWith<$Res> {
  factory $HomeJournalProjectionItemsCopyWith(HomeJournalProjectionItems value, $Res Function(HomeJournalProjectionItems) _then) = _$HomeJournalProjectionItemsCopyWithImpl;
@useResult
$Res call({
 HomeJournalClickList clicks
});




}
/// @nodoc
class _$HomeJournalProjectionItemsCopyWithImpl<$Res>
    implements $HomeJournalProjectionItemsCopyWith<$Res> {
  _$HomeJournalProjectionItemsCopyWithImpl(this._self, this._then);

  final HomeJournalProjectionItems _self;
  final $Res Function(HomeJournalProjectionItems) _then;

/// Create a copy of HomeJournalProjection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clicks = null,}) {
  return _then(HomeJournalProjectionItems(
null == clicks ? _self.clicks : clicks // ignore: cast_nullable_to_non_nullable
as HomeJournalClickList,
  ));
}


}

/// @nodoc
mixin _$HomeProjection {

 bool get tapEnabled; Clicker get buttonClicker; HomeBalanceProjection get balance; HomeJournalProjection get journal; bool get undoEnabled;
/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeProjectionCopyWith<HomeProjection> get copyWith => _$HomeProjectionCopyWithImpl<HomeProjection>(this as HomeProjection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeProjection&&(identical(other.tapEnabled, tapEnabled) || other.tapEnabled == tapEnabled)&&(identical(other.buttonClicker, buttonClicker) || other.buttonClicker == buttonClicker)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.journal, journal) || other.journal == journal)&&(identical(other.undoEnabled, undoEnabled) || other.undoEnabled == undoEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,tapEnabled,buttonClicker,balance,journal,undoEnabled);

@override
String toString() {
  return 'HomeProjection(tapEnabled: $tapEnabled, buttonClicker: $buttonClicker, balance: $balance, journal: $journal, undoEnabled: $undoEnabled)';
}


}

/// @nodoc
abstract mixin class $HomeProjectionCopyWith<$Res>  {
  factory $HomeProjectionCopyWith(HomeProjection value, $Res Function(HomeProjection) _then) = _$HomeProjectionCopyWithImpl;
@useResult
$Res call({
 bool tapEnabled, Clicker buttonClicker, HomeBalanceProjection balance, HomeJournalProjection journal, bool undoEnabled
});


$ClickerCopyWith<$Res> get buttonClicker;$HomeBalanceProjectionCopyWith<$Res> get balance;$HomeJournalProjectionCopyWith<$Res> get journal;

}
/// @nodoc
class _$HomeProjectionCopyWithImpl<$Res>
    implements $HomeProjectionCopyWith<$Res> {
  _$HomeProjectionCopyWithImpl(this._self, this._then);

  final HomeProjection _self;
  final $Res Function(HomeProjection) _then;

/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tapEnabled = null,Object? buttonClicker = null,Object? balance = null,Object? journal = null,Object? undoEnabled = null,}) {
  return _then(_self.copyWith(
tapEnabled: null == tapEnabled ? _self.tapEnabled : tapEnabled // ignore: cast_nullable_to_non_nullable
as bool,buttonClicker: null == buttonClicker ? _self.buttonClicker : buttonClicker // ignore: cast_nullable_to_non_nullable
as Clicker,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as HomeBalanceProjection,journal: null == journal ? _self.journal : journal // ignore: cast_nullable_to_non_nullable
as HomeJournalProjection,undoEnabled: null == undoEnabled ? _self.undoEnabled : undoEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickerCopyWith<$Res> get buttonClicker {
  
  return $ClickerCopyWith<$Res>(_self.buttonClicker, (value) {
    return _then(_self.copyWith(buttonClicker: value));
  });
}/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeBalanceProjectionCopyWith<$Res> get balance {
  
  return $HomeBalanceProjectionCopyWith<$Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeJournalProjectionCopyWith<$Res> get journal {
  
  return $HomeJournalProjectionCopyWith<$Res>(_self.journal, (value) {
    return _then(_self.copyWith(journal: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeProjection].
extension HomeProjectionPatterns on HomeProjection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeProjection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeProjection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeProjection value)  $default,){
final _that = this;
switch (_that) {
case _HomeProjection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeProjection value)?  $default,){
final _that = this;
switch (_that) {
case _HomeProjection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool tapEnabled,  Clicker buttonClicker,  HomeBalanceProjection balance,  HomeJournalProjection journal,  bool undoEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeProjection() when $default != null:
return $default(_that.tapEnabled,_that.buttonClicker,_that.balance,_that.journal,_that.undoEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool tapEnabled,  Clicker buttonClicker,  HomeBalanceProjection balance,  HomeJournalProjection journal,  bool undoEnabled)  $default,) {final _that = this;
switch (_that) {
case _HomeProjection():
return $default(_that.tapEnabled,_that.buttonClicker,_that.balance,_that.journal,_that.undoEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool tapEnabled,  Clicker buttonClicker,  HomeBalanceProjection balance,  HomeJournalProjection journal,  bool undoEnabled)?  $default,) {final _that = this;
switch (_that) {
case _HomeProjection() when $default != null:
return $default(_that.tapEnabled,_that.buttonClicker,_that.balance,_that.journal,_that.undoEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _HomeProjection implements HomeProjection {
  const _HomeProjection({required this.tapEnabled, required this.buttonClicker, required this.balance, required this.journal, required this.undoEnabled});
  

@override final  bool tapEnabled;
@override final  Clicker buttonClicker;
@override final  HomeBalanceProjection balance;
@override final  HomeJournalProjection journal;
@override final  bool undoEnabled;

/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeProjectionCopyWith<_HomeProjection> get copyWith => __$HomeProjectionCopyWithImpl<_HomeProjection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeProjection&&(identical(other.tapEnabled, tapEnabled) || other.tapEnabled == tapEnabled)&&(identical(other.buttonClicker, buttonClicker) || other.buttonClicker == buttonClicker)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.journal, journal) || other.journal == journal)&&(identical(other.undoEnabled, undoEnabled) || other.undoEnabled == undoEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,tapEnabled,buttonClicker,balance,journal,undoEnabled);

@override
String toString() {
  return 'HomeProjection(tapEnabled: $tapEnabled, buttonClicker: $buttonClicker, balance: $balance, journal: $journal, undoEnabled: $undoEnabled)';
}


}

/// @nodoc
abstract mixin class _$HomeProjectionCopyWith<$Res> implements $HomeProjectionCopyWith<$Res> {
  factory _$HomeProjectionCopyWith(_HomeProjection value, $Res Function(_HomeProjection) _then) = __$HomeProjectionCopyWithImpl;
@override @useResult
$Res call({
 bool tapEnabled, Clicker buttonClicker, HomeBalanceProjection balance, HomeJournalProjection journal, bool undoEnabled
});


@override $ClickerCopyWith<$Res> get buttonClicker;@override $HomeBalanceProjectionCopyWith<$Res> get balance;@override $HomeJournalProjectionCopyWith<$Res> get journal;

}
/// @nodoc
class __$HomeProjectionCopyWithImpl<$Res>
    implements _$HomeProjectionCopyWith<$Res> {
  __$HomeProjectionCopyWithImpl(this._self, this._then);

  final _HomeProjection _self;
  final $Res Function(_HomeProjection) _then;

/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tapEnabled = null,Object? buttonClicker = null,Object? balance = null,Object? journal = null,Object? undoEnabled = null,}) {
  return _then(_HomeProjection(
tapEnabled: null == tapEnabled ? _self.tapEnabled : tapEnabled // ignore: cast_nullable_to_non_nullable
as bool,buttonClicker: null == buttonClicker ? _self.buttonClicker : buttonClicker // ignore: cast_nullable_to_non_nullable
as Clicker,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as HomeBalanceProjection,journal: null == journal ? _self.journal : journal // ignore: cast_nullable_to_non_nullable
as HomeJournalProjection,undoEnabled: null == undoEnabled ? _self.undoEnabled : undoEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClickerCopyWith<$Res> get buttonClicker {
  
  return $ClickerCopyWith<$Res>(_self.buttonClicker, (value) {
    return _then(_self.copyWith(buttonClicker: value));
  });
}/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeBalanceProjectionCopyWith<$Res> get balance {
  
  return $HomeBalanceProjectionCopyWith<$Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of HomeProjection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeJournalProjectionCopyWith<$Res> get journal {
  
  return $HomeJournalProjectionCopyWith<$Res>(_self.journal, (value) {
    return _then(_self.copyWith(journal: value));
  });
}
}

// dart format on
