// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateHabitModel _$CreateHabitModelFromJson(Map<String, dynamic> json) =>
    _CreateHabitModel(
      name: json['name'] as String,
      description: json['description'] as String,
      repeatType: json['repeatType'] as String,
      repeatDay: (json['repeatDay'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      themeColor: (json['themeColor'] as num).toInt(),
    );

Map<String, dynamic> _$CreateHabitModelToJson(_CreateHabitModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'repeatType': instance.repeatType,
      'repeatDay': instance.repeatDay,
      'themeColor': instance.themeColor,
    };
