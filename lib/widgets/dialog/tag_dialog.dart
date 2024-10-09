
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/data/repository/change_notifier.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';

class TagChooseDialog extends StatefulWidget {
  const TagChooseDialog({super.key, required this.selectedTag});
  final SelectedTag selectedTag;

  @override
  State<TagChooseDialog> createState() => _TagChooseDialogState();
}

class _TagChooseDialogState extends State<TagChooseDialog> {
  List<String> tags = [
    "#family",
    "#job",
    "#professional",
    "#finance",
    "#studies",
    "#entertainment",
    "#holiday",
    "#household"
  ];

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
                  const Text("Choose tag", style: AppTextStyle.header28),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tags.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            widget.selectedTag.select(tags[index]);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: widget.selectedTag.getTag() == tags[index]
                                ? AppColors.blue16Color.withOpacity(0.05)
                                : AppColors.darkBlueColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tags[index], style: AppTextStyle.boldText600),
                              widget.selectedTag.getTag() == tags[index]
                                  ? SvgPicture.asset("assets/icons/checkmark.svg", height: 18, width: 18)
                                  : Container()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
