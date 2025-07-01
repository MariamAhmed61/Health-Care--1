import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care_app/auth/data/models/available_slot_model.dart';

part 'available_slots_state.dart';

class AvailableSlotsCubit extends Cubit<AvailableSlotsState> {
  AvailableSlotsCubit() : super(AvailableSlotsInitial());

  List<AvailableSlotModel> slots = [];

  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));

  Future<void> fetchAvailableSlots() async {
    emit(AvailableSlotsLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('logged_in_email');

      final response = await dio.get('https://healthcare-4scv.vercel.app/api/doctors/doctors');
      final List allDoctors = response.data['data'];

      final doctor = allDoctors.firstWhere(
            (doc) => doc['email'] == email,
        orElse: () => null,
      );

      if (doctor == null) throw Exception("Doctor not found");

      final List data = doctor['availableSlots'] ?? [];

      slots = data.map((e) => AvailableSlotModel.fromJson(e)).toList();

      slots.sort((a, b) => a.date.compareTo(b.date));
      for (var slot in slots) {
        slot.times.sort((a, b) => _parseTime(a).compareTo(_parseTime(b)));
      }

      emit(AvailableSlotsLoaded(slots));
    } catch (e) {
      emit(AvailableSlotsError('Failed to fetch slots'));
    }
  }

  void addSlot(AvailableSlotModel slot) {
    final index = slots.indexWhere((s) => s.date == slot.date);

    if (index != -1) {
      final existingTimes = slots[index].times;
      final newTimes = slot.times.where((t) => !existingTimes.contains(t)).toList();

      if (newTimes.isEmpty) {
        emit(AvailableSlotsError('Slot already exists for this date.'));
        return;
      }

      slots[index].times.addAll(newTimes);
      slots[index].times.sort((a, b) => _parseTime(a).compareTo(_parseTime(b)));
    } else {
      slots.add(slot);
      slots.sort((a, b) => a.date.compareTo(b.date));
    }

    emit(AvailableSlotsLoaded(List.from(slots)));
  }

  Future<void> updateAvailableSlots() async {
    emit(AvailableSlotsLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('logged_in_email');

      final response = await dio.get('https://healthcare-4scv.vercel.app/api/doctors/doctors');
      final List allDoctors = response.data['data'];
      final doctor = allDoctors.firstWhere((doc) => doc['email'] == email, orElse: () => null);

      if (doctor == null) throw Exception("Doctor not found");

      final doctorId = doctor['_id'];

      final updatedData = {
        'availableSlots': slots.map((e) => e.toJson()).toList(),
      };

      await dio.put(
        'https://healthcare-4scv.vercel.app/api/doctors/$doctorId/available-slots',
        data: updatedData,
      );

      emit(AvailableSlotsSuccess());
      await fetchAvailableSlots();
    } catch (e) {
      emit(AvailableSlotsError('Failed to update slots'));
    }
  }

  Future<void> deleteSlot(int index) async {
    slots.removeAt(index);
    emit(AvailableSlotsLoaded(List.from(slots)));
    await updateAvailableSlots();
  }

  Future<void> deleteSlotTime(BuildContext context, int index, [String? timeToDelete]) async {
    final slot = slots[index];

    if (timeToDelete != null) {
      slot.times.remove(timeToDelete);
      if (slot.times.isEmpty) {
        slots.removeAt(index);
      }
      emit(AvailableSlotsLoaded(List.from(slots)));
      await updateAvailableSlots();
      return;
    }

    final times = List<String>.from(slot.times)
      ..sort((a, b) => _parseTime(a).compareTo(_parseTime(b)));

    if (times.length == 1) {
      slots.removeAt(index);
      emit(AvailableSlotsLoaded(List.from(slots)));
      await updateAvailableSlots();
    } else {
      String? selectedTime;

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Delete Time Slot'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: times.map((t) {
              return RadioListTile<String>(
                value: t,
                groupValue: selectedTime,
                onChanged: (value) {
                  selectedTime = value;
                  Navigator.of(context).pop();
                  deleteSlotTime(context, index, selectedTime);
                },
                title: Text(t),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  DateTime _parseTime(String time) {
    final parts = time.split(':');
    return DateTime(0, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }
}