
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:i_will_do_it/domain/service/task_service.dart';
import 'package:intl/intl.dart';

part 'today_task_list_state.dart';

class TodayTaskListCubit extends Cubit<TodayTaskListState>{
  TodayTaskListCubit() : super(TodayTaskListInitialState());

  final service = TaskService();

  check() async{
    emit(TodayTaskListLoadingState());

    String date = DateFormat("dd.MM.yyyy").format(DateTime.now());
    final response = await service.getTaskList(date);

    if(response.isNotEmpty){
      response.sort((a,b) => a.priorityIndex!.compareTo(b.priorityIndex!));
      emit(TodayTaskListLoadedState(response));
    }
    else{
      emit(TodayTaskListLoadedState(response));
    }


  }
}