import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/bloc/calendar_task_list/calendar_task_list_bloc.dart';
import 'package:i_will_do_it/data/repository/change_notifier.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';


class CalendarWheel extends StatefulWidget {
  const CalendarWheel({super.key, required this.selectedDate});
  final SelectedDate selectedDate;

  @override
  State<CalendarWheel> createState() => _CalendarWheelState();
}

class _CalendarWheelState extends State<CalendarWheel> {
  DateTime? selectedDate;

  int currentDateSelectedIndex = -1;
  ScrollController scrollController = ScrollController();

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfFullMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              getUpperText(),
              style: AppTextStyle.text20,
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              "assets/icons/arrow_down.svg",
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.whiteColor,
            height: 123,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
              itemCount: 365,
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentDateSelectedIndex = index;
                      selectedDate = DateTime.now().add(Duration(days: index));
                      widget.selectedDate.select(selectedDate!);
                    });

                    context.read<CalendarTaskListBloc>().add(CalendarTaskListGetEvent(selectedDate!));
                  },
                  child: Container(
                    width: 80,
                    height: 123,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(37),
                        color: currentDateSelectedIndex == index
                            ? AppColors.blueColor
                            : AppColors.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          listOfDays[DateTime.now()
                              .add(Duration(days: index)).weekday - 1]
                              .toString(),
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              height: 21 / 23,
                              color: currentDateSelectedIndex == index
                                  ? AppColors.whiteColor
                                  : AppColors.blackGreyColor),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          DateTime.now().add(Duration(days: index)).day.toString(),
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w300,
                              height: 21 / 23,
                              color: currentDateSelectedIndex == index
                                  ? AppColors.whiteColor
                                  : AppColors.blackGreyColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
        const SizedBox(height: 30),
      ],
    );
  }

  String getUpperText(){
    if(widget.selectedDate.date != null){
      return "${listOfFullMonths[widget.selectedDate.date!.month - 1]}, ${widget.selectedDate.date!.year}";
    }
    return "${listOfFullMonths[DateTime.now().month - 1]}, ${DateTime.now().year}";
  }
}

