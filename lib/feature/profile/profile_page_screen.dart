import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getinforme/Model/ProfileModel.dart';
import 'package:getinforme/Thems/Responsive.dart';

import '../../Model/DistrictModel.dart';
import '../../Model/MandalModel.dart';
import '../../Model/VillageModel.dart';
import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../widgets/AppLoader.dart';

import 'cubit/profile_cubit.dart';

class ProfilePage extends AppScreen {
  ProfilePage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends AppScreenState<ProfilePage>
    with SingleTickerProviderStateMixin {
  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  late ProfileCubit _cubit;
  final _nameController = TextEditingController();
  final _districtController = TextEditingController();
  final _mandalController = TextEditingController();
  final _villageController = TextEditingController();
  final _mobileController = TextEditingController();
  DistrictData? districtDropDownValue;
  MandalData? mandalDropDownValue;
  VillageData? villageDropDownValue;
  String _userId = '',
      _name = '',
      _districtId = '',
      _madalId = '',
      _villageId = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cubit = BlocProvider.of<ProfileCubit>(context);

    _getUserId();
    // _cubit.getProfileInfo('2');
  }


  @override
  Widget setView() {
    return BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
      if (state.isEditProfiledataSuccess) {
        _status = true;
        FocusScope.of(context).requestFocus(new FocusNode());
        ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
            SnackBar(content: Text('Profile Successfully Updated')));
      }

      if(state.isProfiledataSuccess){
        _setValue(state.profileData.data!,state);
      }

