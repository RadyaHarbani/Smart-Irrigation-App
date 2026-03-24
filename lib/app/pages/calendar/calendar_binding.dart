import 'package:get/get.dart';
import 'package:smart_irrigation_app/app/pages/calendar/calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarController());
  }
}