class AvailableSlotModel {
  final String date;
  final List<String> times;

  AvailableSlotModel({
    required this.date,
    required this.times,
  });

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) {
    return AvailableSlotModel(
      date: json['date'] ?? '',
      times: List<String>.from(json['times'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
    'date': date,
    'times': times,
    };
  }
}