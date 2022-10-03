import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getinforme/Model/PostModel.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/core/routes.dart';
import 'package:html/parser.dart';

import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../widgets/AppLoader.dart';
import '../../widgets/dashline.dart';

import 'cubit/post_cubit.dart';
import 'cubit/post_state.dart';

class PostPage extends AppScreen {
  PostPage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends AppScreenState<PostPage> {
  late PostCubit _cubit;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String userID = '';
  String departmentName = '';
  PostData postData = new PostData();
  List<PostData> _postList = [];
  int _likeIndex = 0;
  String departmentID = '';
  String villageID = '';

  @override
  void onResumed() {
    super.onResumed();
    _cubit = BlocProvider.of<PostCubit>(context);
  }

  @override
  void initState() {
    _getUserId();
    _getVillageId(false);
    super.initState();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _cubit = BlocProvider.of<PostCubit>(context);
    _getUserId();
    _getVillageId(false);
  }

  @override
  Widget setView() {
    return BlocConsumer<PostCubit, PostState>(listener: (context, state) {
      if (state.isLikeSuccess) {
        _getVillageId(false);
      }

      if (state.isPostdataFailure) {
        ScaffoldMessenger.of(globalKey.currentContext!)
            .showSnackBar(SnackBar(content: Text(state.errorMsg.toString())));
      }
    }, builder: (context, state) {

        if (!state.isPostdataLoading)
          return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: departmentName.isNotEmpty ? Text(departmentName):Text("POSTS"),
                ),
                body: Container(
            color: AppColors.letsStartBackground,
            child: Column(children: [
                SizedBox(
                  height: 10,
                ),
               /* RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: ' ',
                          style: textTheme.subtitle1
                              ?.copyWith(fontSize: 15, color: AppColors.black)),
                      TextSpan(
                          text: departmentName.isNotEmpty ? departmentName:"POSTS",
                          style: textTheme.subtitle2
                              ?.copyWith(fontSize: 18, color: AppColors.black)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),*/
                //DashLine(),
                (state.isPostdataFailure)
                    ? Text(
                    state.errorMsg,
                    style:
                        textTheme.headline6?.copyWith(color: AppColors.black),
                      )
                    : departmentList(state.postData),
            ]),
          ),
              ));

        return AppLoader(
          isLoading: true,
        );

    });
  }

  Widget topTilte() {
    return Container(
      height: 11.4.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19.0, top: 35.0, bottom: 8.0),
            child: Image.asset(
              ImagePath.LOGO_BLUE,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          Spacer(),
          Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 19.0, top: 35, bottom: 8.0),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Image.asset(ImagePath.notification),
                ),
              ),
              Positioned(
                right: 12.0,
                top: 25.0,
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget departmentList(_postList) {
    return SizedBox(
      height: 100.h - 100,
      child: Container(
        color: AppColors.letsStartBackground,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: _postList.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    List<PostData> list = _postList;
                    final bundle = Bundle()
                      ..put('postImage', list[i].postImage)
                      ..put('content', list[i].contentEnglish)
                      ..put('like', list[i].likes)
                      ..put('view', list[i].views)
                      ..put('post_author', list[i].post_author)
                      ..put('post_date', list[i].post_date)
                      ..put('post_id', list[i].post_id.toString())
                      ..put('is_like', list[i].isLike)
                      ..put('is_view', list[i].is_view);

                    Navigator.pushNamed(
                      context,
                      Screen.PostDetails.toString(),
                      arguments: bundle,
                    ).then((_) {
                      _cubit.fetchPostData(departmentID, villageID, userID, false);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 45.w,
                                  child: Text(
                                    _postList[i].post_author.toString(),
                                    maxLines: 1,
                                    style: textTheme.headline6!.copyWith(
                                        color: AppColors.white, fontSize: 16),
                                  )),
                              (_postList[i].post_date != null)
                                  ? Container(
                                      width: 30.w,
                                      child: Text(
                                          _postList[i].post_date.toString(),
                                          maxLines: 1,
                                          style: textTheme.subtitle2!.copyWith(
                                              color: AppColors.white,
                                              fontSize: 10)))
                                  : Container(
                                      width: 15.w,
                                    )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(5)),
                          width: double.infinity,
                          height: 18.h,
                          child:  Column(
                            children: [
                              (_postList[i].contentEnglish !=null)?  Html(
                                data:  (_postList[i].contentEnglish.toString().isNotEmpty && _postList[i].contentEnglish.toString().length>140) ? _postList[i].contentEnglish.toString().substring(0,140)+"..." : _postList[i].contentEnglish.toString(),
                                tagsList: Html.tags..addAll(["bird", "flutter"]),
                                style: {
                                  "table": Style(
                                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                                  ),
                                  "tr": Style(
                                    border: Border(bottom: BorderSide(color: Colors.grey)),
                                  ),
                                  "th": Style(
                                    padding: EdgeInsets.all(6),
                                    backgroundColor: Colors.grey,
                                  ),
                                  "td": Style(
                                    padding: EdgeInsets.all(6),
                                    alignment: Alignment.topLeft,
                                  ),
                                  'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                                },
                                customRender: {
                                  "table": (context, child) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child:
                                      (context.tree as TableLayoutElement).toWidget(context),
                                    );
                                  },
                                  "bird": (RenderContext context, Widget child) {
                                    return TextSpan(text: "🐦");
                                  },
                                  "flutter": (RenderContext context, Widget child) {
                                    return FlutterLogo(
                                      style: (context.tree.element!.attributes['horizontal'] != null)
                                          ? FlutterLogoStyle.horizontal
                                          : FlutterLogoStyle.markOnly,
                                      textColor: context.style.color!,
                                      size: context.style.fontSize!.size! * 5,
                                    );
                                  },
                                },
                                customImageRenders: {
                                  networkSourceMatcher(domains: ["flutter.dev"]):
                                      (context, attributes, element) {
                                    return FlutterLogo(size: 36);
                                  },
                                  networkSourceMatcher(domains: ["mydomain.com"]):
                                  networkImageRender(
                                    headers: {"Custom-Header": "some-value"},
                                    altWidget: (alt) => Text(alt ?? ""),
                                    loadingWidget: () => Text("Loading..."),
                                  ),
                                  // On relative paths starting with /wiki, prefix with a base url
                                      (attr, _) =>
                                  attr["src"] != null && attr["src"]!.startsWith("/wiki"):
                                  networkImageRender(
                                      mapUrl: (url) => "https://upload.wikimedia.org" + url!),
                                  // Custom placeholder image for broken links
                                  networkSourceMatcher():
                                  networkImageRender(altWidget: (_) => FlutterLogo()),
                                },
                                onLinkTap: (url, _, __, ___) {
                                  print("Opening $url...");
                                },
                                onImageTap: (src, _, __, ___) {
                                  print(src);
                                },
                                onImageError: (exception, stackTrace) {
                                  print(exception);
                                },
                                onCssParseError: (css, messages) {
                                  print("css that errored: $css");
                                  print("error messages:");
                                  messages.forEach((element) {
                                    print(element);
                                  });
                                },
                              ):Text(''),
                              Text('Click here to Read More',style: textTheme.subtitle1?.copyWith(color: AppColors.darkBlue,fontWeight: FontWeight.bold,fontSize: 16),),
                            ],
                          )
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  _likeIndex = i;
                                  _cubit.like_posts(
                                      _postList[i].post_id.toString(), userID);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_alt_sharp,
                                      color: AppColors.white,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      _postList[i].likes.toString(),
                                      style: textTheme.headline6!.copyWith(
                                          color: AppColors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(_postList[i].views.toString(),
                                      style: textTheme.subtitle2!.copyWith(
                                          color: AppColors.white, fontSize: 18))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  _getVillageId(bool isLoad) async {
    _dataHelper.cacheHelper.getVillage().then((value) {
      setState(() {
        print("VillageId>>>>>$value");
        if (widget.arguments?.get('departmentID') != null) {
           departmentID = widget.arguments?.get('departmentID');
           villageID = value;
          _cubit.fetchPostData(departmentID, villageID, userID, isLoad);
        }

        if (widget.arguments?.get('departmentName') != null) {
           departmentName = widget.arguments?.get('departmentName');

        }

      });
    });
  }

  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(() {
        userID = value;
        print("UserId>>>>>$userID");
      });
    });
  }

  onLikePressed(int index) {
    postData = _postList[index];
    setState(() {
      postData.isLike = !postData.isLike!;
    });
  }
}
