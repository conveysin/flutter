import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getinforme/Model/SettingModel.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/feature/home/cubit/home_cubit.dart';
import 'package:getinforme/feature/home/home_page_screen.dart';
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
import '../../widgets/app_edit_text.dart';
import '../../widgets/primary_button.dart';
import 'cubit/logout_cubit.dart';


class ContactUs extends AppScreen {
  ContactUs({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends AppScreenState<ContactUs> {
  late LogoutCubit _logoutCubit;
  final TextEditingController _messageController = TextEditingController();
  final DataHelper _dataHelper = DataHelperImpl.instance;
  OtpFieldController otpController = OtpFieldController();
  bool isShowTimer = true;
  String logoURl = '';
  String userID = '';

  String otp = '';

  @override
  Future<void> onInit() async {
    _logoutCubit = BlocProvider.of<LogoutCubit>(context);
    _messageController.addListener(_onOtpChanged);
    _getConfigData();
    _getUserId();
    super.onInit();
  }

  void _onOtpChanged() {
   // _logoutCubit.add(OtpChanged(_messageController.text));
  }

  void _onSubmitPressed(user_id, message) {
 _logoutCubit.contact_us(message, user_id);
  }

  @override
  void dispose() {
    _messageController.dispose();
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
            child: BlocConsumer<LogoutCubit, LogoutState>(
              listener: (context, state) {
                if (state.isContactusSuccess!) {
                  ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                      SnackBar(content: Text('Your Message Successfully Submitted')));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BlocProvider(
                          create: (context) => HomeCubit(),
                          child: HomePage(arguments: null)),
                    ),
                        (route) => false,
                  );
                }
                if (state.isContactusFailure!) {
                  ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                      SnackBar(content: Text('${state.errorMsg}')));
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 30.h - statusBarHeight,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 5,
                                left: 5,
                                child: ( logoURl.isNotEmpty) ?  Container(
                                  height: 25.h,
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
                            height: 65.h,
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
                                    CommonButtons.contact_us,
                                    style: textTheme.headline6?.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        wordSpacing: 0.2,
                                        color: AppColors.letsStartTextColor),
                                  ),
                                  Text(
                                      "Please type your message and submit" ,
                                       //   widget.arguments?.get('mobile'),
                                      style: textTheme.subtitle1?.copyWith(
                                          color: AppColors.letsStartTextColor,
                                          fontSize: 14)),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    height: 7 * 30.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.darkBlue),
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.white
                                    ),
                                    child: TextField(
                                     controller: _messageController,
                                      maxLines: 7,
                                      decoration: InputDecoration(
                                        hintText: "Enter a message",
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),

                                  PrimaryButton(
                                      title: CommonButtons.SUBMIT,
                                      textSize: 14,
                                      isLoading: state.isSubmitting! ? true : false,
                                      onPressed: () {

                                      if(_messageController.text.isNotEmpty) {
                                        var text = _messageController.text;
                                        _onSubmitPressed(userID, text);
                                      }else {
                                         ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                                             SnackBar(content: Text("Please enter your message")));
                                      }  },
                                      backgroundColor: AppColors.buttonColor),
                                  SizedBox(
                                    height: 10,
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

  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(()  {
        userID = value;
        print("UserId>>>>>$userID");
      });
    });
  }
}
