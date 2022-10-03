import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getinforme/Model/DepartmentModel.dart';
import 'package:getinforme/Thems/Responsive.dart';

import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../core/routes.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../widgets/AppLoader.dart';
import '../../widgets/dashline.dart';
import 'cubit/home_cubit.dart';

class HomePage extends AppScreen {
  HomePage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends AppScreenState<HomePage> {
  late HomeCubit _cubit;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String userID = '';
  String villageID = '';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<HomeCubit>(context);
    _getUserId();
    _getVillageId();
    super.initState();
  }

  @override
  Widget setView() {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (!state.isHomedataFailure) {
            if (!state.isHomedataLoading) {
              if (state.departmentData.isEmpty) {
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
                appBar: _appBar(25.h, context, state, textTheme),

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
                    departmentList(state.departmentData),
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

  Widget departmentList(List<DepartmentData> list) {
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
                padding: EdgeInsets.all(10.0),
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
                              _cubit.fetchHomeData(villageID,userID);

                          /*    setState(() {
                                _getVillageId();
                              });*/

                            });





                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),

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

                                            Positioned(
                                                child: Icon(
                                              Icons.mark_chat_unread_rounded,
                                              color: AppColors.lightBlueShade1,
                                              size: 22,
                                            )),

                                            Positioned(
                                                right: 1,
                                                top: 4,
                                                child: Text(
                                                  data.unread_post_count.toString(),
                                                  style: textTheme.headline1
                                                      ?.copyWith(fontSize: 16,color: AppColors.darkBlue),
                                                )),
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
                                      height: 5,
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
        _cubit.fetchHomeData(value,userID);
      });
    });
  }




}

_appBar(height, BuildContext context, HomeState state, textTheme) =>
    PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 130),
      child: Stack(
        children: <Widget>[
          Container(
            // Background
            child: Center(
              child: Text(
                "Dashboard",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white),
              ),
            ),
            color: AppColors.darkBlue,
            height: 80,
            width: MediaQuery.of(context).size.width,
          ),

          Container(), // Required some widget in between to float AppBar

          Positioned(
            // To take AppBar Size only
            top: 60.0,
            left: 20.0,
            right: 20.0,
            child: AppBar(
              backgroundColor: Colors.blueAccent,
              automaticallyImplyLeading: false,
              primary: false,
              title: RichText(
                maxLines: 2,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sponsored By>> ',
                        style: textTheme.subtitle1
                            ?.copyWith(fontSize: 13.0, color: AppColors.white)),
                    TextSpan(
                        text: state.sponser_name,
                        style: textTheme.subtitle2
                            ?.copyWith(fontSize: 16.0, color: AppColors.white)),
                  ],
                ),
              ),
              /*       actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Theme.of(context).primaryColor), onPressed: () {},),
            IconButton(icon: Icon(Icons.notifications, color: Theme.of(context).primaryColor),
              onPressed: () {},)
          ],*/
            ),
          )
        ],
      ),
    );


