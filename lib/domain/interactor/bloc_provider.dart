import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_will_do_it/bloc/calendar_task_list/calendar_task_list_bloc.dart';
import 'package:i_will_do_it/bloc/calendar_task_list/full_task_list/full_task_list_cubit.dart';
import 'package:i_will_do_it/bloc/search_task_list/search_task_list_cubit.dart';
import 'package:i_will_do_it/bloc/today_task_list/today_task_list_cubit.dart';
import 'package:provider/single_child_widget.dart';

class BlocsProvider{

  List<SingleChildWidget> providers() {
    return [
      BlocProvider(create: (context) => TodayTaskListCubit()..check()),
      BlocProvider(create: (context) => CalendarTaskListBloc()),
      BlocProvider(create: (context) => SearchTaskListCubit()..check()),
      BlocProvider(create: (context) => FullTaskListCubit()..check()),
    ];
  }
}