import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

enum TimeSlot { morning, afternoon, evening }

class CalendarController extends GetxController {
  var currentDate = DateTime.now().obs;

  var plants = <String>['🌶 Chili', '🥬 Vegetables', '🍅 Tomato'].obs;

  var events = <String, List<String>>{}.obs;

  String get monthYear => DateFormat('MMMM yyyy').format(currentDate.value);

  int get daysInMonth => 7;

  String _key(DateTime date, TimeSlot slot) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    return "$dateStr-${slot.name}";
  }

  IconData getSlotIcon(TimeSlot slot) {
    switch (slot) {
      case TimeSlot.morning:
        return Icons.wb_sunny;
      case TimeSlot.afternoon:
        return Icons.wb_cloudy;
      case TimeSlot.evening:
        return Icons.nightlight_round;
    }
  }

  void addEvent(DateTime date, TimeSlot slot, String plant) {
    final key = _key(date, slot);

    if (events[key] == null) {
      events[key] = [];
    }

    events[key]!.add(plant);
    events.refresh();
  }

  void removeEvent(DateTime date, TimeSlot slot, String plant) {
    final key = _key(date, slot);

    events[key]?.remove(plant);

    if (events[key]?.isEmpty ?? false) {
      events.remove(key);
    }

    events.refresh();
  }

  List<String> getEvents(DateTime date, TimeSlot slot) {
    return events[_key(date, slot)] ?? [];
  }

  void nextMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month + 1,
    );
  }

  void prevMonth() {
    currentDate.value = DateTime(
      currentDate.value.year,
      currentDate.value.month - 1,
    );
  }
}
