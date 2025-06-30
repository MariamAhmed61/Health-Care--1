class AppointmentModel {
  final String id;
  final String patientId;
  final String date;
  final String time;
  final String status;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
        id: json['_id'],
        patientId: json['patientId'],
        date: json['date'],
        time: json['time'],
        status: json['status'],
    );
  }
}