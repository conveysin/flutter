import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getinforme/Model/SettingModel.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/feature/signup/bloc/signup_bloc.dart';
import 'package:getinforme/widgets/AppLoader.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../core/routes.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../utility/spaces.dart';
import '../../utility/strings.dart';
import '../../widgets/primary_button.dart';
import 'bloc/signup_event.dart';

class EnterOtpScreen extends AppScreen {
  EnterOtpScreen({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _EnterOtpScreenState createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends AppScreenState<EnterOtpScreen> {
  late SignupBloc _signupBloc;
  final TextEditingController _otpController = TextEditingController();
  final DataHelper _dataHelper = DataHelperImpl.instance;
  OtpFieldController otpController = OtpFieldController();
  bool isShowTimer = true;
  String logoURl = '';

  String otp = '';

  @override
  Future<void> onInit() async {
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    _otpController.addListener(_onOtpChanged);
    startTimer();
    _getConfigData();
   if(widget.arguments?.get('isVerify') !=null && widget.arguments?.get('isVerify').toString().toLowerCase()=='0'){
     var userID =
     widget.arguments?.get('userID');
     _onLoginPressed(userID.toString());
   }
   super.onInit();
  }

  void _onOtpChanged() {
    _signupBloc.add(OtpChanged(_otpController.text));
  }

  void _onOtpPressed(user_id, otp) {
    _signupBloc.verifyOtp(user_id, otp);
  }

  void _onLoginPressed(String userId) {
    setState(() {
      print('userId>$userId');
      isShowTimer = true;
    });
    startTimer();

    _signupBloc.resendOtp(userId);
  }

  late Timer timer;
  var num = 59;

  void startTimer() {
    num = 59;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (num == 0) {
          setState(() {
            isShowTimer = false;
          });
          //_otpScreenCubit.ontimeChanged(num);
          timer.cancel();
        } else {
          //_otpScreenCubit.ontimeChanged(num - 1);

          setState(() {
            num = num - 1;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget setView() {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    // TODO: implement setView
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
          child: Container(
        color: AppColors.white,
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.isOTPSuccess!) {
              if(state.verifyOtpData.userType != null){
                if(state.verifyOtpData.userType?.toLowerCase() == '2'){
                  final bundle = Bundle()
                    ..put('mobile', widget.arguments?.get('mobile'));
                  navigateToScreenAndReplace(Screen.HomeNevigation, bundle);
                }else{
                  final bundle = Bundle()
                    ..put('mobile', widget.arguments?.get('mobile'));
                  navigateToScreenAndReplace(Screen.HomeNevigation, bundle);
                }
              }else{
                final bundle = Bundle()
                  ..put('mobile', widget.arguments?.get('mobile'));
                navigateToScreenAndReplace(Screen.HomeNevigation, bundle);
              }
            }
            if (state.isOTPFailure!) {
              ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                  SnackBar(content: Text('${state.errormessage}')));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  height: 40.h - statusBarHeight,
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
                    height: 55.h,
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
                            StringConst.sentence.Enter_OTP,
                            style: textTheme.headline6?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                wordSpacing: 0.2,
                                color: AppColors.letsStartTextColor),
                          ),
                          Text(
                              "The OTP has been sent on +91" +
                                  widget.arguments?.get('mobile'),
                              style: textTheme.subtitle1?.copyWith(
                                  color: AppColors.letsStartTextColor,
                                  fontSize: 14)),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 55,
                            child: OTPTextField(
                                controller: otpController,
                                length: 4,
                                otpFieldStyle: OtpFieldStyle(
                                  backgroundColor: Colors.white,
                                  borderColor: AppColors.focusedbordercolor,
                                  enabledBorderColor:
                                      AppColors.enabledbordercolor,
                                  disabledBorderColor:
                                      AppColors.disablebordercolor,
                                  focusBorderColor:
                                      AppColors.focusedbordercolor,
                                ),
                                width: MediaQuery.of(context).size.width,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.box,
                                fieldWidth: 40,
                                outlineBorderRadius: 8,
                                onChanged: (pin) {
                                  print("Changed: " + pin);
                                  _otpController.text = pin;
                                  otp = pin;
                                  _signupBloc.add(OtpChanged(pin));
                                },
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                  otp = pin;
                                  _otpController.text = pin;
                                  _signupBloc.add(OtpChanged(pin));
                                }),
                          ),

//                           Container(
//                             height: 55,
//                             child:   OtpTextField(
//
//
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               fieldWidth: 45,
//                               numberOfFields: 6,
//                               borderColor: AppColors.outlineColor,
//                               focusedBorderColor: AppColors.outlineColor,
//                               enabledBorderColor: AppColors.outlineColor,
//                               borderWidth: 1,
//                               //  styles: otpTextStyles,
//                               showFieldAsBox: true,
//                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               fillColor: Colors.white,
//                               filled: true,
//                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                               enabled: true,
//                               keyboardType: TextInputType.number,
// styles: [],
// textStyle: textTheme.bodyText1?.copyWith(color: Colors.red),
//                               //runs when a code is typed in
//                               onCodeChanged: (String code) {
//                                 _otpController.text = code;
//                                 _loginBloc.add(OtpChanged(code)) ;
//                                 //handle validation or checks here if necessary
//                               },
//                               //runs when every textfield is filled
//                               onSubmit: (String verificationCode) {
//                                 _otpController.text = verificationCode;
//                               },
//                             ),
//                           ),

                          SpaceH4(),
                          state.isFailure!
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    StringConst.sentence.OTP_Incorrect,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.resendRed),
                                  ),
                                )
                              : new Container(),
                          SizedBox(
                            height: 18,
                          ),

                          PrimaryButton(
                              title: CommonButtons.Confirm,
                              textSize: 14,
                              isLoading: state.isSubmitting! ? true : false,
                              onPressed: () {
                                var userID = widget.arguments?.get('userID');
                                _onOtpPressed(userID.toString(), otp);
                                // ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                                //     SnackBar(content: Text(StringConst.sentence.OTP_Incorrect)));
                              },
                              backgroundColor: AppColors.buttonColor),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 75.w - 30,
                                child: Text(
                                  isShowTimer
                                      ? StringConst.sentence.resend_text
                                      : StringConst
                                          .sentence.Did_not_receive_the_OTP_yet,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.letsStartTextColor),
                                ),
                              ),
                              isShowTimer
                                  ? SizedBox(
                                      width: 20.w,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: Text("00:" + num.toString(),
                                            textAlign: TextAlign.end,
                                            style:
                                                textTheme.subtitle1?.copyWith(
                                              fontSize: 14,
                                              color: AppColors.timercolor,
                                            )),
                                      ))
                                  : SizedBox(
                                      width: 20.w,
                                      child: InkWell(
                                        onTap: () {
                                          print("sasds");
                                          otpController.clear();
                                          var userID =
                                              widget.arguments?.get('userID');
                                          _onLoginPressed(userID.toString());
                                          //_otpController.text='';
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text(CommonButtons.Resend,
                                              textAlign: TextAlign.end,
                                              style:
                                                  textTheme.subtitle1?.copyWith(
                                                color: AppColors.resendRed,
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                              )),
                                        ),
                                      )),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ));
          },
        ),
      )),
    );
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
