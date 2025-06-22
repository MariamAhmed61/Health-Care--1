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

}
