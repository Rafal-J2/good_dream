class TimerState {
  final bool isTimerRunning;
  final int selectedHour;
  final int selectedMinute;
  final int remainingTime;

  TimerState({
    this.isTimerRunning = false,
    this.selectedHour = 1,
    this.selectedMinute = 0,
    this.remainingTime = 3600,
  });

  TimerState copyWith({
    bool? isTimerRunning,
    int? selectedHour,
    int? selectedMinute,
    int? remainingTime,
  }) {
    return TimerState(
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      selectedHour: selectedHour ?? this.selectedHour,
      selectedMinute: selectedMinute ?? this.selectedMinute,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}
