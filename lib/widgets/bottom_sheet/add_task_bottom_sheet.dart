import 'package:flutter/material.dart';
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:i_will_do_it/data/repository/change_notifier.dart';
import 'package:i_will_do_it/domain/service/task_service.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';
import 'package:i_will_do_it/widgets/buttons/add_button.dart';
import 'package:i_will_do_it/widgets/dialog/calendar_date_dialog.dart';
import 'package:i_will_do_it/widgets/dialog/tag_dialog.dart';
import 'package:i_will_do_it/widgets/dialog/task_priority_dialog.dart';
import 'package:i_will_do_it/widgets/text_field/text_field.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AddNewTaskBottomSheet extends StatefulWidget {
  const AddNewTaskBottomSheet({super.key, this.task});
  final TaskModel? task;

  @override
  State<AddNewTaskBottomSheet> createState() => _AddNewTaskBottomSheetState();
}

class _AddNewTaskBottomSheetState extends State<AddNewTaskBottomSheet> {
  final SelectedTag selectedTag = SelectedTag();
  final SelectedStringDate selectedDate = SelectedStringDate();
  final service = TaskService();
  DateTime today = DateTime.now();
  bool isPriorityRow = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String isError = "";
  String priority = "";


  check(){
    if(widget.task != null){
      if(widget.task?.name != null){
        setState(() {
          nameController.text = widget.task!.name!;
        });
      }
      if(widget.task?.desc != null){
        setState(() {
          descController.text = widget.task!.desc!;
        });
      }
      if(widget.task?.date != null){
        String newDate = DateFormat("dd.MM.yyyy").format(DateTime.now());
        if(newDate == widget.task!.date!){
          setState(() {
            selectedDate.select("Today");
          });
        }else{
          setState(() {
            selectedDate.select(widget.task!.date!);
          });
        }
      }
      if(widget.task?.tag != null){
        setState(() {
          selectedTag.select(widget.task!.tag!);
        });
      }
      if(widget.task?.priority != null){
        setState(() {
          priority = widget.task!.priority!;
          isPriorityRow = true;
        });
      }
    }
  }


  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: selectedDate,
      builder: (context, child) {
        return ListenableBuilder(
          listenable: selectedTag,
          builder: (context, child) {
            return GestureDetector(
              onTap: (){
                if (!FocusScope.of(context).hasPrimaryFocus) {
                  FocusScope.of(context).focusedChild?.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(60),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text("Task name", style: AppTextStyle.text17.copyWith(color: AppColors.greyE2Color)),
                            const SizedBox(height: 5),
                            CustomTextFieldLabel(controller:  nameController),
                            const SizedBox(height: 20),
                            Text("Description of the task", style: AppTextStyle.text17.copyWith(color: AppColors.greyE2Color)),
                            const SizedBox(height: 5),
                            CustomTextFieldLabel(controller:  descController, maxLines: 25, minLines: 4),
                            const SizedBox(height: 30),
                            AddButton(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context) => CalendarDateDialog(selectedDate: selectedDate),
                                );
                              },
                              title: selectedDate.date,
                            ),
                            const SizedBox(height: 8),
                            AddButton(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context) => const TaskPriorityDialog(),
                                ).then((value) {
                                  if(value != null){
                                    if(value == "red"){
                                      setState(() {
                                        priority = "priority 1";
                                        isPriorityRow = true;
                                      });
                                    }else if(value == "green"){
                                      setState(() {
                                        priority = "priority 3";
                                        isPriorityRow = true;
                                      });
                                    }else{
                                      setState(() {
                                        priority = "priority 2";
                                        isPriorityRow = true;
                                      });
                                    }
                                  }
                                });
                              },
                              isPriorityRow: isPriorityRow,
                              color: getPriorityColor(),
                              title: priority != "" ? priority : "priority",
                            ),
                            const SizedBox(height: 8),
                            AddButton(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context) => TagChooseDialog(selectedTag: selectedTag),
                                );
                              },
                              isUppercase: selectedTag.getTag() != "" ? false : true,
                              title: selectedTag.getTag() != "" ? selectedTag.getTag() : "Tag",
                            ),
                            const SizedBox(height: 30),
                            Visibility(
                              visible: isError != "" ? true : false,
                              child: Text(
                                isError, style: AppTextStyle.text17.copyWith(color: AppColors.redColor),
                              ),
                            ),
                            const SizedBox(height: 10),
                            AddButton(
                              onTap: () async{
                                if(nameController.text.isNotEmpty){
                                  context.loaderOverlay.show();

                                  String todayDate = DateFormat("dd.MM.yyyy").format(DateTime.now());

                                  final newTask = TaskModel(
                                      priorityIndex: getPriorityIndex(priority),
                                      tag: selectedTag.getTag(),
                                      date: selectedDate.date == "Today" ? todayDate : selectedDate.date,
                                      priority: priority,
                                      name: getWithoutSpaces(nameController.text),
                                      desc: descController.text.isNotEmpty ? descController.text : ""
                                  );

                                  var response;

                                  if(widget.task != null){
                                    response = await service.updateTask(newTask, widget.task!);
                                  }
                                  else{
                                    response = await service.addNewTask(newTask);
                                  }

                                  if(response == true){
                                    context.loaderOverlay.hide();
                                    Navigator.pop(context, true);
                                  }
                                  else{
                                    context.loaderOverlay.hide();
                                    setState(() {
                                      isError = "Something went wrong";
                                    });
                                  }
                                }
                                else{
                                  setState(() {
                                    isError = "Write the task name";
                                  });
                                }
                              },
                              title: "save",
                            ),
                            SizedBox(height: widget.task != null ? 10 : 30),

                            if(widget.task != null)
                              Column(
                                children: [
                                  AddButton(
                                    onTap: () async{
                                      final response = await service.deleteTask(widget.task!);
                                      if(response){
                                        Navigator.pop(context, true);
                                      }
                                    },
                                    title: "delete",
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  String getWithoutSpaces(String s){
    while(s.startsWith(' ')){
      s = s.substring(1);
    }
    while(s.endsWith(' ')){
      s = s.substring(0,s.length-1);
    }

    return s;
  }

  int getPriorityIndex(String val){
    if(priority == "priority 1"){
      return 1;
    }else if(priority == "priority 2"){
      return 2;
    }else if(priority == "priority 3"){
      return 3;
    } else{
      return 4;
    }
  }

  Color getPriorityColor(){
    if(priority != ""){
      if(priority == "priority 1"){
        return AppColors.redColor;
      }else if(priority == "priority 2"){
        return AppColors.yellowColor;
      }else if(priority == "priority 3"){
        return AppColors.greenColor;
      } else{
        return AppColors.whiteColor;
      }
    }
    else {
      return AppColors.whiteColor;
    }
  }
}
