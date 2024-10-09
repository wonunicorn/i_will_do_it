
import 'package:flutter/material.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';


class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    this.text,
    this.onChanged,
    required this.controller,
  });

  final String? text;
  final Function(String)? onChanged;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        cursorColor: AppColors.blueColor,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        style: AppTextStyle.boldText600.copyWith(color: AppColors.grey96Color),
        decoration: InputDecoration(
            fillColor: AppColors.whiteColor,
            filled: true,
            hintText: text ?? 'Task search',
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            hintStyle: AppTextStyle.boldText600.copyWith(color: AppColors.grey96Color),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey96Color),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey96Color),
                borderRadius: BorderRadius.all(Radius.circular(8)))),
      ),
    );
  }
}