import 'package:flutter/material.dart';
import 'package:i_will_do_it/data/repository/local_storage.dart';
import 'package:i_will_do_it/ui/home/home_screen.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/widgets/buttons/add_button.dart';
import 'package:i_will_do_it/widgets/buttons/onboarding_select_container.dart';
import 'package:i_will_do_it/widgets/onboarding/onboarding_context.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final storage = SharedPreferenceData.getInstance();
  PageController pageController = PageController();
  int currentIdPage = 0;

  List<Widget> pageList = [
    const OnboardingPageContext(
        title: "Welcome to I will DO IT",
        text: "Schedule your tasks at a time that suits you",
        imageUrl: 'assets/images/onboarding1.png',
        isLeft: true,
    ),
    const OnboardingPageContext(
        title: "How do you plan to use it I will DO IT?:",
        text: 'Choose the appropriate one',
        imageUrl: 'assets/images/onboarding2.png',
        isLeft: false,
    ),
    const OnboardingPageContext(
        title: "Tasks",
        imageUrl: 'assets/images/onboarding3.png',
        isLeft: true,
        isTextAlignLeft: true,
        child:  Padding(
          padding: EdgeInsets.only(top: 25, left: 5, right: 5),
          child: OnboardingSelectContainer(),
        ),
    ),
  ];


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: Center(
        child: PageView.builder(
          controller: pageController,
          itemCount: pageList.length,
          onPageChanged: (int page) {
            setState(() {
              currentIdPage = page;
            });
          },
          itemBuilder: (context, index){
            return Column(
              children: [
                Expanded(
                  child: pageList[index],
                ),
                if(currentIdPage != 2)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),

                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: AddButton(
                    title: "CONTINUE",
                    isOnboardingButton: true,
                    onTap: () async{
                      if (currentIdPage == 2) {
                        await storage.setIsAuth("true");
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder:(context) => const HomeScreen())
                        // );
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 2; i++) {
      list.add(i == currentIdPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 12,
        width: isActive ? 24 : 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isActive ? AppColors.whiteColor : AppColors.lightBlueColor,
        ),
      ),
    );
  }
}
