
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer(
      {super.key,
      required this.title,
      required this.tag,
      required this.color,
      this.deleteTask,
      this.editTask,
      this.isSlidable = true,
      this.isPlanned = false});

  final String title;
  final String tag;
  final Color color;
  final bool isPlanned;
  final Function()? deleteTask;
  final Function()? editTask;
  final bool isSlidable;

  @override
  Widget build(BuildContext context) {
    return isSlidable
        ? Slidable(
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: [
                const SizedBox(width: 20),
                InkWell(
                  onTap: editTask,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: AppColors.whiteColor,
                    height: 22,
                    width: 22,
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/edit.svg',
                        color: AppColors.darkBlackColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: deleteTask,
                  child: Container(
                    color: AppColors.whiteColor,
                    height: 22,
                    width: 22,
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/trash.svg',
                        color: AppColors.darkBlackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: editTask,
              child: customContainer(context),
            ),
          )
        : GestureDetector(onTap: editTask, child: customContainer(context));
  }

  Widget customContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              //offset: Offset(0, 3),
            ),
          ]),
      child: isPlanned
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.blueColor, width: 3)),
                ),
                tag != ""
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              title.length >= 20 ?
                              FittedBox(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 190 ,
                                  child: Text(
                                    title,
                                    style: AppTextStyle.text22,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    //softWrap: false,
                                  ),
                                ),
                              ) : Text(title, style: AppTextStyle.text22),
                              const SizedBox(width: 20),
                              Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(tag, style: AppTextStyle.boldText600)
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              title.length >= 20 ?
                              FittedBox(
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 190,
                                      child: Text(
                                        title,
                                        style: AppTextStyle.text22,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )))
                              : Text(title, style: AppTextStyle.text22),
                              const SizedBox(width: 20),
                              Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
              ],
            )
          : tag != ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(child: Text(title, style: AppTextStyle.text22)),
                        const SizedBox(width: 20),
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(tag, style: AppTextStyle.boldText600)
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Flexible(
                            child: Text(title, style: AppTextStyle.text22)),
                        const SizedBox(width: 20),
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
    );
  }
}
