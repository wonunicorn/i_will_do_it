
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:i_will_do_it/widgets/containers/task_container.dart';
import 'package:i_will_do_it/widgets/loader_overlay/loader_overlay.dart';
import 'package:intl/intl.dart';


class HomeTodayScreen extends StatefulWidget {
  const HomeTodayScreen({super.key, required this.selectedDate});
  final SelectedDate selectedDate;

  @override
  State<HomeTodayScreen> createState() => _HomeTodayScreenState();
}

class _HomeTodayScreenState extends State<HomeTodayScreen> with AutomaticKeepAliveClientMixin{
  final service = TaskService();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TodayTaskListCubit, TodayTaskListState>(
      builder: (context, state) {
        if(state is TodayTaskListLoadedState){
          if(state.taskList.isNotEmpty){
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Today", style: AppTextStyle.header38),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(DateFormat("dd.MM.yyyy").format(DateTime.now()), style: AppTextStyle.header38),
                        ),
                        const SizedBox(height: 40),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.taskList.length,
                          itemBuilder: (context, index){
                            final task = state.taskList[index];

                            return Column(
                              children: [
                                TaskContainer(
                                  title: task.name ?? "Task",
                                  tag: task.tag ?? "",
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
                                        context.read<SearchTaskListCubit>().check();
                                        context.read<FullTaskListCubit>().check();
                                      }
                                    });
                                  },
                                  deleteTask: () async{
                                    final response = await service.deleteTask(task);
                                    if(response){
                                      setState(() {});
                                      context.read<TodayTaskListCubit>().check();
                                      context.read<SearchTaskListCubit>().check();
                                      context.read<FullTaskListCubit>().check();
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                        if(state.taskList.length >= 4)
                          Column(
                            children: [
                              const SizedBox(height: 50),
                              Center(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(99),
                                  onTap: (){
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
                                      builder: (context) => const AddNewTaskBottomSheet(),
                                    ).then((value) {
                                      if(value == true){
                                        context.read<TodayTaskListCubit>().check();
                                        context.read<SearchTaskListCubit>().check();
                                        context.read<FullTaskListCubit>().check();
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 84,
                                    width: 84,
                                    decoration: BoxDecoration(
                                      color: AppColors.blueColor,
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset("assets/icons/plus.svg"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                if(state.taskList.length < 4)
                  Positioned(
                    bottom: 30,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(99),
                          onTap: (){
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
                              builder: (context) => const AddNewTaskBottomSheet(),
                            ).then((value) {
                              if(value == true){
                                context.read<TodayTaskListCubit>().check();
                                context.read<SearchTaskListCubit>().check();
                                context.read<FullTaskListCubit>().check();
                              }
                            });
                          },
                          child: Container(
                            height: 84,
                            width: 84,
                            decoration: BoxDecoration(
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Center(
                              child: SvgPicture.asset("assets/icons/plus.svg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
          else{
            return Stack(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Text("What are you planning to do today?",
                          style: AppTextStyle.header38),
                    )),
                Positioned(
                  bottom: 30,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(99),
                        onTap: (){
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
                            builder: (context) => const AddNewTaskBottomSheet(),
                          ).then((value) {
                            if(value == true){
                              context.read<TodayTaskListCubit>().check();
                              context.read<SearchTaskListCubit>().check();
                              context.read<FullTaskListCubit>().check();
                            }
                          });
                        },
                        child: Container(
                          height: 84,
                          width: 84,
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/icons/plus.svg"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }
        else if(state is TodayTaskListLoadingState){
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const LoaderOverlayWidget(),
          );
        }
        return Container();

      }
    );
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