      if (state.isProfiledataFailure) {
        ScaffoldMessenger.of(globalKey.currentContext!)
            .showSnackBar(SnackBar(content: Text('${state.errorMsg}')));
      }
    }, builder: (context, state) {
      if (!state.isProfiledataLoading) if (state.profileData != null &&
          state.profileData.data != null) {

        print('DistrictData>>>>${state.districtData.toList()}');
        print('MandalData>>>>${state.mandalData.toList()}');
        return SafeArea(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.letsStartBackground,
              child: new Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          height: 6.h,
                          color: Colors.white,
                          child: Center(
                            child: new Text('PROFILE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    fontFamily: 'sans-serif-light',
                                    color: Colors.black)),
                          ),
                        ),
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Parsonal Information',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status
                                                ? _getEditIcon()
                                                : new Container(),
                                          ],
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 15.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: _nameController,
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your Name",
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                            onChanged: (text) {
                                              _name = text;
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 15.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Mobile',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: _mobileController,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Enter Mobile Number"),
                                            enabled: false,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 15.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'District',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: DropdownButtonHideUnderline(
                                              child:
                                                  DropdownButton<DistrictData>(
                                                value: districtDropDownValue ==
                                                        null
                                                    ? null
                                                    : districtDropDownValue,
                                                isDense: true,
                                                isExpanded: true,
                                                icon: SvgPicture.asset(
                                                    'assets/icons/down_arrow.svg'),
                                                items: state.districtData
                                                    .map((DistrictData map) {
                                                  return new DropdownMenuItem<
                                                      DistrictData>(
                                                    value: map,
                                                    child: new Text(
                                                        map.districtName!,
                                                        style: new TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15)),
                                                  );
                                                }).toList(),
                                                hint: Row(
                                                  children: <Widget>[
                                                    (state.profileData.data !=
                                                                null &&
                                                            state
                                                                    .profileData
                                                                    .data!
                                                                    .district! !=
                                                                null)
                                                        ? Text(
                                                            state
                                                                .profileData
                                                                .data!
                                                                .district!,
                                                            style: textTheme
                                                                .subtitle1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        18,
                                                                    color: AppColors
                                                                        .black),
                                                          )
                                                        : Text(''),
                                                  ],
                                                ),
                                                onChanged:
                                                    (DistrictData? newValue) {
                                                  setState(() {
                                                    districtDropDownValue =
                                                        newValue!;
                                                    state.districtID = newValue
                                                        .disrictId
                                                        .toString();
                                                  });
                                                  _districtId =
                                                      state.districtID;
                                                  _madalId = '';
                                                  _villageId = '';
                                                  state.mandalData = [];
                                                  state.mandalID = '';
                                                  state.villageData = [];
                                                  state.villageID = '';
                                                  _cubit.fetchMandal(
                                                      state.districtID);
                                                  mandalDropDownValue = null;
                                                  villageDropDownValue = null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: AppColors.grey50,
                                  margin: EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 15.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Mandal',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: DropdownButtonHideUnderline(
                                              child: IgnorePointer(
                                                ignoring: _status,
                                                child: DropdownButton<
                                                        MandalData>(
                                                    value: mandalDropDownValue ==
                                                            null
                                                        ? null
                                                        : mandalDropDownValue,
                                                    isDense: true,
                                                    isExpanded: true,
                                                    icon: SvgPicture.asset(
                                                        'assets/icons/down_arrow.svg'),
                                                    items: state.mandalData
                                                        .map((MandalData map) {
                                                      return new DropdownMenuItem<
                                                          MandalData>(
                                                        value: map,
                                                        child: new Text(
                                                            map.mandalName!,
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15)),
                                                      );
                                                    }).toList(),
                                                    hint: Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.0),
                                                          /*child:
                                                SvgPicture.asset('assets/icons/down_arrow.svg'),*/
                                                        ),
                                                        (state.profileData
                                                                        .data !=
                                                                    null &&
                                                                state
                                                                        .profileData
                                                                        .data!
                                                                        .mandal! !=
                                                                    null)
                                                            ? Text(
                                                                state
                                                                    .profileData
                                                                    .data!
                                                                    .mandal!,
                                                                style: textTheme
                                                                    .subtitle1!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color: AppColors
                                                                            .black),
                                                              )
                                                            : Text(''),
                                                      ],
                                                    ),
                                                    onChanged:
                                                        (MandalData? newValue) {
                                                      setState(() {
                                                        mandalDropDownValue =
                                                            newValue!;
                                                        state.mandalID =
                                                            newValue.mandalId
                                                                .toString();
                                                      });
                                                      _madalId = state.mandalID;
                                                      _villageId = '';
                                                      state.villageData = [];
                                                      state.villageID = '';
                                                      _cubit.fetchVillage(
                                                          state.districtID,
                                                          state.mandalID);
                                                      villageDropDownValue =
                                                          null;
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: AppColors.grey50,
                                  margin: EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 15.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Village',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: DropdownButtonHideUnderline(
                                              child: IgnorePointer(
                                                ignoring: _status,
                                                child: DropdownButton<
                                                        VillageData>(
                                                    value: villageDropDownValue ==
                                                            null
                                                        ? null
                                                        : villageDropDownValue,
                                                    isDense: true,
                                                    isExpanded: true,
                                                    icon: SvgPicture.asset(
                                                        'assets/icons/down_arrow.svg'),
                                                    items: state.villageData
                                                        .map((VillageData map) {
                                                      return new DropdownMenuItem<
                                                          VillageData>(
                                                        value: map,
                                                        child: new Text(
                                                            map.villageName!,
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15)),
                                                      );
                                                    }).toList(),
                                                    hint: Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.0),
                                                          /* child:
                                              SvgPicture.asset('assets/icons/down_arrow.svg'),*/
                                                        ),
                                                        (state.profileData
                                                                        .data !=
                                                                    null &&
                                                                state
                                                                        .profileData
                                                                        .data!
                                                                        .village! !=
                                                                    null)
                                                            ? Text(
                                                                state
                                                                    .profileData
                                                                    .data!
                                                                    .village!,
                                                                style: textTheme
                                                                    .subtitle1!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color: AppColors
                                                                            .black),
                                                              )
                                                            : Text(''),
                                                      ],
                                                    ),
                                                    onChanged: (VillageData?
                                                        newValue) {
                                                      setState(() {
                                                        villageDropDownValue =
                                                            newValue!;
                                                        state.villageID =
                                                            newValue.villageId
                                                                .toString();
                                                      });
                                                      _villageId =
                                                          state.villageID;
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: AppColors.grey50,
                                  margin: EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                ),
                                !_status
                                    ? _getActionButtons(state)
                                    : new Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        );
      }

      return AppLoader(
        isLoading: true,
      );
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Widget _getActionButtons(ProfileState state) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new MaterialButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  if(_nameController.text.isNotEmpty) {
                    _name = _nameController.text;
                    if (state.districtID.isNotEmpty) {
                      if (state.mandalID.isNotEmpty) {
                        if (state.villageID.isNotEmpty) {
                          setState(() {
                            _cubit.editProfile(
                                _userId, _name, state.districtID, state.mandalID,
                                state.villageID);
                          });
                        } else {
                          ScaffoldMessenger.of(globalKey.currentContext!)
                              .showSnackBar(
                              SnackBar(content: Text('Please select village')));
                        }
                      } else {
                        ScaffoldMessenger.of(globalKey.currentContext!)
                            .showSnackBar(SnackBar(
                            content: Text('Please select mandal')));
                      }
                    } else {
                      ScaffoldMessenger.of(globalKey.currentContext!)
                          .showSnackBar(SnackBar(content: Text(
                          'Please select district')));
                    }
                    print(
                        'SelectedID>>>$_districtId>>>$_madalId>>>$_villageId');
                  }else{
                    ScaffoldMessenger.of(globalKey.currentContext!)
                        .showSnackBar(SnackBar(content: Text(
                        'Please enter name')));
                  }
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new MaterialButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                     FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: AppColors.darkBlue,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  _setValue(ProfileInfo? profileData, ProfileState state) {
    _name = profileData!.name!;
     state.districtID = profileData.district_id!;
    state.mandalID = profileData.mandal_id!;
    state.villageID = profileData.village_id!;
    _nameController.text = _name;
    _mobileController.text = profileData.mobile!;
    print('${state.districtID},${state.mandalID},${state.villageID}');
  }

  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(()  {
        _userId = value;
        _cubit.fetchDistrict(_userId);
      });
    });
  }

}
