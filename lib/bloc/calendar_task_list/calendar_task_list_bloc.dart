import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_task_list_event.dart';
part 'calendar_task_list_state.dart';

class CalendarTaskListBloc extends Bloc<CalendarTaskListEvent, CalendarTaskListState>{
  CalendarTaskListBloc() : super(CalendarTaskListInitialState()){
        on<CalendarTaskListGetEvent>(_get);
  }

  Future<void> _get(CalendarTaskListGetEvent event, Emitter<CalendarTaskListState> emit) async {
    emit(CalendarTaskListLoadingState());
    DateTime dateSelected2 = DateTime(event.date.year, event.date.month, event.date.day);
    emit(CalendarTaskListLoadedState(dateSelected2));
  }
}
