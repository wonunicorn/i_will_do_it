
part of 'search_task_list_cubit.dart';

class SearchTaskListState{}

class SearchTaskListInitialState extends SearchTaskListState{}

class SearchTaskListLoadingState extends SearchTaskListState{}

class SearchTaskListLoadedState extends SearchTaskListState{
  List<TaskModel> taskList;
  SearchTaskListLoadedState(this.taskList);
}

class SearchTaskListErrorState extends SearchTaskListState{}