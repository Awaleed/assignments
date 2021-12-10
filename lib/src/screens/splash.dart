import 'dart:math';

import 'package:assignments/src/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../init_injectable.dart';
import '../cubits/splash_cubit/splash_cubit.dart';
import '../routes/config_routes.dart';
import 'onboarding.dart';
import 'task/tasks_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: getIt<SplashCubit>(),
      listener: (context, state) {
        // AppRouter.sailor.navigate(
        //   HomeScreen.routeName,
        //   navigationType: NavigationType.pushAndRemoveUntil,
        //   removeUntilPredicate: (_) => false,
        // );
        // return;
        // await Future.delayed(5.seconds);
        String routeName;
        switch (state) {
          case SplashState.initial:
            break;
          case SplashState.firstLaunch:
            routeName = OnboardingScreen.routeName;
            break;
          case SplashState.authenticated:
            break;
          case SplashState.unauthenticated:
            // routeName = SignInScreen.routeName;
            break;
        }
        routeName = TasksScreen.routeName;

        AppRouter.sailor.navigate(
          routeName,
          navigationType: NavigationType.pushAndRemoveUntil,
          removeUntilPredicate: (_) => false,
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xffDCA11B),
        body: Center(
          child: CustomAnimation<double>(
            control: CustomAnimationControl.MIRROR,
            tween: .5.tweenTo(1.0),
            duration: 500.milliseconds,
            curve: Curves.easeInOut,
            builder: (context, child, value) => Transform.scale(
              scale: sin(value).abs(),
              child: child,
            ),
            child: const FlutterLogo(size: 500),
          ),
        ),
      ),
    );
  }
}
