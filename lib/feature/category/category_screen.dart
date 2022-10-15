import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getinforme/Model/CategoryModel.dart';
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

import 'cubit/category_cubit.dart';

class CategoryPage extends AppScreen {
  CategoryPage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends AppScreenState<CategoryPage>
    with SingleTickerProviderStateMixin {
  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool _status = true;
  var getSampleText='';
  final FocusNode myFocusNode = FocusNode();
  late CategoryCubit _cubit;
  final _nameController = TextEditingController();
  String _userId = '',
      _name = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cubit = BlocProvider.of<CategoryCubit>(context);

    _getUserId();
    // _cubit.getProfileInfo('2');
  }


  @override
  Widget setView() {
    return BlocConsumer<CategoryCubit, CategoryState>(listener: (context, state) {
      // if (state.isEditcategoryDataSuccess) {
      //   _status = true;
      //   FocusScope.of(context).requestFocus(new FocusNode());
      //   ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
      //       SnackBar(content: Text('Profile Successfully Updated')));
      // }

      // if(state.iscategoryDataSuccess){
      //   _setValue(state.categoryData!,state);
      // }

      // if (state.iscategoryDataFailure) {
      //   ScaffoldMessenger.of(globalKey.currentContext!)
      //       .showSnackBar(SnackBar(content: Text('${state.errorMsg}')));
      // }
    }, builder: (context, state) {
      if (state.categoryData != null ) {
        final SampleText = state.categoryData.msg;
        // final todo = todos[index];
        print('District>>>>${state.categoryData}');
        print('DistrictData>>>>${state.categoryData.msg}');
        // String? SampleText = state.categoryData.msg;
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
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
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
                                              "${SampleText}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),

                                // Padding(
                                //     padding: EdgeInsets.only(
                                //         left: 25.0, right: 25.0, top: 2.0),
                                //     child: new Row(
                                //       mainAxisSize: MainAxisSize.max,
                                //       children: <Widget>[
                                //         new Flexible(
                                //           child: new TextField(
                                //             controller: _nameController,
                                //             decoration: const InputDecoration(
                                //               hintText: "Enter Your Name",
                                //             ),
                                //             enabled: !_status,
                                //             autofocus: !_status,
                                //             onChanged: (text) {
                                //               _name = text;
                                //             },
                                //           ),
                                //         ),
                                //       ],
                                //     )),
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


  // _setValue(CategoryInfo? categoryData, CategoryState state) {
  //   _name = categoryData!.name!;
  //   _nameController.text = _name;
  // }

  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(()  {
        _userId = value;
        _cubit.getSampleText(_userId);
      });
    });
  }

}
