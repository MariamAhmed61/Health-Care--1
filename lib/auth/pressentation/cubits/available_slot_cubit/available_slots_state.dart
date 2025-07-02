part of 'available_slots_cubit.dart';

@immutable
abstract class AvailableSlotsState {}

class AvailableSlotsInitial extends AvailableSlotsState {}

class AvailableSlotsLoading extends AvailableSlotsState {}

class AvailableSlotsLoaded extends AvailableSlotsState {
  final List<AvailableSlotModel> slots;
  AvailableSlotsLoaded(this.slots);
}

class AvailableSlotsSuccess extends AvailableSlotsState {}

class AvailableSlotsError extends AvailableSlotsState {
  final String message;
  AvailableSlotsError(this.message);
}