import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/doctor_response.dart';

class PatientService {
  static final Dio _dio = Dio()
    ..options = BaseOptions(
      baseUrl: 'http://healthcare-4scv.vercel.app/api/',
    );

  static Future<List<Doctor>?> getDoctors() async {
    try {
      final response = await _dio.get('doctors/doctors');
      if (response.statusCode == 200) {
        var json = response.data;
        if (json['data'] != null && json['data'] is List) {
          var doctors = (json['data'] as List)
              .map((doctorJson) => Doctor.fromJson(doctorJson))
              .toList();
          return doctors;
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching doctors: $e');
      return null;
    }
  }

  static Future<Doctor?> getDoctorById(String id) async {
    try {
      final response = await _dio.get('doctors/doctors/$id');
      if (response.statusCode == 200) {
        var json = response.data;
        if (json['data'] != null && json['data'] is Map<String, dynamic>) {
          var doctor = Doctor.fromJson(json['data']);
          debugPrint('Fetched doctor: ${doctor.firstName}');
          return doctor;
        } else {
          debugPrint('No valid doctor data found in response');
          return null;
        }
      } else {
        debugPrint('API request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching doctor by ID: $e');
      return null;
    }
  }

  static Future<bool> rateDoctor({
    required String doctorId,
    required String userId,
    required int rating,
  }) async {
    try {
      final response = await _dio.post(
        'https://healthcare-4scv.vercel.app/api/doctors/doctors/rate',
        data: {
          'rating': rating,
          'userId': userId,
          'doctorId': doctorId,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
          validateStatus: (status) => true,
        ),
      );

      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.data}');

      return response.statusCode == 200 &&
          response.data["status"] == "success";
    } catch (e) {
      log("Rating failed: $e");
      return false;
    }
  }


//   Future<void> fetchDoctorTimes(String doctorId, DateTime selectedDate) async {
//     emit(AppointmentLoading());
//     try {
//       final response = await _dio.get('/appointments/doctor/$doctorId');

//       final allAppointments = List<Map<String, dynamic>>.from(response.data['appointments'] ?? []);

//       // تحويل التاريخ الحالي لصيغة yyyy-MM-dd للمقارنة
//       final selectedDateStr = selectedDate.toIso8601String().split('T').first;

//       // فلترة المواعيد حسب التاريخ المطلوب
//       final filteredTimes = allAppointments
//           .where((appointment) => appointment['date'] == selectedDateStr)
//           .map<String>((appointment) => appointment['time'].toString())
//           .toList();

//       emit(AppointmentTimesLoaded(filteredTimes));
//     } catch (e) {
//       emit(AppointmentError("فشل في تحميل المواعيد"));
//     }
//   }


//   static Future<bool> bookAppointment({
//   required String doctorId,
//   required String patientId,
//   required String date,
//   required String time,
//   required String paymentMethod,
// }) async {
//   try {
//     final response = await _dio.post(
//       'appointments/book',
//       data: {
//         'doctorId': doctorId,
//         'patientId': patientId,
//         'date': date,
//         'time': time,
//         'paymentMethod': paymentMethod,
//       },
//     );
//     return response.statusCode == 201;
//   } catch (e) {
//     log('Error booking appointment: $e');
//     return false;
//   }
// }

// static Future<bool> cancelAppointment(String appointmentId) async {
//   try {
//     final response = await _dio.delete(
//       'appointments/cancel/$appointmentId',
//     );
//     return response.statusCode == 200;
//   } catch (e) {
//     log('Error canceling appointment: $e');
//     return false;
//   }
// }
}
