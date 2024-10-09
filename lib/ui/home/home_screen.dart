import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_will_do_it/bloc/calendar_task_list/calendar_task_list_bloc.dart';
import 'package:i_will_do_it/bloc/calendar_task_list/full_task_list/full_task_list_cubit.dart';
import 'package:i_will_do_it/bloc/search_task_list/search_task_list_cubit.dart';
import 'package:i_will_do_it/bloc/today_task_list/today_task_list_cubit.dart';
import 'package:i_will_do_it/data/repository/change_notifier.dart';
import 'package:i_will_do_it/ui/home/screens/home_planned_screen.dart';
import 'package:i_will_do_it/ui/home/screens/home_search_screen.dart';
import 'package:i_will_do_it/ui/home/screens/home_today_screen.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:i_will_do_it/utils/style.dart';
import 'package:time_listener/time_listener.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SelectedDate selectedDate = SelectedDate();
  int _selectedIndex = 0;
  late PageController _pageController;
  late final AppLifecycleListener lifecycleListener;
  Timer? forceDetachTimer;
  late TimeListener listener;
  bool isReload = false;

  late final List<Widget> pages;

  @override
  void initState() {
    pages = [
      HomeTodayScreen(selectedDate: selectedDate),
      HomePlannedScreen(selectedDate: selectedDate),
      const HomeSearchScreen()
    ];
    _pageController = PageController(initialPage: _selectedIndex);
    lifecycleListener = AppLifecycleListener(onStateChange: onAppStateChanged);
    listener = TimeListener()..listen((DateTime dt) {

      if(dt.hour == 0){
        context.read<TodayTaskListCubit>().check();

        if(selectedDate.date != null){
          selectedDate.select(DateTime.now());
          context.read<FullTaskListCubit>().check();
        }

        context.read<SearchTaskListCubit>().check();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: pages,
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            top: BorderSide(
              color: AppColors.blueColor,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
              _pageController.jumpToPage(_selectedIndex);
            });
          },
          selectedItemColor: AppColors.blueColor,
          unselectedItemColor: AppColors.lightGreyColor,
          showSelectedLabels: true,
          backgroundColor: Colors.transparent,
          showUnselectedLabels: false,
          elevation: 0,
          selectedLabelStyle: AppTextStyle.thinText12.copyWith(color: AppColors.blueColor),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/home.svg",
                height: 24,
                width: 24,
              ),
              label: 'Today',
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset("assets/icons/home.svg",
                  color: AppColors.blueColor,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/calendar.svg",
                height: 20,
                width: 20,
              ),
              label: 'Planned',
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset("assets/icons/calendar.svg",
                  color: AppColors.blueColor,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/search.svg",
                height: 24,
                width: 24,
              ),
              label: 'Search',
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset("assets/icons/search.svg",
                  color: AppColors.blueColor,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void onAppStateChanged(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      forceDetachTimer = Timer(const Duration(minutes: 3), forceDetachApp);
    }
    else {
      forceDetachTimer?.cancel();
      forceDetachTimer = null;
    }
  }


  void forceDetachApp() async{
    forceDetachTimer = null;
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    if(Platform.isIOS){
      exit(0);
    }
  }
}
