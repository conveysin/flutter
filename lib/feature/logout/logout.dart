




import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/feature/forgotPassword_screen/changePassword.dart';

import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../core/routes.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../widgets/AppLoader.dart';
import '../login_screen/bloc/login_bloc.dart';
import '../login_screen/letsStart_screen.dart';
import 'cubit/logout_cubit.dart';

class LogoutPage extends AppScreen {
  LogoutPage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends AppScreenState<LogoutPage> {
  late LogoutCubit _cubit;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool isEditor = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cubit = BlocProvider.of<LogoutCubit>(context);
    _getEditorStatus();
  }

  @override
  Widget setView() {
    return BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          // if (!state.isHomedataLoading)
          return SafeArea(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.letsStartBackground,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Text('Menu', style: textTheme.headline6,),
                        SizedBox(height: 20,),
                        new Container (
                            decoration: new BoxDecoration (
                                color: Colors.white
                            ),
                            child: ListTile(
                              onTap: () {
navigateToScreen(Screen.Contactus);
                              },
                              leading: Text('Contact us', style: textTheme
                                  .headline6,),
                              trailing: Icon(Icons.arrow_forward_ios_rounded,
                                  color: AppColors.black),
                            )
                        ),
                        // SizedBox(height: 20,),
                        // new Container (
                        //     decoration: new BoxDecoration (
                        //         color: Colors.white
                        //     ),
                        //     child: ListTile(
                        //       onTap: () {
                        //         onLogout();
                        //       },
                        //       leading: Text('Logout', style: textTheme
                        //           .headline6,),
                        //       trailing: Icon(Icons.arrow_forward_ios_rounded,
                        //         color: AppColors.black,),
                        //     )
                        // ),
                        // SizedBox(height: 20,),
                        // Container (
                        //     decoration: new BoxDecoration (
                        //         color: Colors.white
                        //     ),
                        //     child: ListTile(
                        //       onTap: () {
                        //         navigateToScreen(Screen.ChangePassword);
                        //       },
                        //       leading: Text('Change Password', style: textTheme
                        //           .headline6,),
                        //       trailing: Icon(Icons.arrow_forward_ios_rounded,
                        //         color: AppColors.black,),
                        //     )
                        // ),
                        SizedBox(height: 20,),
                        ( isEditor == true) ?   new Container (
                            decoration: new BoxDecoration (
                                color: Colors.white
                            ),
                            child: ListTile(
                              onTap: () {
                                navigateToScreen(Screen.PilotPostpage);
                              },
                              leading: Text('Post', style: textTheme
                                  .headline6,),
                              trailing: Icon(Icons.arrow_forward_ios_rounded,
                                color: AppColors.black,),
                            )
                        ) : new Container(),
                      ],
                    ),
                  ),
                ),
              ));

          return AppLoader(
            isLoading: true,
          );
        });
  }

  Widget slider(List<String> slider) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10),
      child: Container(
        height: 10.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: slider.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                    left: 16, right: index == slider.length - 1 ? 16.0 : 0.0),
                //322
                height: 10.h,
                width: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                        slider[index],
                      ),
                      fit: BoxFit.fill,
                    )),
              );
            }),
      ),
    );
  }

  onLogout() {
    _dataHelper.cacheHelper.setLogin('0');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: LoginScreen(arguments: null)),
      ),
          (route) => false,
    );
  }

  _getEditorStatus() async {
    _dataHelper.cacheHelper.getEditor().then((value) {
      setState(() {
        value != null ? isEditor = value : isEditor = false;
        print("isEditorvalue>>>>>$value");
        print("isEditor>>>>>$isEditor");
      });
    });
  }

}
