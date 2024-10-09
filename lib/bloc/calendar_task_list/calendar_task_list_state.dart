
part of 'calendar_task_list_bloc.dart';

class CalendarTaskListState{}

class CalendarTaskListInitialState extends CalendarTaskListState{}

class CalendarTaskListLoadingState extends CalendarTaskListState{}

class CalendarTaskListLoadedState extends CalendarTaskListState{
  DateTime selectedDate;
  CalendarTaskListLoadedState(this.selectedDate);
}

class CalendarTaskListErrorState extends CalendarTaskListState{}
