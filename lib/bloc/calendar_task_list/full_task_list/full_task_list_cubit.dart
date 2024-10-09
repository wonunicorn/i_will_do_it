
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:i_will_do_it/domain/service/task_service.dart';
import 'package:intl/intl.dart';

part 'full_task_list_state.dart';

class FullTaskListCubit extends Cubit<FullTaskListState>{
  FullTaskListCubit() : super(FullTaskListInitialState());

  final service = TaskService();

  check() async{
    emit(FullTaskListLoadingState());

    Map<DateTime, List<TaskModel>> taskList = {};

    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    for(int index = 0; index < 365; index++){
      taskList.putIfAbsent(today.add(Duration(days: index)), () => []);
    }

    final response = await service.getFullTaskList();

    if(response.isNotEmpty){
      for (var element in response) {
        if(element.date != null){
          var date1 = DateFormat('dd.MM.yyyy HH:mm').parse('${element.date} 00:00');
          String newDate = DateFormat('yyyy-MM-dd').format(date1);
          DateTime date2 = DateTime.parse(newDate);

          if(date2.difference(DateTime.now()).inDays >= 0){
            if(taskList.containsKey(date2)){
              taskList.update(date2, (value) => value..add(element));
            }
          }
        }
      }

      taskList = SplayTreeMap<DateTime, List<TaskModel>>.from(taskList, (a, b) => a.compareTo(b));

      emit(FullTaskListLoadedState(taskList));
    }
    else{

      taskList = SplayTreeMap<DateTime, List<TaskModel>>.from(taskList, (a, b) => a.compareTo(b));

      emit(FullTaskListLoadedState(taskList));
    }

  }
}