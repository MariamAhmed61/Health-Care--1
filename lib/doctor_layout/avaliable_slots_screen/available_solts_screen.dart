import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:health_care_app/auth/data/models/available_slot_model.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/cubits/available_slot_cubit/available_slots_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvailableSlotsScreen extends StatefulWidget {
  static const routeName = 'available';

  const AvailableSlotsScreen({super.key});

  @override
  State<AvailableSlotsScreen> createState() => _AvailableSlotsScreenState();
}

class _AvailableSlotsScreenState extends State<AvailableSlotsScreen> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    context.read<AvailableSlotsCubit>().fetchAvailableSlots();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        timeController.text = '$hour:$minute';
      });
    }
  }

  Future<void> addSlot() async {
    if (dateController.text.isEmpty || timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseEnterDateTime)),
      );
      return;
    }

    final date = dateController.text;
    final time = timeController.text;
    final slotModel = AvailableSlotModel(date: date, times: [time]);

    context.read<AvailableSlotsCubit>().addSlot(slotModel);
    await context.read<AvailableSlotsCubit>().updateAvailableSlots();

    dateController.clear();
    timeController.clear();
  }

  void confirmDeleteSlot(BuildContext context, int index, AvailableSlotModel slot) {
    if (slot.times.length == 1) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.deleteSlot),
          content: Text(AppLocalizations.of(context)!.confirmDeleteSlot),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel,
                style:const TextStyle(color: Colors.black),),
            ),
            TextButton(
              onPressed: () async {
                context.read<AvailableSlotsCubit>().deleteSlot(index);
                Navigator.pop(context);
                await context.read<AvailableSlotsCubit>().updateAvailableSlots();
              },
              child:  Text(AppLocalizations.of(context)!.delete,
                style:const TextStyle(color: AppColors.primaryColor),),
            ),
          ],
        ),
      );
    } else {
      final times = List<String>.from(slot.times)
        ..sort((a, b) => a.compareTo(b));

      String? selectedTime;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectTimeToDelete),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: times.map((t) {
              return RadioListTile<String>(
                value: t,
                groupValue: selectedTime,
                title: Text(t),
                onChanged: (value) async {
                  selectedTime = value;
                  Navigator.of(context).pop();
                  context.read<AvailableSlotsCubit>().deleteSlotTime(context, index, selectedTime!);
                  await context.read<AvailableSlotsCubit>().updateAvailableSlots();
                },
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                   AppLocalizations.of(context)!.available ,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: dateController,
                          readOnly: true,
                          onTap: pickDate,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.selectDate,
                            prefixIcon: Icon(Icons.date_range),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: timeController,
                          readOnly: true,
                          onTap: pickTime,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.selectTime,
                            prefixIcon: Icon(Icons.access_time),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: addSlot,
                          icon: const Icon(Icons.add, color: AppColors.primaryColor),
                          label: Text(
                            AppLocalizations.of(context)!.addSlot,
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
                      builder: (context, state) {
                        if (state is AvailableSlotsLoading) {
                          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
                        } else if (state is AvailableSlotsLoaded) {
                          final slots = List<AvailableSlotModel>.from(state.slots)
                            ..sort((a, b) => a.date.compareTo(b.date));

                          return ListView.builder(
                            itemCount: slots.length,
                            itemBuilder: (context, index) {
                              final slot = slots[index];
                              final sortedTimes = List<String>.from(slot.times)
                                ..sort((a, b) => a.compareTo(b));

                              return Card(
                                color: AppColors.primaryColor,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text(
                                    slot.date,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    sortedTimes.join(', '),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: const Icon(Icons.delete, color: Colors.white),
                                  onTap: () => confirmDeleteSlot(context, index, slot),
                                ),
                              );
                            },
                          );
                        } else if (state is AvailableSlotsError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
                    builder: (context, state) {
                      if (state is AvailableSlotsSuccess) {
                        return Text(AppLocalizations.of(context)!.slotsUpdated);
                      } else if (state is AvailableSlotsError) {
                        return Text('${AppLocalizations.of(context)!.updateFailed}${state.message}');
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
        );
    }
}