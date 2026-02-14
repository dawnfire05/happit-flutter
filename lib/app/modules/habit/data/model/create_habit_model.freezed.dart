// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_habit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateHabitModel {

 String get name; String get description; String get repeatType; List<String>? get repeatDay;// required TimeOfDay noticeTime,
 int get themeColor;
/// Create a copy of CreateHabitModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateHabitModelCopyWith<CreateHabitModel> get copyWith => _$CreateHabitModelCopyWithImpl<CreateHabitModel>(this as CreateHabitModel, _$identity);

  /// Serializes this CreateHabitModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateHabitModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.repeatType, repeatType) || other.repeatType == repeatType)&&const DeepCollectionEquality().equals(other.repeatDay, repeatDay)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,repeatType,const DeepCollectionEquality().hash(repeatDay),themeColor);

@override
String toString() {
  return 'CreateHabitModel(name: $name, description: $description, repeatType: $repeatType, repeatDay: $repeatDay, themeColor: $themeColor)';
}


}

/// @nodoc
abstract mixin class $CreateHabitModelCopyWith<$Res>  {
  factory $CreateHabitModelCopyWith(CreateHabitModel value, $Res Function(CreateHabitModel) _then) = _$CreateHabitModelCopyWithImpl;
@useResult
$Res call({
 String name, String description, String repeatType, List<String>? repeatDay, int themeColor
});




}
/// @nodoc
class _$CreateHabitModelCopyWithImpl<$Res>
    implements $CreateHabitModelCopyWith<$Res> {
  _$CreateHabitModelCopyWithImpl(this._self, this._then);

  final CreateHabitModel _self;
  final $Res Function(CreateHabitModel) _then;

/// Create a copy of CreateHabitModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? repeatType = null,Object? repeatDay = freezed,Object? themeColor = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,repeatType: null == repeatType ? _self.repeatType : repeatType // ignore: cast_nullable_to_non_nullable
as String,repeatDay: freezed == repeatDay ? _self.repeatDay : repeatDay // ignore: cast_nullable_to_non_nullable
as List<String>?,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateHabitModel].
extension CreateHabitModelPatterns on CreateHabitModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateHabitModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateHabitModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateHabitModel value)  $default,){
final _that = this;
switch (_that) {
case _CreateHabitModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateHabitModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreateHabitModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String repeatType,  List<String>? repeatDay,  int themeColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateHabitModel() when $default != null:
return $default(_that.name,_that.description,_that.repeatType,_that.repeatDay,_that.themeColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String repeatType,  List<String>? repeatDay,  int themeColor)  $default,) {final _that = this;
switch (_that) {
case _CreateHabitModel():
return $default(_that.name,_that.description,_that.repeatType,_that.repeatDay,_that.themeColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String repeatType,  List<String>? repeatDay,  int themeColor)?  $default,) {final _that = this;
switch (_that) {
case _CreateHabitModel() when $default != null:
return $default(_that.name,_that.description,_that.repeatType,_that.repeatDay,_that.themeColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateHabitModel implements CreateHabitModel {
  const _CreateHabitModel({required this.name, required this.description, required this.repeatType, final  List<String>? repeatDay, required this.themeColor}): _repeatDay = repeatDay;
  factory _CreateHabitModel.fromJson(Map<String, dynamic> json) => _$CreateHabitModelFromJson(json);

@override final  String name;
@override final  String description;
@override final  String repeatType;
 final  List<String>? _repeatDay;
@override List<String>? get repeatDay {
  final value = _repeatDay;
  if (value == null) return null;
  if (_repeatDay is EqualUnmodifiableListView) return _repeatDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// required TimeOfDay noticeTime,
@override final  int themeColor;

/// Create a copy of CreateHabitModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateHabitModelCopyWith<_CreateHabitModel> get copyWith => __$CreateHabitModelCopyWithImpl<_CreateHabitModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateHabitModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateHabitModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.repeatType, repeatType) || other.repeatType == repeatType)&&const DeepCollectionEquality().equals(other._repeatDay, _repeatDay)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,repeatType,const DeepCollectionEquality().hash(_repeatDay),themeColor);

@override
String toString() {
  return 'CreateHabitModel(name: $name, description: $description, repeatType: $repeatType, repeatDay: $repeatDay, themeColor: $themeColor)';
}


}

/// @nodoc
abstract mixin class _$CreateHabitModelCopyWith<$Res> implements $CreateHabitModelCopyWith<$Res> {
  factory _$CreateHabitModelCopyWith(_CreateHabitModel value, $Res Function(_CreateHabitModel) _then) = __$CreateHabitModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String repeatType, List<String>? repeatDay, int themeColor
});




}
/// @nodoc
class __$CreateHabitModelCopyWithImpl<$Res>
    implements _$CreateHabitModelCopyWith<$Res> {
  __$CreateHabitModelCopyWithImpl(this._self, this._then);

  final _CreateHabitModel _self;
  final $Res Function(_CreateHabitModel) _then;

/// Create a copy of CreateHabitModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? repeatType = null,Object? repeatDay = freezed,Object? themeColor = null,}) {
  return _then(_CreateHabitModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,repeatType: null == repeatType ? _self.repeatType : repeatType // ignore: cast_nullable_to_non_nullable
as String,repeatDay: freezed == repeatDay ? _self._repeatDay : repeatDay // ignore: cast_nullable_to_non_nullable
as List<String>?,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
