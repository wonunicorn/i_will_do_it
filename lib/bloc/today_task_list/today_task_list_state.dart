
part of "today_task_list_cubit.dart";

class TodayTaskListState{}

class TodayTaskListInitialState extends TodayTaskListState{}

class TodayTaskListLoadingState extends TodayTaskListState{}

class TodayTaskListLoadedState extends TodayTaskListState{
  List<TaskModel> taskList;
  TodayTaskListLoadedState(this.taskList);
}

class TodayTaskListErrorState extends TodayTaskListState{}