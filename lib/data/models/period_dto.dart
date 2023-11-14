class PeriodDto {
  final DateTime startDate;
  final DateTime endDate;

  PeriodDto({required this.startDate, required this.endDate});

  factory PeriodDto.fromJson(Map<String, dynamic> json) {
    return PeriodDto(
        startDate: DateTime.parse(json['start_time']),
        endDate: DateTime.parse(json['end_time']));
  }
}
