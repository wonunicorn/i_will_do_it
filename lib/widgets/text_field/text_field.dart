
import 'package:flutter/material.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';

class CustomTextFieldLabel extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;

  const CustomTextFieldLabel({
    super.key,
    required this.controller,
    this.maxLines,
    this.minLines
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyAAColor),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      child: TextFormField(
        minLines: minLines ?? 1,
        maxLines: maxLines,
        controller: controller,
        style: AppTextStyle.boldText600,
        decoration: const InputDecoration(
          counterText: "",
          isDense: true,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

