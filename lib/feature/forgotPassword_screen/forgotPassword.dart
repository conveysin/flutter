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
import '../login_screen/letsStart_screen.dart';
import 'bloc/forgotPassword_bloc.dart';
import 'bloc/forgotPassword_event.dart';

class ForgotPassword extends AppScreen {
  ForgotPassword({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends AppScreenState<ForgotPassword> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late ForgotPasswordBloc _forgotPasswordBloc;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String logoURl = '';
  @override
  void onInit() {
    _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    _mobileController.addListener(_onEmailChanged);
    super.onInit();
  }

  void _onEmailChanged() {
    _forgotPasswordBloc.add(MobileChanged(_mobileController.text));
  }

  @override
  void initState() {
    _getConfigData();
    super.initState();

  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    _forgotPasswordBloc.add(
      ForgotPasswordClicked(_mobileController.text),
    );
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
              final bundle = Bundle()..put('mobile', _mobileController.text);
              navigateToScreenAndReplace(Screen.Login, bundle);
            }
            if (state.isFailure!) {
              if(state.errorMessage != null)
              ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                  SnackBar(content: Text('${state.errorMessage}')));
              final bundle = Bundle()..put('mobile', _mobileController.text);
              navigateToScreenAndReplace(Screen.Signup, bundle);
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
                                "",
                                style: textTheme.headline6?.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                     wordSpacing: 0.2,
                                    color: AppColors.letsStartTextColor),
                              ),

                              
                              // SizedBox(
                              //   height: 20,
                              // ),

                              UsernameEditText(
                                _mobileController,
                                isValid:  state.isMobile,
                                usernameType: UsernameType.mobile,
                                hinttext: StringConst.sentence.Enter_Mobile_Number,
                                keyboardtype: TextInputType.number,
                                onChange: (){},
                              ),
                              SizedBox(
                                height: 25,
                              ),

                              PrimaryButton(
                                  title: CommonButtons.SUBMIT,
                                  isLoading:  state.isSubmitting!?true:false,
                                  textSize: 14,
                                  onPressed: () {
                                    (state.isMobile )?
                                    _onLoginPressed():
                                    ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                                        SnackBar(content: Text('Please enter valid mobile number')));

                                    Bundle bundle = new Bundle()
                                      ..put('MobileNumber', _mobileController.text);
                                    Navigator.pushNamed(
                                      context,
                                      Screen.PostPage.toString(),
                                      arguments: bundle,
                                    );
                                  }, backgroundColor: Colors.blue),
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
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyPhoneNumberScreen(phoneNumber: _mobileController.text,)));
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
}
