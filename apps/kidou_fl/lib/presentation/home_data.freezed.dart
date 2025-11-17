// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeData {

 String get message; String get endpoint; ServiceState get serviceState; Map<String, dynamic>? get matcherConfig;
/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDataCopyWith<HomeData> get copyWith => _$HomeDataCopyWithImpl<HomeData>(this as HomeData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeData&&(identical(other.message, message) || other.message == message)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.serviceState, serviceState) || other.serviceState == serviceState)&&const DeepCollectionEquality().equals(other.matcherConfig, matcherConfig));
}


@override
int get hashCode => Object.hash(runtimeType,message,endpoint,serviceState,const DeepCollectionEquality().hash(matcherConfig));

@override
String toString() {
  return 'HomeData(message: $message, endpoint: $endpoint, serviceState: $serviceState, matcherConfig: $matcherConfig)';
}


}

/// @nodoc
abstract mixin class $HomeDataCopyWith<$Res>  {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) _then) = _$HomeDataCopyWithImpl;
@useResult
$Res call({
 String message, String endpoint, ServiceState serviceState, Map<String, dynamic>? matcherConfig
});




}
/// @nodoc
class _$HomeDataCopyWithImpl<$Res>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._self, this._then);

  final HomeData _self;
  final $Res Function(HomeData) _then;

/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? endpoint = null,Object? serviceState = null,Object? matcherConfig = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,endpoint: null == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String,serviceState: null == serviceState ? _self.serviceState : serviceState // ignore: cast_nullable_to_non_nullable
as ServiceState,matcherConfig: freezed == matcherConfig ? _self.matcherConfig : matcherConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeData].
extension HomeDataPatterns on HomeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeData value)  $default,){
final _that = this;
switch (_that) {
case _HomeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeData value)?  $default,){
final _that = this;
switch (_that) {
case _HomeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String endpoint,  ServiceState serviceState,  Map<String, dynamic>? matcherConfig)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeData() when $default != null:
return $default(_that.message,_that.endpoint,_that.serviceState,_that.matcherConfig);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String endpoint,  ServiceState serviceState,  Map<String, dynamic>? matcherConfig)  $default,) {final _that = this;
switch (_that) {
case _HomeData():
return $default(_that.message,_that.endpoint,_that.serviceState,_that.matcherConfig);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String endpoint,  ServiceState serviceState,  Map<String, dynamic>? matcherConfig)?  $default,) {final _that = this;
switch (_that) {
case _HomeData() when $default != null:
return $default(_that.message,_that.endpoint,_that.serviceState,_that.matcherConfig);case _:
  return null;

}
}

}

/// @nodoc


class _HomeData implements HomeData {
  const _HomeData({required this.message, required this.endpoint, required this.serviceState, final  Map<String, dynamic>? matcherConfig}): _matcherConfig = matcherConfig;
  

@override final  String message;
@override final  String endpoint;
@override final  ServiceState serviceState;
 final  Map<String, dynamic>? _matcherConfig;
@override Map<String, dynamic>? get matcherConfig {
  final value = _matcherConfig;
  if (value == null) return null;
  if (_matcherConfig is EqualUnmodifiableMapView) return _matcherConfig;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeDataCopyWith<_HomeData> get copyWith => __$HomeDataCopyWithImpl<_HomeData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeData&&(identical(other.message, message) || other.message == message)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.serviceState, serviceState) || other.serviceState == serviceState)&&const DeepCollectionEquality().equals(other._matcherConfig, _matcherConfig));
}


@override
int get hashCode => Object.hash(runtimeType,message,endpoint,serviceState,const DeepCollectionEquality().hash(_matcherConfig));

@override
String toString() {
  return 'HomeData(message: $message, endpoint: $endpoint, serviceState: $serviceState, matcherConfig: $matcherConfig)';
}


}

/// @nodoc
abstract mixin class _$HomeDataCopyWith<$Res> implements $HomeDataCopyWith<$Res> {
  factory _$HomeDataCopyWith(_HomeData value, $Res Function(_HomeData) _then) = __$HomeDataCopyWithImpl;
@override @useResult
$Res call({
 String message, String endpoint, ServiceState serviceState, Map<String, dynamic>? matcherConfig
});




}
/// @nodoc
class __$HomeDataCopyWithImpl<$Res>
    implements _$HomeDataCopyWith<$Res> {
  __$HomeDataCopyWithImpl(this._self, this._then);

  final _HomeData _self;
  final $Res Function(_HomeData) _then;

/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? endpoint = null,Object? serviceState = null,Object? matcherConfig = freezed,}) {
  return _then(_HomeData(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,endpoint: null == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String,serviceState: null == serviceState ? _self.serviceState : serviceState // ignore: cast_nullable_to_non_nullable
as ServiceState,matcherConfig: freezed == matcherConfig ? _self._matcherConfig : matcherConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
