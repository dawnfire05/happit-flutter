part of 'habit_bloc.dart';

class HabitState extends Equatable {
  final String habitName;
  final String habitDescription;
  final String repeatType;
  final List<String> repeatDays;
  final TimeOfDay selectedTime;
  final int themeColor;

  factory HabitState.initial() {
    return const HabitState(
      habitName: '',
      habitDescription: '',
      repeatType: 'daily',
      repeatDays: [],
      selectedTime: TimeOfDay(hour: 00, minute: 00),
      themeColor: 1,
    );
  }

  const HabitState({
    required this.habitName,
    required this.habitDescription,
    required this.repeatType,
    required this.repeatDays,
    required this.selectedTime,
    required this.themeColor,
  });

  @override
  List<Object> get props {
    return [
      habitName,
      habitDescription,
      repeatType,
      repeatDays,
      selectedTime,
      themeColor,
    ];
  }

  @override
  bool get stringify => true;

  HabitState copyWith({
    String? habitName,
    String? habitDescription,
    String? repeatType,
    List<String>? repeatDays,
    TimeOfDay? selectedTime,
    int? themeColor,
  }) {
    return HabitState(
      habitName: habitName ?? this.habitName,
      habitDescription: habitDescription ?? this.habitDescription,
      repeatType: repeatType ?? this.repeatType,
      repeatDays: repeatDays ?? this.repeatDays,
      selectedTime: selectedTime ?? this.selectedTime,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}
