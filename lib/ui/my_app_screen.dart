
import 'package:flutter/material.dart';
import 'package:i_will_do_it/data/repository/local_storage.dart';
import 'package:i_will_do_it/ui/home/home_screen.dart';
import 'package:i_will_do_it/ui/onboarding/onboarding_screen.dart';
import 'package:i_will_do_it/widgets/loader_overlay/loader_overlay.dart';

class MyAppScreen extends StatefulWidget {
  const MyAppScreen({super.key});

  @override
  State<MyAppScreen> createState() => _MyAppScreenState();
}

class _MyAppScreenState extends State<MyAppScreen> {
  final storage = SharedPreferenceData.getInstance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storage.getIsAuth(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data == "true"){
              return const HomeScreen();
            } else {
              return const OnboardingScreen();
            }
          } else{
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: const LoaderOverlayWidget(),
            );
          }
        }
    );
  }
}
