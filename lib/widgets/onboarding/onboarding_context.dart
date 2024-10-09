
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';


class OnboardingPageContext extends StatelessWidget {
  const OnboardingPageContext({
    Key? key,
    required this.title,
    this.text,
    this.child,
    required this.imageUrl,
    required this.isLeft,
    this.isTextAlignLeft = false
  }) : super(key: key);

  final String title;
  final String? text;
  final String imageUrl;
  final Widget? child;
  final bool isLeft;
  final bool isTextAlignLeft;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      isLeft ?
        Transform.scale(
          scaleX: -1,
          child: SvgPicture.asset("assets/icons/rectangle.svg"))
          : Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset("assets/icons/rectangle.svg")
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  imageUrl,
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.only(left: isTextAlignLeft ? 5 : 0),
                child: Align(
                  alignment: isTextAlignLeft ? Alignment.centerLeft : Alignment.center,
                    child: Text(
                        title, style: AppTextStyle.header34, textAlign: TextAlign.center )),
              ),
              const SizedBox(height: 15),
              if(text != null )
                Text(text!, style: AppTextStyle.text17, textAlign: TextAlign.center),
              child ?? Container(),
            ],
          ),
        ),
      ],
    );
  }
}
