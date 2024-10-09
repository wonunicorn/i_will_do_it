
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:i_will_do_it/domain/service/task_service.dart';
import 'package:intl/intl.dart';

part 'search_task_list_state.dart';

class SearchTaskListCubit extends Cubit<SearchTaskListState>{
  SearchTaskListCubit() : super(SearchTaskListInitialState());

  final service = TaskService();

  check() async{
    emit(SearchTaskListLoadingState());
    List<TaskModel> tasksList = [];

    final list = await service.getFullTaskList();

    if(list.isNotEmpty){
      for (var element in list) {
        if(element.date != null){

          var date1 = DateFormat('dd.MM.yyyy HH:mm').parse('${element.date} 00:00');
          String newDate = DateFormat('yyyy-MM-dd').format(date1);
          DateTime date2 = DateTime.parse(newDate);

          if(date2.difference(DateTime.now()).inDays >= 0){
            tasksList.add(element);
          }
        }
      }
    }

    emit(SearchTaskListLoadedState(tasksList));
  }
}