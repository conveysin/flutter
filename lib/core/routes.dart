import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getinforme/Model/Home.dart';
import 'package:getinforme/feature/forgotPassword_screen/bloc/forgotPassword_bloc.dart';
import 'package:getinforme/feature/forgotPassword_screen/forgotPassword.dart';

import 'package:getinforme/feature/login_screen/bloc/login_bloc.dart';
import 'package:getinforme/feature/logout/Contact_us.dart';
import 'package:getinforme/feature/pilot/bloc/pilot_bloc.dart';
import 'package:getinforme/feature/post/cubit/post_cubit.dart';
import 'package:getinforme/feature/post/post_details_page.dart';
import 'package:getinforme/feature/post/post_page.dart';
import 'package:getinforme/feature/signup/enterOtp_screen.dart';
import 'package:getinforme/feature/login_screen/myloginpage.dart';
import 'package:getinforme/feature/logout/cubit/logout_cubit.dart';
import 'package:getinforme/feature/signup/bloc/signup_bloc.dart';
import 'package:getinforme/feature/signup/signup.dart';

import '../feature/forgotPassword_screen/changePassword.dart';
import '../feature/home/cubit/home_cubit.dart';
import '../feature/home/home_page_screen.dart';
import '../feature/home_navigation/cubit/homenavigation_cubit.dart';
import '../feature/home_navigation/home_navigation_screen.dart';
import '../feature/login_screen/letsStart_screen.dart';

import '../feature/pilot/pilot_post_page.dart';
import '../feature/profile/cubit/profile_cubit.dart';
import '../feature/splash_screen/cubit/splash_cubit.dart';
import '../feature/splash_screen/splash_screen_view.dart';

import 'bundle.dart';

enum Screen {
  splash,
  Login,
  OTP,
  Signup,
  Home,
  HomeNevigation,
  ForgetPassword,
  PostPage,
  Contactus,
  PostDetails,
  PilotPostpage,
  ChangePassword


  // PhoneAuthForm
  /* selectLanguage,
  HomeNevigation,
  SelectCategory,
  InAppWebViewScreen,
  PolicyDetails,
  PaymentSuccessPage,
  PersonalDetailsPage,
  addnominee,

  NotificationListPage,
  TransactionListPage,
  HelpPage,
  PolicyBenefits,
  CreateGoal*/
}

class Router {
  final homeCubit = HomeCubit();
  final profileCubit = ProfileCubit();
  final logoutCubit = LogoutCubit();
  final postCubit = PostCubit();

  Route<dynamic> generateRoute(RouteSettings settings) {
    var screen = Screen.values.firstWhere((e) => e.toString() == settings.name);
    switch (screen) {
      case Screen.splash:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => SplashCubit(),
                child: SplashScreen(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));

      case Screen.Login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => LoginBloc(),
                child: LoginScreen(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));

      case Screen.Signup:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => SignupBloc(),
                child: SignupScreen(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));
      case Screen.Home:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => HomeCubit(),
                child: HomePage(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));

      case Screen.OTP:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => SignupBloc(),
                child: EnterOtpScreen(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));
      case Screen.HomeNevigation:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: homeCubit,
                    ),
                    BlocProvider.value(
                      value: profileCubit,
                    ),
                    BlocProvider.value(
                      value: logoutCubit,
                    ),
                    /* BlocProvider.value(
                  value: selectCategoryCubit,
                ),
                BlocProvider.value(
                  value: profileCubit,
                ),
                BlocProvider.value(
                  value: transactionListCubit,
                ),
                BlocProvider.value(
                  value: helpCubit,
                ),*/
                    BlocProvider(create: (context) => NewHomeNavigationCubit())
                  ],
                  child: NewHomeNavigationScreen(
                      arguments: settings.arguments != null
                          ? settings.arguments as Bundle
                          : null),
                ));
      case Screen.ForgetPassword:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => ForgotPasswordBloc(),
                child: ForgotPassword(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));
      case Screen.PostPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => PostCubit(),
                child: PostPage(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));

      case Screen.Contactus:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => LogoutCubit(),
                child: ContactUs(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));
      case Screen.PostDetails:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => PostCubit(),
                child: PostDetailPage(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));

        case Screen.PilotPostpage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => PilotBloc(),
                child: PilotPostpage(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));

      case Screen.ChangePassword:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => ForgotPasswordBloc(),
                child: ChangePassword(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null)));


/*

      case Screen.PhoneAuthForm:
        return MaterialPageRoute(
            builder: (_) =>  PhoneAuthForm(
                    arguments: settings.arguments != null
                        ? settings.arguments as Bundle
                        : null));

*/

    }
  }
}
