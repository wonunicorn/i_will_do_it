
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';
import 'package:i_will_do_it/widgets/buttons/add_button.dart';


class TaskPriorityDialog extends StatelessWidget { 
  const TaskPriorityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                      "assets/icons/close.svg",
                      height: 20,
                      width: 20,
                      color: AppColors.blueColor),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  const Text("Сhoose task priority", style: AppTextStyle.header28),
                  const SizedBox(height: 30),
                  AddButton(
                    onTap: () => Navigator.pop(context, "red"),
                    isBlueButton: true,
                    color: AppColors.redColor,
                    title: "Priority 1",
                  ),
                  const SizedBox(height: 10),
                  AddButton(
                    onTap: () => Navigator.pop(context, "yellow"),
                    isBlueButton: true,
                    color: AppColors.yellowColor,
                    title: "Priority 2",
                  ),
                  const SizedBox(height: 10),
                  AddButton(
                    onTap: () => Navigator.pop(context, "green"),
                    isBlueButton: true,
                    color: AppColors.greenColor,
                    title: "Priority 3",
                  ),
                  const SizedBox(height: 10),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
