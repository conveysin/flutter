import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/core/app_screen.dart';
import 'package:getinforme/core/bundle.dart';
import 'package:getinforme/utility/colors.dart';
import 'package:getinforme/utility/images.dart';
import 'package:getinforme/widgets/primary_button.dart';


import '../../Thems/color_palette.dart';
import '../../core/routes.dart';
import '../../data/data_helper.dart';
import '../../utility/strings.dart';
import '../../widgets/AppLoader.dart';
import '../../widgets/app_edit_text.dart';
import '../Onbording/enter_otp.dart';
import 'bloc/forgotPassword_bloc.dart';
import 'bloc/forgotPassword_event.dart';

class ChangePassword extends AppScreen {
  ChangePassword({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends AppScreenState<ChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
  TextEditingController();
  late ForgotPasswordBloc _ChangePasswordBloc;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String userID = '';
  @override
  void onInit() {
    _ChangePasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    _oldPasswordController.addListener(_oldPasswordChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmpasswordController.addListener(_oConfirmPasswordChanged);

    super.onInit();
  }

  void _oldPasswordChanged() {
    _ChangePasswordBloc.add(NameChanged(_passwordController.text));
  }

  void _onPasswordChanged() {
    _ChangePasswordBloc.add(PasswordChanged(_passwordController.text));
  }

  void _oConfirmPasswordChanged() {
    _ChangePasswordBloc.add(ConfirmPasswordChanged(_confirmpasswordController.text));
  }

  @override
  void initState() {
    _getConfigData();
    super.initState();

  }

  @override
  void dispose() {
    _confirmpasswordController.dispose();
    _passwordController.dispose();
    _oldPasswordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    _ChangePasswordBloc.ChangePassword(userID,_oldPasswordController.text, _passwordController.text, _confirmpasswordController.text);
  }

  @override
  Widget setView() {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: BlocConsumer<ForgotPasswordBloc, ForgotPassword_State>(
          listener: (context, state) {
            if (state.isSuccess!) {
              navigateToScreenAndReplace(Screen.Login);
              ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                  SnackBar(content: Text('${state.errorMessage}')));

             // navigateToScreenAndReplace(Screen.Home, bundle);
             // navigateToScreenAndReplace(Screen.HomeNevigation);
            }
            if (state.isFailure!) {
              if(state.errorMessage != null)
              ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                  SnackBar(content: Text('${state.errorMessage}')));
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Change Password',style: textTheme.subtitle1,),
              ),
              body: Container(
                color: AppColors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 100.h,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColors.letsStartBackground,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),

                                Text(
                                  "Please enter your old and new password.",
                                  style: textTheme.headline6?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                       wordSpacing: 0.2,
                                      color: AppColors.letsStartTextColor),
                                ),


                                SizedBox(
                                  height: 29,
                                ),

                                UsernameEditText(
                                  _oldPasswordController,
                                  usernameType: UsernameType.passwoord,
                                  isValid: true,
                                  hinttext: StringConst.sentence.Old_Password,
                                  keyboardtype: TextInputType.visiblePassword,
                                  onChange: () {},
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                UsernameEditText(
                                  _passwordController,
                                  isValid: state.isPassword,
                                  usernameType: UsernameType.passwoord,
                                  hinttext: StringConst.sentence.Password,
                                  keyboardtype: TextInputType.visiblePassword,
                                  onChange: () {},
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                UsernameEditText(
                                  _confirmpasswordController,
                                  isValid: state.isPassword,
                                  usernameType: UsernameType.passwoord,
                                  hinttext: StringConst.sentence.ConfirmPassword,
                                  keyboardtype: TextInputType.visiblePassword,
                                  onChange: () {},
                                ),
                                SizedBox(
                                  height: 80,
                                ),

                                PrimaryButton(
                                    title: CommonButtons.SUBMIT,
                                    isLoading:  state.isSubmitting!?true:false,
                                    textSize: 14,
                                    onPressed: () {
                                      (_oldPasswordController.text.isNotEmpty && _passwordController.text.isNotEmpty && _confirmpasswordController.text.isNotEmpty )?
                                      _onLoginPressed():
                                      ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                                          SnackBar(content: Text('Please enter valid mobile number')));
                                    }, backgroundColor: Colors.blue),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyPhoneNumberScreen(phoneNumber: '9981271241',)));
  }


  _getConfigData() async {
    var id='';
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      id = value;
      setState(()  {
        userID = id.toString().trim();
      });
    });

  }
}
