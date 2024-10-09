
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:i_will_do_it/domain/service/database_service.dart';

class TaskService{
  DatabaseService databaseService = DatabaseService();

  Future<List<TaskModel>> getFullTaskList() async {
    try {

      await databaseService.initializeDatabase();
      final info = await databaseService.getAllTasks();

      List<TaskModel> listTask = [];

      if(info.isNotEmpty){
        for (var element in info) {
          TaskModel taskModel = TaskModel.fromMapObject(element);
          listTask.add(taskModel);
        }
      }
      return listTask;

    } catch (err) {
      return [];
    }
  }

  Future<List<TaskModel>> getTaskList(String date) async {
    try {
      await databaseService.initializeDatabase();
      final info = await databaseService.getTask(date);

      List<TaskModel> listTask = [];

      if(info.isNotEmpty){
        for (var element in info) {
          TaskModel taskModel = TaskModel.fromMapObject(element);
          listTask.add(taskModel);
        }
      }
      return listTask;

    } catch (err) {
      return [];
    }
  }

  Future<bool> addNewTask(TaskModel taskModel) async {
    try {
      await databaseService.initializeDatabase();
      await databaseService.insertTask(taskModel);

      return true;

    } catch (err) {
      return false;
    }
  }


  Future<bool> updateTask(TaskModel newTask, TaskModel oldTask) async {
    try {
      await databaseService.initializeDatabase();
      var test = await databaseService.updateTask(newTask, oldTask);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> deleteTask(TaskModel taskModel) async {
    try {
      await databaseService.initializeDatabase();

      var test = await databaseService.deleteTask(taskModel);
      return true;
    } catch (err) {
      return false;
    }
  }
}