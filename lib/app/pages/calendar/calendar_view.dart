import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  CalendarView({super.key});

  Future<void> _pickMonth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: controller.currentDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      controller.currentDate.value = DateTime(picked.year, picked.month);
    }
  }

  Widget buildCell(
    DateTime date,
    TimeSlot slot,
    double cellWidth,
    double cellHeight,
  ) {
    return Obx(() {
      final events = controller.getEvents(date, slot);

      return DragTarget<String>(
        onAccept: (plant) => controller.addEvent(date, slot, plant),
        builder: (_, __, ___) {
          return Container(
            margin: EdgeInsets.all(cellWidth * 0.05),
            padding: EdgeInsets.all(cellWidth * 0.08),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(cellWidth * 0.15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...events.map(
                  (e) => GestureDetector(
                    onTap: () => controller.removeEvent(date, slot, e),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: cellHeight * 0.02),
                      padding: EdgeInsets.symmetric(
                        horizontal: cellWidth * 0.1,
                        vertical: cellHeight * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        e,
                        style: GoogleFonts.poppins(fontSize: cellWidth * 0.12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cellWidth = (screenWidth * 0.22).clamp(70.0, 110.0);
    final rowHeight = (screenHeight * 0.13).clamp(90.0, 130.0);
    final maeWidth = (screenWidth * 0.12).clamp(40.0, 60.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),

            Text(
              "Jadwal Penyiraman",
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: screenHeight * 0.015),

            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: SizedBox(
                height: screenHeight * 0.08,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.plants.length,
                    itemBuilder: (_, i) {
                      final plant = controller.plants[i];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Draggable<String>(
                          data: plant,
                          feedback: Material(
                            color: Colors.transparent,
                            child: Chip(
                              label: Text(
                                plant,
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          ),
                          child: Chip(
                            label: Text(plant, style: GoogleFonts.poppins()),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: controller.prevMonth,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    GestureDetector(
                      onTap: () => _pickMonth(context),
                      child: Text(
                        controller.monthYear,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: controller.nextMonth,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            Expanded(
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: rowHeight * 0.4),
                      ...TimeSlot.values.map(
                        (slot) => SizedBox(
                          height: rowHeight,
                          width: maeWidth,
                          child: Center(
                            child: Text(
                              controller.getSlotLabel(slot),
                              style: GoogleFonts.poppins(
                                fontSize: maeWidth * 0.4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              children: List.generate(
                                controller.daysInMonth,
                                (i) => SizedBox(
                                  width: cellWidth,
                                  height: rowHeight * 0.4,
                                  child: Center(
                                    child: Text(
                                      "${i + 1}",
                                      style: GoogleFonts.poppins(
                                        fontSize: cellWidth * 0.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            ...TimeSlot.values.map((slot) {
                              return SizedBox(
                                height: rowHeight,
                                child: Row(
                                  children: List.generate(
                                    controller.daysInMonth,
                                    (i) {
                                      final date = DateTime(
                                        controller.currentDate.value.year,
                                        controller.currentDate.value.month,
                                        i + 1,
                                      );

                                      return SizedBox(
                                        width: cellWidth,
                                        child: buildCell(
                                          date,
                                          slot,
                                          cellWidth,
                                          rowHeight,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.02),
                child: SvgPicture.asset(
                  "assets/icon/tumbuhan.svg",
                  height: screenHeight * 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
