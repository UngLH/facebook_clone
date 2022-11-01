import 'dart:async';

import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/splash/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  late SplashCubit _cubit;
  late StreamSubscription _navigationSubscription;

  @override
  void initState() {
    final authRepository = RepositoryProvider.of<AuthRepository>(context);
    _cubit = SplashCubit(
      authBagriRepository: authRepository,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _setup();
    });
    super.initState();
    _navigationSubscription = _cubit.navigatorController.stream.listen((event) {
      Future.delayed(const Duration(seconds: 2), () {
        switch (event) {
          case SplashNavigator.OPEN_LOGIN:
            showLogin();
            break;
          case SplashNavigator.OPEN_HOME:
            print("open Home");
            break;
        }
      });
    });
  }
  @override
  void dispose() {
    _navigationSubscription.cancel();
    _cubit.close();
    super.dispose();
  }

  _setup() async {
    _cubit.fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.icRoundFacebookLogo, width: 80, height: 80,),
                     const SizedBox(height: 20,),
                     const SizedBox(
                       width: 100,
                       height: 20,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
                        colors: [AppColors.main],/// Optional, The color collections
                        strokeWidth: 4, // Optional, The stroke of the line, only applicable to widget which contains line
                        backgroundColor: Colors.white,      /// Optional, Background of the widget
                        pathBackgroundColor: Colors.black,/// Optional, the stroke backgroundColor
                  ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children:  [
                    const Text("from", style: TextStyle(color: Colors.grey, fontSize: 16),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.icMeta, width: 30,),
                        const SizedBox(width: 10,),
                        const Text("Meta", style: TextStyle(color: AppColors.main, fontSize: 20, fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
      )
    );
  }

  void showLogin() {
    Application.router?.navigateTo(context, Routes.login, replace: true);
  }

}
