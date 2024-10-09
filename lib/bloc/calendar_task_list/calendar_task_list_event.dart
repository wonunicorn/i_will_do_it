
part of "calendar_task_list_bloc.dart";

class CalendarTaskListEvent{}

class CalendarTaskListGetEvent extends CalendarTaskListEvent{
  DateTime date;
  CalendarTaskListGetEvent(this.date);
}
