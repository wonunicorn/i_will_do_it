
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_will_do_it/bloc/search_task_list/search_task_list_cubit.dart';
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/widgets/containers/search_container.dart';
import 'package:i_will_do_it/widgets/containers/task_container.dart';
import 'package:i_will_do_it/widgets/loader_overlay/loader_overlay.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> with AutomaticKeepAliveClientMixin{
  List<TaskModel> searchTaskList = [];
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SearchTaskListCubit, SearchTaskListState>(
      builder: (context, state) {
        if(state is SearchTaskListLoadedState){
          return GestureDetector(
            onTap: (){
              if (!FocusScope.of(context).hasPrimaryFocus) {
                FocusScope.of(context).focusedChild?.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchContainer(
                      controller: controller,
                      onChanged: (val){
                        if (val.isEmpty) {
                          setState(() {
                            searchTaskList.clear();
                          });
                        }
                        else {
                          if(state.taskList.isNotEmpty){
                            for (var element in state.taskList) {
                              if(element.name != null){
                                if(element.name!.toLowerCase().contains(val.toLowerCase())){
                                  if(!searchTaskList.contains(element)){
                                    setState(() {
                                      searchTaskList.add(element);
                                    });
                                  }
                                }
                                else if(searchTaskList.contains(element)){
                                  setState(() {
                                    searchTaskList.remove(element);
                                  });
                                }
                              }
                            }
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchTaskList.length,
                    itemBuilder: (context, index){
                      final task = searchTaskList[index];

                      return Column(
                        children: [
                          TaskContainer(
                            title: task.name ?? "Task",
                            tag: task.tag ?? "",
                            color: getPriorityColor(task.priority),
                            isSlidable: false,
                            isPlanned: false,
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        else if(state is SearchTaskListLoadingState){
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.8,
            child: const LoaderOverlayWidget(),
          );
        }
        return Container();

      }
    );
  }

  Color getPriorityColor(String? priority){
    if(priority == "priority 1"){
      return AppColors.redColor;
    }else if(priority == "priority 2"){
      return AppColors.yellowColor;
    }else if(priority == "priority 3"){
      return AppColors.greenColor;
    } else{
      return AppColors.greyColor;
    }
  }

}
