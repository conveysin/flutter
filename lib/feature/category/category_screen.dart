import 'package:cached_network_image/cached_network_image.dart';
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
import '../../core/routes.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../widgets/AppLoader.dart';

import '../../widgets/app_edit_text.dart';
import 'cubit/category_cubit.dart';

import 'package:flutter/cupertino.dart';

class CategoryPage extends AppScreen {
  CategoryPage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends AppScreenState<CategoryPage> {
  late CategoryCubit _cubit;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String userID = '';
  String villageID = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _cubit = BlocProvider.of<CategoryCubit>(context);
    _getUserId();
    _getVillageId();
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: const Text("CupertinoSearchTextField"),
  //       ),
  //       body: CupertinoPageScaffold(
  //         child: Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: CupertinoSearchTextField(
  //               controller: _searchController,
  //               onChanged: (value) {},
  //               onSubmitted: (value) {},
  //               autocorrect: true,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  // }

  @override
  Widget setView() {
    return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (!state.iscategoryDataFailure) {
            if (!state.iscategoryDataLoading) {
              if (state.categoryData.isEmpty) {
                return SafeArea(
                    child: Container(
                        color: AppColors.letsStartBackground,
                        child: Center(
                            child: Text(
                          state.errorMsg,
                          style: textTheme.headline6
                              ?.copyWith(color: AppColors.black),
                        ))));
              }

              return SafeArea(
                  child: Scaffold(
                    appBar: _appBar(25.h, context, state, textTheme, _searchController),
                /*AppBar(
                      backgroundColor: AppColors.backgroundColor,
                      actions: [],
                      automaticallyImplyLeading: false,
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sponsored By : ',
                                style: textTheme.subtitle1?.copyWith(
                                    fontSize: 15, color: AppColors.white)),
                            TextSpan(
                                text: state.sponser_name,
                                style: textTheme.subtitle2?.copyWith(
                                    fontSize: 18, color: AppColors.white)),
                          ],
                        ),
                      ),
                    ),*/
                body: Container(
                  color: AppColors.letsStartBackground,
                  child: Column(children: [
                    CategoryList(state.categoryData),

                  ]),
                ),

              ));
            } else {
              return AppLoader(
                isLoading: true,
              );
            }
          } else {
            return SafeArea(
                child: Container(
                    color: AppColors.white,
                    child: Center(
                        child: Text(
                      state.errorMsg,
                      style: textTheme.headline6,
                    ))));
          }
        });
  }

  Widget CategoryList(List<CategoryData> list) {
    return SizedBox(
      height: 100.h - 220,
      child: Container(
        color: AppColors.letsStartBackground,
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: (2 / 2.9),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                //physics:BouncingScrollPhysics(),
                padding: EdgeInsets.all(5.0),
                children: list
                    .map(
                      (data) => GestureDetector(
                          onTap: () {
                            Bundle bundle = new Bundle()
                              ..put('departmentID', data.id)
                              ..put('departmentName', data.name);
                          //  navigateToScreen(Screen.PostPage, bundle);

                            Navigator.pushNamed(
                              context,
                              Screen.PostPage.toString(),
                              arguments: bundle,
                            ).then((_) {
                              _cubit.getCategoryInfo(userID);

                          /*    setState(() {
                                _getVillageId();
                              });*/

                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(30),

                            //  margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            //color:data.color,
                            color: Colors.white,
                            child: Stack(children: [
                              Positioned(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Stack(
                                          children: [
                                            // Text(
                                            //    "hellowrold",
                                            //    style: textTheme.headline6?.copyWith(
                                            //        fontSize: 24,
                                            //        fontWeight: FontWeight.bold,
                                            //         wordSpacing: 0.2,
                                            //        color: AppColors.letsStartTextColor),
                                            //  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    data.logo != null
                                        ? CachedNetworkImage(
                                            imageUrl: data.logo!,
                                            height: 55,
                                            width: 55,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            // errorWidget: (context, url, error) => Icon(Icons.error),
                                          )
                                        : AppLoader(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    (data.name != null)
                                        ? Text(data.name!,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                            textAlign: TextAlign.center)
                                        : Text(''),
                                  ],
                                ),
                              ),
                            ]),
                          )),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(() {
        userID = value;
        print("UserId>>>>>$userID");
      });
    });
  }

  _getVillageId() async {
    _dataHelper.cacheHelper.getVillage().then((value) {
      setState(() {
        print("VillageId>>>>>$value");
        villageID = value;
        _cubit.getCategoryInfo(userID);
      });
    });
  }

}


_appBar(height, BuildContext context, CategoryState state, textTheme, TextEditingController _searchController) =>
    PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 130),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                // padding: const EdgeInsets.all(10.0),
                child: CupertinoSearchTextField(
                // controller: _searchController.Text,
                // onChanged: (value){},
                // onSubmitted: () {},
                prefixInsets: EdgeInsets.only(left: 20),
                suffixInsets: EdgeInsets.only(right: 20),
                itemSize: 30,
                itemColor: Color.fromARGB(255, 2, 58, 243),
                controller: _searchController,
                // autocorrect: true,
                  ),
                ),

              ),
          // Container(), // Required some widget in between to float AppBar
          // Positioned(
          //   // To take AppBar Size only
          //   top: 60.0,
          //   left: 20.0,
          //   right: 20.0,
          //   child: AppBar(
          //     backgroundColor: Colors.blueAccent,
          //     automaticallyImplyLeading: false,
          //     primary: false,
          //     title: RichText(
          //       maxLines: 2,
          //       text: TextSpan(
          //         children: 
          //         <TextSpan>[
          //           TextSpan(
          //               text: 'Sponsored By>> ',
          //               style: textTheme.subtitle1
          //                   ?.copyWith(fontSize: 13.0, color: AppColors.white)),
          //           TextSpan(
          //               text: "testsponsor",
          //               style: textTheme.subtitle2
          //                   ?.copyWith(fontSize: 16.0, color: AppColors.white)),
          //         ],
          //       ),
          //     ),
              /*       actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Theme.of(context).primaryColor), onPressed: () {},),
            IconButton(icon: Icon(Icons.notifications, color: Theme.of(context).primaryColor),
              onPressed: () {},)
          ],*/
            // ),
          // )
        ],
      ),
    );
    


