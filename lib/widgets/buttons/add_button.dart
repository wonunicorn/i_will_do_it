import 'package:flutter/material.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';

class AddButton extends StatelessWidget {
  const AddButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.isPriorityRow = false,
      this.isBlueButton = false,
      this.isUppercase = true,
      this.isOnboardingButton = false,
      this.color});

  final Function() onTap;
  final String title;
  final bool isBlueButton;
  final bool isPriorityRow;
  final Color? color;
  final bool isUppercase;
  final bool isOnboardingButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isBlueButton || isOnboardingButton ? 16 : 12),
        decoration: BoxDecoration(
          color: isBlueButton ? AppColors.blueColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isBlueButton
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(title.toUpperCase(),
                        style: AppTextStyle.upperCaseText
                            .copyWith(color: AppColors.whiteColor))
                  ],
                )
              : isPriorityRow && color != AppColors.whiteColor
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(title.toUpperCase(), style: AppTextStyle.upperCaseText)
                      ],
                    )
                  : Text(isUppercase ? title.toUpperCase() : title,
                      style: AppTextStyle.upperCaseText),
        ),
      ),
    );
  }
}
