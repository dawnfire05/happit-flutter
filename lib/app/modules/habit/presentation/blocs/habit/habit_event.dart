// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'habit_bloc.dart';

sealed class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class AddHabitEvent extends HabitEvent {
  final String habitName;
  final String habitDescription;
  final String repeatType;
  final List<String> repeatDays;
  final TimeOfDay selectedTime;
  final int themeColor;

  const AddHabitEvent({
    required this.habitName,
    required this.habitDescription,
    required this.repeatType,
    required this.repeatDays,
    required this.selectedTime,
    required this.themeColor,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        habitName,
        habitDescription,
        repeatType,
        repeatDays,
        selectedTime,
        themeColor,
      ];
}
