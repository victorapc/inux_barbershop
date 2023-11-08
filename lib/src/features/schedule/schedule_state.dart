import 'package:flutter/widgets.dart';

enum ScheduleStateStatus {
  initial,
  success,
  error;
}

class ScheduleState {
  final ScheduleStateStatus status;
  final int? scheduleHour;
  final DateTime? scheduleDate;

  ScheduleState.initial() : this(status: ScheduleStateStatus.initial);

  ScheduleState({
    required this.status,
    this.scheduleHour,
    this.scheduleDate,
  });

  ScheduleState copyWith({
    ScheduleStateStatus? status,
    ValueGetter<int?>? scheduleHour,
    ValueGetter<DateTime?>? scheduleDate,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      scheduleHour: scheduleHour?.call() ?? this.scheduleHour,
      scheduleDate: scheduleDate?.call() ?? this.scheduleDate,
    );
  }
}
