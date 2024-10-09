import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_will_do_it/domain/interactor/bloc_provider.dart';
import 'package:i_will_do_it/ui/my_app_screen.dart';
import 'package:i_will_do_it/utils/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // @override
  // void initState() {
  //   check();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.6),
      useDefaultLoading: false,
      overlayWidgetBuilder: (v) {
        return const Center(
          child: SizedBox(
            width: 34,
            height: 34,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: AppColors.whiteColor,
            ) ,
          ),
        );
      },
      child: MultiBlocProvider(
        providers: BlocsProvider().providers(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'I will DO IT',
          home: MyAppScreen(),
        ),
      ),
    );
  }


}

