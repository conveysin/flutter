import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/core/app_screen.dart';
import 'package:getinforme/core/bundle.dart';
import 'package:getinforme/feature/login_screen/bloc/login_event.dart';
import 'package:getinforme/utility/colors.dart';
import 'package:getinforme/utility/images.dart';
import 'package:getinforme/widgets/primary_button.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../Thems/color_palette.dart';
import '../../core/routes.dart';
import '../../data/data_helper.dart';
import '../../utility/strings.dart';
import '../../widgets/AppLoader.dart';
import '../../widgets/app_edit_text.dart';
import '../Onbording/enter_otp.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginScreen extends AppScreen {
  LoginScreen({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _LetsStartScreenState createState() => _LetsStartScreenState();
}

class _LetsStartScreenState extends AppScreenState<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  late LoginBloc _loginBloc;
  String device_id='';
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String logoURl = '';
  String token = '';
  String mobile = '';

  @override
  void onInit() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _mobileController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    //_getId() ;
    _getConfigData();
    _getToken();
/*
    if(widget.arguments?.get('mobile')!=null){
      _mobileController.text = widget.arguments?.get('mobile');
    }else{
      _mobileController.text = '';
    }*/

    super.onInit();
  }

  void _onEmailChanged() {
    _loginBloc.add(MobileChanged(_mobileController.text));

  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(_passwordController.text));
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    print("token>>"+token);
    _loginBloc.add(
      LoginWithCredentialsClicked(widget.arguments?.get('mobile'),_passwordController.text,token),
    );
  }

  @override
  Widget setView() {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess!) {
              if (state.loginData!.is_verify?.toLowerCase() == "1") {
                if(state.loginData!.userType?.toLowerCase() == '1'){
                  final bundle = Bundle()
                    ..put('mobile', _mobileController.text);
                  navigateToScreenAndReplace(Screen.HomeNevigation, bundle);
                }else {
                  final bundle = Bundle()
                    ..put('mobile', _mobileController.text);
                  navigateToScreenAndReplace(Screen.HomeNevigation, bundle);
                }
              }else{
                final bundle = Bundle()
                  ..put('mobile', _mobileController.text)
                  ..put('userID', state.loginData?.user_id)
                  ..put('isVerify',state.loginData!.is_verify);
                  navigateToScreenAndReplace(Screen.OTP, bundle);
              }
            }
            if (state.isFailure!) {
              if(state.errorMessage != null)
              ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                  SnackBar(content: Text('${state.errorMessage}')));
            }
          },
          builder: (context, state) {
            return Container(
              color: AppColors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 40.h-statusBarHeight,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 5,
                            left: 5,
                            child: ( logoURl.isNotEmpty) ?  Container(
                              height: 30.h,
                              color: Colors.white,
                              child: Center(child: logoURl.isNotEmpty ? CachedNetworkImage(
                                imageUrl: logoURl,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter:
                                        ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                                  ),
                                ),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                // errorWidget: (context, url, error) => Icon(Icons.error),
                              ): AppLoader(),
                              ),
                            ) : new Container( height: 30.h,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 60.h,
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
                              Text(
                                CommonButtons.LOGIN,
                                style: textTheme.headline6?.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                     wordSpacing: 0.2,
                                    color: AppColors.letsStartTextColor),
                              ),

                              Text(
                              "Sent to +91 ${widget.arguments?.get('mobile')}",
                                style: textTheme.subtitle1?.copyWith(
                                  fontSize: 14,
                                    color: AppColors.letsStartTextColor),
                              ),


                              SizedBox(
                                height: 5,
                              ),
                              OTPTextField(
                                controller: otpController,
                                length: 4,
                                // isValid: state.isPassword,
                                width: MediaQuery.of(context).size.width,
                                fieldWidth: 60,
                                style: TextStyle(
                                  fontSize: 15
                                ),
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onCompleted: (pin) {
                                  // print("Completed: " + pin);
                                  _passwordController.text = pin;
                                },
                              ),
                              SizedBox(
                                height: 25,
                              ),

                              PrimaryButton(
                                  title: CommonButtons.SUBMIT,
                                  isLoading:  state.isSubmitting!?true:false,
                                  textSize: 14,
                                  onPressed: () {
                                    (state.isPassword)?
                                    _onLoginPressed():
                                    ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                                        // SnackBar(content: Text('Please enter valid mobile number and password')));
                                        SnackBar(content: Text('Please enter the correct OTP sent to your mobile')));
                                  }, backgroundColor: Colors.blue),

                              SizedBox(
                                height: 10,
                              ),

                              SizedBox(
                                  width:100.w,
                                  child: InkWell(
                                    onTap: () {
                                      navigateToScreen(Screen.ForgetPassword);
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30.0),
                                        child: Text(CommonButtons.Forget_password,
                                            textAlign: TextAlign.end,
                                            style:
                                            textTheme.subtitle1?.copyWith(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              decoration:
                                              TextDecoration.underline,
                                            )),
                                      ),
                                    ),
                              )),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      device_id = androidDeviceInfo.androidId!;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  _getConfigData() async {
    var logo='';
    _dataHelper.cacheHelper.getLogo().then((value) {
      logo = value;
      setState(()  {
        logoURl = logo.toString().trim();
      });
    });

  }

  _getToken() async {
    String firebaseToken='';
    _dataHelper.cacheHelper.getAccessToken().then((value) {
      firebaseToken = value;
      setState(()  {
        token = firebaseToken;
        print("Token>Login>"+token);
      });
    });

  }

}