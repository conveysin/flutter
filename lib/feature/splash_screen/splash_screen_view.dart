import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getinforme/core/app_screen.dart';
import 'package:getinforme/core/bundle.dart';
import 'package:getinforme/data/data_helper.dart';
import 'package:getinforme/feature/login_screen/myloginpage.dart';
import 'package:getinforme/widgets/AppLoader.dart';

import '../../core/routes.dart';
import '../Onbording/IntroScreenBody.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends AppScreen {
  SplashScreen({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends AppScreenState<SplashScreen>
    with TickerProviderStateMixin {
  late SplashCubit _splashCubit;
  late final AnimationController _controller;
  late final Duration _splashEndDuration;
  bool isSkip = false;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String result = '', userType = '';
  String userID = '0';


  @override
  Future<void> onInit() async {
    _controller = AnimationController(vsync: this);
    _splashCubit = BlocProvider.of<SplashCubit>(context);

    result = await _dataHelper.cacheHelper.isLogin();
    userType = await _dataHelper.cacheHelper.isUserType();
    _getUserId();

    await FirebaseAuth.instance.signOut();
    super.onInit();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserId();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget setView() {
    return BlocConsumer<SplashCubit, SplashState>(listener: (context, state) {
      if (state.isSuccess!) {}
      if (state.isFailure!) {
        if (state.errormessage != null)
          ScaffoldMessenger.of(globalKey.currentContext!)
              .showSnackBar(SnackBar(content: Text('${state.errormessage}')));
      }

      Future.delayed(const Duration(seconds: 5), () {
        if (!isSkip) {
          if (result == "1") {
            if (userType.toLowerCase() == '2') {
              navigateToScreen(Screen.HomeNevigation);
            } else {
              navigateToScreen(Screen.HomeNevigation);
            }
          } else {
            navigateToScreen(Screen.Login);
          }
        }
      });
    }, builder: (context, state) {
      if (!state.isLoading!)
        return SafeArea(
          child: Container(
            color: Colors.white,
            child: IntroScreenBody(
              onGetstart: () {
                setState(() {
                  isSkip = true;
                  if (result == "1") {
                    if (userType.toLowerCase() == '2') {
                      navigateToScreen(Screen.HomeNevigation);
                    } else {
                      navigateToScreen(Screen.HomeNevigation);
                    }
                  } else {
                    navigateToScreen(Screen.Login);
                  }
                });
              },
              settingData: state.settingData != null ? state.settingData : [],
            ),
          ),
        );
      return AppLoader(
        isLoading: true,
      );
      ;
    });
  }
  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(() {
        userID = value;
        print("UserId>>>>>$userID");
        _splashCubit.fetchSetting(userID);
      });
    });
  }
}

