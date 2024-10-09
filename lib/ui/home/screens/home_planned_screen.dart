import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_will_do_it/bloc/calendar_task_list/calendar_task_list_bloc.dart';
import 'package:i_will_do_it/bloc/calendar_task_list/full_task_list/full_task_list_cubit.dart';
import 'package:i_will_do_it/bloc/search_task_list/search_task_list_cubit.dart';
import 'package:i_will_do_it/bloc/today_task_list/today_task_list_cubit.dart';
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:i_will_do_it/data/repository/change_notifier.dart';
import 'package:i_will_do_it/domain/service/task_service.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';
import 'package:i_will_do_it/widgets/bottom_sheet/add_task_bottom_sheet.dart';
import 'package:i_will_do_it/widgets/calendar/calendar_wheel.dart';
import 'package:i_will_do_it/widgets/containers/task_container.dart';
import 'package:i_will_do_it/widgets/loader_overlay/loader_overlay.dart';
import 'package:intl/intl.dart';


class HomePlannedScreen extends StatefulWidget {
  const HomePlannedScreen({super.key, required this.selectedDate});
  final SelectedDate selectedDate;

  @override
  State<HomePlannedScreen> createState() => _HomePlannedScreenState();
}

class _HomePlannedScreenState extends State<HomePlannedScreen> with AutomaticKeepAliveClientMixin{
  final service = TaskService();
  Map<DateTime, List<TaskModel>> taskMap = {};

  changeList(Map<DateTime, List<TaskModel>> taskList){
    if(widget.selectedDate.date != null){
      if(taskList.isNotEmpty){
        taskList = SplayTreeMap<DateTime, List<TaskModel>>.from(taskList, (a, b) => a.compareTo(b));

        DateTime newDate = DateTime(widget.selectedDate.date!.year, widget.selectedDate.date!.month, widget.selectedDate.date!.day);

        if(taskList.containsKey(newDate)){
          List<TaskModel> taskValue = taskList[newDate] ?? [];

          taskList.remove(newDate);

          if(taskList.containsKey(newDate)){
          }
          else{
            taskMap = {newDate : taskValue ,...taskList};
          }
        }
      }
    }
    else{
      taskMap = taskList;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListenableBuilder(
      listenable: widget.selectedDate,
      builder: (context, child) {
        return BlocBuilder<FullTaskListCubit, FullTaskListState>(
          builder: (context, listState) {
            if(listState is FullTaskListLoadedState){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Planned", style: AppTextStyle.header38),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CalendarWheel(selectedDate: widget.selectedDate),
                    ),
                    BlocBuilder<CalendarTaskListBloc, CalendarTaskListState>(
                        builder: (context, state) {
                          changeList(listState.taskList);

                          if(state is CalendarTaskListLoadingState){
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 2.3,
                              child: const LoaderOverlayWidget(),
                            );
                          }

                          return ListView.builder(
                              itemCount: taskMap.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, dateIndex) {
                                final key = taskMap.keys.toList()[dateIndex];
                                final value = taskMap.values.toList()[dateIndex];
                                value.isNotEmpty ? value.sort((a,b) => a.priorityIndex!.compareTo(b.priorityIndex!)) : [];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        getDate(key),
                                        style: AppTextStyle.text20.copyWith(color: getColor(key)),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: value.length,
                                      itemBuilder: (context, index){
                                        final task = value[index];

                                        return Column(
                                          children: [
                                            TaskContainer(
                                              title: task.name ?? "",
                                              tag: task.tag ?? "",
                                              isPlanned: true,
                                              isSlidable: false,
                                              color: getPriorityColor(task.priority),
                                              editTask: () async{
                                                showModalBottomSheet(
                                                  useSafeArea: true,
                                                  backgroundColor: AppColors.whiteColor,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.vertical(
                                                      top: Radius.circular(60),
                                                    ),
                                                  ),
                                                  context: context,
                                                  builder: (context) => AddNewTaskBottomSheet(task: task),
                                                ).then((value) {
                                                  if(value == true){
                                                    context.read<TodayTaskListCubit>().check();
                                                    context.read<FullTaskListCubit>().check();
                                                    context.read<SearchTaskListCubit>().check();
                                                  }
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        }
                    ),
                  ],
                ),
              );
            }
            else{
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const LoaderOverlayWidget(),
              );
            }
          }
        );
      }
    );
  }

  String getDate(DateTime date){
    DateTime today = DateTime.now();
    if(date.year == today.year && date.month == today.month && date.day == today.day){
      return "${DateFormat("d MMM").format(date)}. - Today - ${DateFormat("EEEE").format(date)}";
    }
    else{
      return "${DateFormat("d MMM").format(date)}. - ${DateFormat("EEEE").format(date)}";
    }
  }

  Color getColor(DateTime date){
    final selectedValue = widget.selectedDate.date;
    if(widget.selectedDate.date != null){
      if(date.year == selectedValue!.year && date.month == selectedValue.month && date.day == selectedValue.day){
        return AppColors.darkBlackColor;
      }
    }
    return AppColors.greyAAColor;
  }

  Color getPriorityColor(String? priority){
    if(priority == "priority 1"){
      return AppColors.redColor;
    }else if(priority == "priority 2"){
      return AppColors.yellowColor;
    }else if(priority == "priority 3"){
      return AppColors.greenColor;
    } else{
      return AppColors.greyColor;
    }
  }
}
