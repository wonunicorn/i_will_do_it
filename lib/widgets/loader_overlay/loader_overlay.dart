
import 'package:flutter/material.dart';
import 'package:i_will_do_it/utils/colors.dart';

class LoaderOverlayWidget extends StatelessWidget {
  const LoaderOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 34,
        height: 34,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          color: AppColors.blueColor,
        ) ,
      ),
    );
  }
}