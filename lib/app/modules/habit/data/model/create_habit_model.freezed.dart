// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_habit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateHabitModel _$CreateHabitModelFromJson(Map<String, dynamic> json) {
  return _CreateHabitModel.fromJson(json);
}

/// @nodoc
mixin _$CreateHabitModel {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get repeatType => throw _privateConstructorUsedError;
  List<String>? get repeatDay =>
      throw _privateConstructorUsedError; // required TimeOfDay noticeTime,
  int get themeColor => throw _privateConstructorUsedError;

  /// Serializes this CreateHabitModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateHabitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateHabitModelCopyWith<CreateHabitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateHabitModelCopyWith<$Res> {
  factory $CreateHabitModelCopyWith(
          CreateHabitModel value, $Res Function(CreateHabitModel) then) =
      _$CreateHabitModelCopyWithImpl<$Res, CreateHabitModel>;
  @useResult
  $Res call(
      {String name,
      String description,
      String repeatType,
      List<String>? repeatDay,
      int themeColor});
}

/// @nodoc
class _$CreateHabitModelCopyWithImpl<$Res, $Val extends CreateHabitModel>
    implements $CreateHabitModelCopyWith<$Res> {
  _$CreateHabitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateHabitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? repeatType = null,
    Object? repeatDay = freezed,
    Object? themeColor = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      repeatType: null == repeatType
          ? _value.repeatType
          : repeatType // ignore: cast_nullable_to_non_nullable
              as String,
      repeatDay: freezed == repeatDay
          ? _value.repeatDay
          : repeatDay // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      themeColor: null == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateHabitModelImplCopyWith<$Res>
    implements $CreateHabitModelCopyWith<$Res> {
  factory _$$CreateHabitModelImplCopyWith(_$CreateHabitModelImpl value,
          $Res Function(_$CreateHabitModelImpl) then) =
      __$$CreateHabitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      String repeatType,
      List<String>? repeatDay,
      int themeColor});
}

/// @nodoc
class __$$CreateHabitModelImplCopyWithImpl<$Res>
    extends _$CreateHabitModelCopyWithImpl<$Res, _$CreateHabitModelImpl>
    implements _$$CreateHabitModelImplCopyWith<$Res> {
  __$$CreateHabitModelImplCopyWithImpl(_$CreateHabitModelImpl _value,
      $Res Function(_$CreateHabitModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateHabitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? repeatType = null,
    Object? repeatDay = freezed,
    Object? themeColor = null,
  }) {
    return _then(_$CreateHabitModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      repeatType: null == repeatType
          ? _value.repeatType
          : repeatType // ignore: cast_nullable_to_non_nullable
              as String,
      repeatDay: freezed == repeatDay
          ? _value._repeatDay
          : repeatDay // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      themeColor: null == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateHabitModelImpl implements _CreateHabitModel {
  const _$CreateHabitModelImpl(
      {required this.name,
      required this.description,
      required this.repeatType,
      final List<String>? repeatDay,
      required this.themeColor})
      : _repeatDay = repeatDay;

  factory _$CreateHabitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateHabitModelImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String repeatType;
  final List<String>? _repeatDay;
  @override
  List<String>? get repeatDay {
    final value = _repeatDay;
    if (value == null) return null;
    if (_repeatDay is EqualUnmodifiableListView) return _repeatDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// required TimeOfDay noticeTime,
  @override
  final int themeColor;

  @override
  String toString() {
    return 'CreateHabitModel(name: $name, description: $description, repeatType: $repeatType, repeatDay: $repeatDay, themeColor: $themeColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateHabitModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.repeatType, repeatType) ||
                other.repeatType == repeatType) &&
            const DeepCollectionEquality()
                .equals(other._repeatDay, _repeatDay) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, repeatType,
      const DeepCollectionEquality().hash(_repeatDay), themeColor);

  /// Create a copy of CreateHabitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateHabitModelImplCopyWith<_$CreateHabitModelImpl> get copyWith =>
      __$$CreateHabitModelImplCopyWithImpl<_$CreateHabitModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateHabitModelImplToJson(
      this,
    );
  }
}

abstract class _CreateHabitModel implements CreateHabitModel {
  const factory _CreateHabitModel(
      {required final String name,
      required final String description,
      required final String repeatType,
      final List<String>? repeatDay,
      required final int themeColor}) = _$CreateHabitModelImpl;

  factory _CreateHabitModel.fromJson(Map<String, dynamic> json) =
      _$CreateHabitModelImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get repeatType;
  @override
  List<String>? get repeatDay; // required TimeOfDay noticeTime,
  @override
  int get themeColor;

  /// Create a copy of CreateHabitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateHabitModelImplCopyWith<_$CreateHabitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
