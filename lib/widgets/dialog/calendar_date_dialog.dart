
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/data/repository/change_notifier.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:intl/intl.dart';

class CalendarDateDialog extends StatefulWidget {
  const CalendarDateDialog({super.key, required this.selectedDate});
  final SelectedStringDate selectedDate;

  @override
  State<CalendarDateDialog> createState() => _CalendarDateDialogState();
}

class _CalendarDateDialogState extends State<CalendarDateDialog> {
  DateTime selectedDate = DateTime.now();
  String currentMonth = DateFormat("MMMM yyyy").format(DateTime.now());
  DateTime targetDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                          "assets/icons/close.svg",
                          height: 20,
                          width: 20,
                          color: AppColors.blueColor),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          setState(() {
                            targetDateTime = DateTime(targetDateTime.year, targetDateTime.month - 1);
                            currentMonth = DateFormat("MMMM yyyy").format(targetDateTime);
                          });
                        },
                        child: SvgPicture.asset("assets/icons/arrow_left.svg"),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          setState(() {
                            targetDateTime = DateTime(targetDateTime.year, targetDateTime.month + 1);
                            currentMonth = DateFormat("MMMM yyyy").format(targetDateTime);
                          });
                        },
                        child: SvgPicture.asset("assets/icons/arrow_right.svg", color: AppColors.blueColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 45, left: 15, right: 15),
                    child: CalendarCarousel(
                      headerMargin: const EdgeInsets.only(bottom: 20),
                      headerText: currentMonth,
                      todayButtonColor: AppColors.whiteColor,
                      todayBorderColor: Colors.transparent,
                      selectedDayButtonColor: AppColors.blueColor,
                      targetDateTime: targetDateTime,
                      onDayPressed: (date, events) {
                        setState(() {
                          selectedDate = date;
                          if(selectedDate.year == DateTime.now().year && selectedDate.month == DateTime.now().month && selectedDate.day == DateTime.now().day){
                            widget.selectedDate.select("Today");
                          }
                          else{
                            widget.selectedDate.select(DateFormat("dd.MM.yyyy").format(selectedDate));
                          }
                        });
                      },
                      todayTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 16 / 14,
                        color: AppColors.blueColor,
                      ),
                      selectedDayBorderColor: AppColors.blueColor,
                      daysHaveCircularBorder: true,
                      showOnlyCurrentMonthDate: false,
                      firstDayOfWeek: 1,
                      weekdayTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blueColor,
                      ),
                      weekendTextStyle:  const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 16 / 14,
                        color: AppColors.blueColor,
                      ),
                      showHeaderButton: false,
                      weekFormat: false,
                      height: 300.0,
                      headerTextStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 19 / 16,
                        color: AppColors.blueColor,
                      ),
                      selectedDateTime: selectedDate,
                      customGridViewPhysics: const NeverScrollableScrollPhysics(),
                      showHeader: true,
                      selectedDayTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 16 / 14,
                        color: AppColors.whiteColor,
                      ),
                      minSelectedDate: DateTime.now().subtract(const Duration(days: 360)),
                      maxSelectedDate: DateTime.now().add(const Duration(days: 360)),
                      prevDaysTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 16 / 14,
                        color: AppColors.darkGreyColor,
                      ),
                      onCalendarChanged: (DateTime date) {
                        setState(() {
                          targetDateTime = date;
                          currentMonth = DateFormat("MMMM yyyy").format(date);
                        });
                      },
                      inactiveWeekendTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 16 / 14,
                        color: AppColors.blueColor,
                      ),
                      daysTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        height: 16 / 14,
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
