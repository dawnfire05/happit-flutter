// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateHabitModelImpl _$$CreateHabitModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateHabitModelImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      repeatType: json['repeatType'] as String,
      repeatDay: (json['repeatDay'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CreateHabitModelImplToJson(
        _$CreateHabitModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'repeatType': instance.repeatType,
      'repeatDay': instance.repeatDay,
    };
