import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';

class OnboardingSelectContainer extends StatefulWidget {
  const OnboardingSelectContainer({Key? key}) : super(key: key);

  @override
  State<OnboardingSelectContainer> createState() => _OnboardingSelectContainerState();
}

class _OnboardingSelectContainerState extends State<OnboardingSelectContainer> {
  List<String> selectedType = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            if(selectedType.contains("Personal")){
              setState(() {
                selectedType.remove("Personal");
              });
            }
            else{
              setState(() {
                selectedType.add("Personal");
              });
            }
          },
          child: Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Personal", style: AppTextStyle.boldText600),
                selectedType.contains("Personal")
                    ? SvgPicture.asset("assets/icons/checkmark.svg", height: 18, width: 18)
                    : Container()
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: (){
            if(selectedType.contains("For work")){
              setState(() {
                selectedType.remove("For work");
              });
            }
            else{
              setState(() {
                selectedType.add("For work");
              });
            }
          },
          child: Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("For work", style: AppTextStyle.boldText600,),
                selectedType.contains("For work")
                    ? SvgPicture.asset("assets/icons/checkmark.svg", height: 18, width: 18)
                    : Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
