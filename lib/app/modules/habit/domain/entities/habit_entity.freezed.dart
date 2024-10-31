// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HabitEntity _$HabitEntityFromJson(Map<String, dynamic> json) {
  return _HabitEntity.fromJson(json);
}

/// @nodoc
mixin _$HabitEntity {
  /// Serializes this HabitEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitEntityCopyWith<$Res> {
  factory $HabitEntityCopyWith(
          HabitEntity value, $Res Function(HabitEntity) then) =
      _$HabitEntityCopyWithImpl<$Res, HabitEntity>;
}

/// @nodoc
class _$HabitEntityCopyWithImpl<$Res, $Val extends HabitEntity>
    implements $HabitEntityCopyWith<$Res> {
  _$HabitEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitEntity
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HabitEntityImplCopyWith<$Res> {
  factory _$$HabitEntityImplCopyWith(
          _$HabitEntityImpl value, $Res Function(_$HabitEntityImpl) then) =
      __$$HabitEntityImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HabitEntityImplCopyWithImpl<$Res>
    extends _$HabitEntityCopyWithImpl<$Res, _$HabitEntityImpl>
    implements _$$HabitEntityImplCopyWith<$Res> {
  __$$HabitEntityImplCopyWithImpl(
      _$HabitEntityImpl _value, $Res Function(_$HabitEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitEntity
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$HabitEntityImpl implements _HabitEntity {
  _$HabitEntityImpl();

  factory _$HabitEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$HabitEntityImplFromJson(json);

  @override
  String toString() {
    return 'HabitEntity()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HabitEntityImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$HabitEntityImplToJson(
      this,
    );
  }
}

abstract class _HabitEntity implements HabitEntity {
  factory _HabitEntity() = _$HabitEntityImpl;

  factory _HabitEntity.fromJson(Map<String, dynamic> json) =
      _$HabitEntityImpl.fromJson;
}
