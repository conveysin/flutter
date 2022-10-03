import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getinforme/Model/DepartmentModel.dart';
import 'package:getinforme/Model/PostModel.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/core/routes.dart';
import 'package:getinforme/feature/pilot/bloc/pilot_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/DistrictModel.dart';
import '../../Model/MandalModel.dart';
import '../../Model/VillageModel.dart';
import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../utility/shadows.dart';
import '../../utility/strings.dart';
import '../../widgets/AppLoader.dart';
import '../../widgets/dashline.dart';

import '../../widgets/primary_button.dart';
import '../login_screen/bloc/login_bloc.dart';
import '../login_screen/letsStart_screen.dart';
import '../post/cubit/post_cubit.dart';
import '../post/cubit/post_state.dart';


class PilotPostpage extends AppScreen {
  PilotPostpage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _PilotPostpageState createState() => _PilotPostpageState();
}

class _PilotPostpageState extends AppScreenState<PilotPostpage> {
  final DataHelper _dataHelper = DataHelperImpl.instance;
  final TextEditingController _messageController = TextEditingController();
  String userID = '';
  ImagePicker imagePicker = ImagePicker();
  File? _image =  File('qwerty');
  late PilotBloc _pilotBloc;
  List<String> list = [];
  DistrictData? districtDropDownValue;
  MandalData? mandalDropDownValue;
  VillageData? villageDropDownValue;
  DepartmentData? departmentDropDownValue;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageController.dispose();
  }


  @override
  void onInit() {
    super.onInit();
    _pilotBloc = BlocProvider.of<PilotBloc>(context);
    _getUserId();
    _pilotBloc.fetchDistrict();
  }


  @override
  Widget setView() {
    return BlocConsumer<PilotBloc, PilotState>(listener: (context, state) {
      if(state.isPilotPostSuccess){
        ScaffoldMessenger.of(
            globalKey.currentContext!)
            .showSnackBar(SnackBar(
            content: Text(
                'Post upload successfully')));
        if(state.postID !=null) {
          _pilotBloc.sendPushnotification(
              state.districtID, state.mandalID, state.villageID, state.postID!);
        }
        navigateToScreenAndReplace(Screen.PilotPostpage);
      }

      if(state.isPilotPostFailure){
        ScaffoldMessenger.of(
            globalKey.currentContext!)
            .showSnackBar(SnackBar(
            content: Text(
                state.errormessage.toString())));
      }

    }, builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.darkBlue),
          title: Text(
            'Post Page',
            style: textTheme.headline6,
          ),
         /* actions: [InkWell(
            onTap: (){
              onLogout();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.logout),
            ),
          )],*/

        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
            /*  new Stack(
                children: [
                  InkWell(
                    onTap:(){
          _pickImage();
          },
                    child: Center(
                      child: new Container(
                        width: 80.w,
                        height: 40.w,
                        margin: const EdgeInsets.only(),
                        decoration: (_image != null)
                            ? BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [Shadows.bgCardShadow],
                            image: DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.cover))
                            : BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            color: AppColors.white,
                            boxShadow: [Shadows.bgCardShadow]),
                        child: _image !=null ? Center(child: Text('')) : Center(child: Text('Select Image')),
                      ),
                    ),
                  ),
                ],
              ),*/
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
                      state.departmentData = [];
                      state.departmentID = '';
                      departmentDropDownValue = null;
                      _pilotBloc.fetchMandal(state.districtID);
                      mandalDropDownValue = null;
                      villageDropDownValue = null;
                      departmentDropDownValue = null;
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
                        _pilotBloc.fetchVillage(
                            state.districtID, state.mandalID);
                        villageDropDownValue = null;
                        state.departmentData = [];
                        state.departmentID = '';
                        departmentDropDownValue = null;
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
                          _pilotBloc.fetchdepartmentData(state.villageID,userID);
                          state.departmentData = [];
                          state.departmentID = '';
                          departmentDropDownValue = null;

                        });
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
                  child: DropdownButton<DepartmentData>(
                      value: departmentDropDownValue == null
                          ? null
                          : departmentDropDownValue,
                      isDense: true,
                      isExpanded: true,
                      icon: SvgPicture.asset(
                          'assets/icons/down_arrow.svg'),
                      items:
                      state.departmentData.map((DepartmentData map) {
                        return new DropdownMenuItem<DepartmentData>(
                          value: map,
                          child: new Text(map.name!,
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
                            ' Select Department',
                            style: textTheme.subtitle1!.copyWith(
                                fontSize: 15,
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                      onChanged: (DepartmentData? newValue) {
                        setState(() {
                          departmentDropDownValue = newValue!;
                          state.departmentID =
                              newValue.id.toString();
                        });
                      }),
                ),
              ),
SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.all(5),
                height: 5 * 25.0,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueShade2),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter a message",
                    filled: true,
                  ),
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
                    ( state.districtID.isNotEmpty &&
                        state.mandalID.isNotEmpty &&
                        state.villageID.isNotEmpty && state.departmentID .isNotEmpty && _messageController.text.isNotEmpty)
                        ?_pilotBloc.add_posts(userID,state.districtID.toString(),state.mandalID.toString(),state.villageID.toString(),
                        state.departmentID.toString(),
                        _messageController.text,'','2')
                        : ScaffoldMessenger.of(
                        globalKey.currentContext!)
                        .showSnackBar(SnackBar(
                        content: Text(
                            'Please fill all the fields')));
                  },
                  backgroundColor: Colors.blue),



            ]),
          ),
        ),
      ));


    });
  }

  _pickImage() async {
    _settingModalBottomSheet(context);
  }
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 120,
            color: Colors.transparent,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(
                          Icons.camera,
                          color: AppColors.darkBlue,
                        ),
                        title: new Text(
                          "Camera",
                          style: textTheme.subtitle1?.copyWith(
                              color: AppColors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        onTap: () => {getImageCamera()}),
                    new ListTile(
                      leading: new Icon(
                        Icons.photo,
                        color: AppColors.darkBlue,
                      ),
                      title: new Text(
                        "Gallery",
                        style: textTheme.subtitle1?.copyWith(
                            color: AppColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      onTap: () => {getImageGallery()},
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  getImageGallery() async {
    Navigator.pop(context);
    var file =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(file!.path);
    });
    if (_image != null) {
      setState(() {
       // _cubit.uplaodimage(_image!);
      });
    }
  }

  getImageCamera() async {
    Navigator.pop(context);
    var file = await ImagePicker.platform.pickImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 60);
    setState(() {
      _image = File(file!.path);
    });
    if (_image != null) {
      setState(() {
      //  _cubit.uplaodimage(_image!);
      });
    }
  }

  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(() {
        userID = value;
        print("UserId>>>>>$userID");
      });
    });
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
}
