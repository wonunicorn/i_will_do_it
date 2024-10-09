
part of 'full_task_list_cubit.dart';

class FullTaskListState{}

class FullTaskListInitialState extends FullTaskListState{}

class FullTaskListLoadingState extends FullTaskListState{}

class FullTaskListLoadedState extends FullTaskListState{
  Map<DateTime, List<TaskModel>> taskList;
  FullTaskListLoadedState(this.taskList);
}

class FullTaskListErrorState extends FullTaskListState{}