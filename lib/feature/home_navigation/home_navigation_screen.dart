import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getinforme/feature/logout/cubit/logout_cubit.dart';
import 'package:getinforme/feature/post/cubit/post_cubit.dart';
import 'package:getinforme/feature/post/post_page.dart';
import 'package:getinforme/feature/profile/cubit/profile_cubit.dart';
import 'package:getinforme/feature/profile/profile_page_screen.dart';

import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/sizes.dart';
import '../../utility/strings.dart';

import '../home/cubit/home_cubit.dart';
import '../home/home_page_screen.dart';
import '../login_screen/bloc/login_bloc.dart';
import '../login_screen/letsStart_screen.dart';
import '../logout/logout.dart';
import 'cubit/homenavigation_cubit.dart';

class NewHomeNavigationScreen extends AppScreen {
  NewHomeNavigationScreen(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);

  @override
  _HomeNavigationScreenState createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState
    extends AppScreenState<NewHomeNavigationScreen> {
  late List<BottomNavigationBarItem> _navBarItems;
  late List<Widget> _bodyWidgets;
  late NewHomeNavigationCubit _cubit;
  late HomeCubit _homeCubit;
  late LogoutCubit _logoutCubit;
  late ProfileCubit _profileCubit;
  final DataHelper _dataHelper = DataHelperImpl.instance;

  int current_index = 0;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onInit() {
    _cubit = BlocProvider.of<NewHomeNavigationCubit>(context);
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _logoutCubit = BlocProvider.of<LogoutCubit>(context);
    /*_selectCategoryCubit = BlocProvider.of<SelectCategoryCubit>(context);

    _transactionCubit = BlocProvider.of<TransactionListCubit>(context);
    _helpCubit = BlocProvider.of<HelpCubit>(context);*/
    _navBarItems = [
      BottomNavigationBarItem(
        label: StringConst.HOME,
        icon: _getBottomBarIcons('assets/icons/home.svg', false),
        activeIcon: _getBottomBarIcons('assets/icons/home.svg', true),
      ),
      BottomNavigationBarItem(
        label: StringConst.PROFILE_SCREEN,
        icon: _getBottomBarIcons('assets/icons/profile.svg', false),
        activeIcon: _getBottomBarIcons('assets/icons/profile.svg', true),
      ),
      BottomNavigationBarItem(
        label: StringConst.label.menu,
        icon: _getBottomBarIcons('assets/icons/settings.svg', false),
        activeIcon: _getBottomBarIcons('assets/icons/settings.svg', true),
      ),
    ];
    _bodyWidgets = [
      BlocProvider.value(
        value: _homeCubit,
        child: HomePage(),
      ),
      BlocProvider.value(
        value: _profileCubit,
        child: ProfilePage(),
      ),
      BlocProvider.value(
        value: _logoutCubit,
        child: LogoutPage(),
      ),
    ];

    super.onInit();
  }

  Widget _getBottomBarIcons(String asset, bool isActive) {
    return SvgPicture.asset(
      asset,
      height: 24,
      width: 24,
      color: isActive ? Colors.black : AppColors.grey,
    );
  }

  @override
  Widget? bottomNavigator() {
    final TextStyle unselectedLabelStyle = TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'sailec');

    final TextStyle selectedLabelStyle = TextStyle(
        color: AppColors.secondaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'sailec');
    return BlocBuilder<NewHomeNavigationCubit, HomeNavigationState>(
      builder: (context, state) {
        if (state is HomeNavigationIndexState)
          return SizedBox(
              height: 50,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 0,
                          blurRadius: 10),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      child: BottomNavigationBar(
                        items: _navBarItems,
                        onTap:   _cubit.switchBottomNavIndex,
                        currentIndex: state.index,
                        elevation: 6,
                        backgroundColor: Colors.white,
                        unselectedItemColor: Colors.black.withOpacity(0.5),
                        selectedItemColor: Colors.black,
                        unselectedLabelStyle: unselectedLabelStyle,
                        selectedLabelStyle: selectedLabelStyle,
                        type: BottomNavigationBarType.fixed,
                        showUnselectedLabels: true,
                      ))));
        else
          throw UnimplementedError();
      },
    );
  }

  @override
  Widget setView() {
    final TextStyle unselectedLabelStyle = TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'sailec');

    final TextStyle selectedLabelStyle = TextStyle(
        color: AppColors.secondaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'sailec');

    return BlocConsumer<NewHomeNavigationCubit, HomeNavigationState>(
      listener: (context, state) {
        print('onSessionExpired() Cleaning session  HomeNavigationState  ');
      },
      builder: (context, state) {
        if (state is HomeNavigationIndexState) {
          return /*CustomScaffold(
            scaffold: Scaffold(
              extendBody: true,
              bottomNavigationBar: BottomNavigationBar(
                items: _navBarItems,
                onTap: _cubit.switchBottomNavIndex,
                currentIndex: state.index,
                elevation: 6,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.black.withOpacity(0.5),
                selectedItemColor: Colors.black,
                unselectedLabelStyle: unselectedLabelStyle,
                selectedLabelStyle: selectedLabelStyle,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
              ),
            ),

            // Children are the pages that will be shown by every click
            // They should placed in order such as
            // `page 0` will be presented when `item 0` in the [BottomNavigationBar] clicked.
            children: _bodyWidgets,

            // Called when one of the [items] is tapped.
            onItemTap: (index) {
              print('>>>>>>>>>>>>>>' + index.toString());

              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) =>  BlocProvider(
              //         create: (context) => LoginBloc(),
              //         child: LoginScreen(
              //             arguments: null)),
              //   ),
              //       (route) => false,
              // );
            },
          );*/

              PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 800),
                  transitionBuilder: (child, animation, secondaryAnimation) {
                    return FadeThroughTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child,
                    );
                  },
                  child: _bodyWidgets[state.index]);
        } else
          throw UnimplementedError();
      },
    );
  }
}
