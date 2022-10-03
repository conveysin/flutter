import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getinforme/Model/DistrictModel.dart';
import 'package:getinforme/Model/MandalModel.dart';
import 'package:getinforme/Model/VillageModel.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/core/app_screen.dart';
import 'package:getinforme/core/bundle.dart';
import 'package:getinforme/core/routes.dart';
import 'package:getinforme/feature/signup/bloc/signup_bloc.dart';
import 'package:getinforme/feature/signup/bloc/signup_event.dart';

import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/strings.dart';
import '../../widgets/app_edit_text.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends AppScreen {
  SignupScreen({RouteObserver<Route>? routeObserver, key, Bundle? arguments})
      : super(routeObserver, key, arguments);

  @override
  _SignupScreeState createState() => _SignupScreeState();
}

class _SignupScreeState extends AppScreenState<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  late SignupBloc _signupBloc;
  List<String> list = [];
  DistrictData? districtDropDownValue;
  MandalData? mandalDropDownValue;
  VillageData? villageDropDownValue;

  final DataHelper _dataHelper = DataHelperImpl.instance;
  String token = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    _nameController.addListener(_onName);
    _mobileController.addListener(_onMobileNumber);
    _passwordController.addListener(_onPasswordChanged);
    _confirmpasswordController.addListener(_oConfirmPasswordChanged);
    _signupBloc.fetchDistrict();
    _getToken();
  }

  void _onMobileNumber() {
    _signupBloc.add(MobileChanged(_mobileController.text));
  }

  void _onName() {
    _signupBloc.add(NameChanged(_nameController.text));
  }

  void _onPasswordChanged() {
    _signupBloc.add(PasswordChanged(_passwordController.text));
  }

  void _oConfirmPasswordChanged() {
    _signupBloc.add(ConfirmPasswordChanged(_confirmpasswordController.text));
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget setView() {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.isSignupSuccess) {
              print('UserID>${state.signupData?.userId}');
              print('userIDPRointrd');
              ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                  SnackBar(content: Text('${"Registration Successfully"}')));
              final bundle = Bundle()
                ..put('mobile', _mobileController.text)
                ..put('userID', state.signupData?.userId);
              navigateToScreenAndReplace(Screen.OTP, bundle);
            }
            if (state.isSignupFailure) {
              print('Print>>>>${state.errormessage}');
              if (state.errormessage != null)
                ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                    SnackBar(content: Text('${state.errormessage}')));
            }
          },
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              color: AppColors.letsStartBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        //  height: 60.h,
                        child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            CommonButtons.SIGNUP,
                            style: textTheme.headline6?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 0.2,
                                color: AppColors.letsStartTextColor),
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          UsernameEditText(
                            _nameController,
                            isValid: state.isName,
                            usernameType: UsernameType.name,
                            hinttext: CommonButtons.Name,
                            keyboardtype: TextInputType.text,
                            onChange: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          UsernameEditText(
                            _mobileController,
                            isValid: state.isMobile,
                            usernameType: UsernameType.mobile,
                            hinttext: CommonButtons.MOBILE_NUMBER,
                            keyboardtype: TextInputType.number,
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
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.disablebordercolor),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DistrictData>(
                                value: districtDropDownValue == null
                                    ? null
                                    : districtDropDownValue,
                                isDense: true,
                                isExpanded: true,
                                icon: SvgPicture.asset(
                                    'assets/icons/down_arrow.svg'),
                                items:
                                    state.districtData.map((DistrictData map) {
                                  return new DropdownMenuItem<DistrictData>(
                                    value: map,
                                    child: new Text(map.districtName!,
                                        style: new TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                  );
                                }).toList(),
                                hint: Row(
                                  children: <Widget>[
                                    Text(
                                      ' Select District',
                                      style: textTheme.subtitle1!.copyWith(
                                          fontSize: 15, color: AppColors.grey),
                                    ),
                                  ],
                                ),
                                onChanged: (DistrictData? newValue) {
                                  setState(() {
                                    districtDropDownValue = newValue!;
                                    state.districtID =
                                        newValue.disrictId.toString();
                                  });
                                  state.mandalData = [];
                                  state.mandalID = '';
                                  state.villageData = [];
                                  state.villageID = '';
                                  _signupBloc.fetchMandal(state.districtID);
                                  mandalDropDownValue = null;
                                  villageDropDownValue = null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.disablebordercolor),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<MandalData>(
                                  value: mandalDropDownValue == null
                                      ? null
                                      : mandalDropDownValue,
                                  isDense: true,
                                  isExpanded: true,
                                  icon: SvgPicture.asset(
                                      'assets/icons/down_arrow.svg'),
                                  items: state.mandalData.map((MandalData map) {
                                    return new DropdownMenuItem<MandalData>(
                                      value: map,
                                      child: new Text(map.mandalName!,
                                          style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    );
                                  }).toList(),
                                  hint: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        /*child:
                                            SvgPicture.asset('assets/icons/down_arrow.svg'),*/
                                      ),
                                      Text(
                                        ' Select Mandal',
                                        style: textTheme.subtitle1!.copyWith(
                                            fontSize: 15,
                                            color: AppColors.grey),
                                      ),
                                    ],
                                  ),
                                  onChanged: (MandalData? newValue) {
                                    setState(() {
                                      mandalDropDownValue = newValue!;
                                      state.mandalID =
                                          newValue.mandalId.toString();
                                    });
                                    state.villageData = [];
                                    state.villageID = '';
                                    _signupBloc.fetchVillage(
                                        state.districtID, state.mandalID);
                                    villageDropDownValue = null;
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.disablebordercolor),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<VillageData>(
                                  value: villageDropDownValue == null
                                      ? null
                                      : villageDropDownValue,
                                  isDense: true,
                                  isExpanded: true,
                                  icon: SvgPicture.asset(
                                      'assets/icons/down_arrow.svg'),
                                  items:
                                      state.villageData.map((VillageData map) {
                                    return new DropdownMenuItem<VillageData>(
                                      value: map,
                                      child: new Text(map.villageName!,
                                          style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    );
                                  }).toList(),
                                  hint: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        /* child:
                                            SvgPicture.asset('assets/icons/down_arrow.svg'),*/
                                      ),
                                      Text(
                                        ' Select Village',
                                        style: textTheme.subtitle1!.copyWith(
                                            fontSize: 15,
                                            color: AppColors.grey),
                                      ),
                                    ],
                                  ),
                                  onChanged: (VillageData? newValue) {
                                    setState(() {
                                      villageDropDownValue = newValue!;
                                      state.villageID =
                                          newValue.villageId.toString();
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 38,
                          ),
                          PrimaryButton(
                              title: CommonButtons.SUBMIT,
                              isLoading: state.isSubmitting!,
                              textSize: 14,
                              onPressed: () async {
                                (_mobileController.text != null &&
                                        _mobileController.text.isNotEmpty &&
                                        _nameController.text != null &&
                                        _nameController.text.isNotEmpty &&
                                        _passwordController.text != null &&
                                        _passwordController.text.isNotEmpty &&
                                        _confirmpasswordController.text !=
                                            null &&
                                        _confirmpasswordController
                                            .text.isNotEmpty &&
                                        state.districtID.isNotEmpty &&
                                        state.mandalID.isNotEmpty &&
                                        state.villageID.isNotEmpty)
                                    ? _signupBloc.signup(
                                        _nameController.text,
                                        _mobileController.text,
                                        _passwordController.text,
                                        _confirmpasswordController.text,
                                        state.districtID,
                                        state.mandalID,
                                        state.villageID,
                                    token!)
                                    : ScaffoldMessenger.of(
                                            globalKey.currentContext!)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                                'Please fill all the fields')));
                              },
                              backgroundColor: Colors.blue),

                          SizedBox(height: 2),
                          RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Are you not able to find your village, would you like to onboard your village,Reach us ',
                                    style: textTheme.subtitle1?.copyWith(
                                        fontSize: 10, color: AppColors.black)),
                                TextSpan(
                                    text: 'info@conveys.in',
                                    style: textTheme.subtitle2?.copyWith(
                                        fontSize: 12, color: AppColors.black)),
                              ],
                            ),
                          ),
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
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  _getToken() async {
    String firebaseToken='';
    _dataHelper.cacheHelper.getAccessToken().then((value) {
      firebaseToken = value;
      setState(()  {
        token = firebaseToken;
      });
    });

  }
}
