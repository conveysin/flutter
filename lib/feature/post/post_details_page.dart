import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getinforme/Model/PostModel.dart';
import 'package:getinforme/Thems/Responsive.dart';


import '../../core/app_screen.dart';
import '../../core/bundle.dart';
import '../../data/data_helper.dart';
import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../widgets/AppLoader.dart';
import '../../widgets/dashline.dart';

import 'cubit/post_cubit.dart';
import 'cubit/post_state.dart';

class PostDetailPage extends AppScreen {
  PostDetailPage({
    RouteObserver<Route>? routeObserver,
    Key? key,
    Bundle? arguments,
  }) : super(routeObserver, key, arguments);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends AppScreenState<PostDetailPage> {
  late PostCubit _cubit;
  final DataHelper _dataHelper = DataHelperImpl.instance;
  String userID = '';
  PostData postData = new PostData();
  List<PostData> _postList = [];
  int _likeIndex = 0;
  String _postImage = '',
      _content = '',
      _post_author = '',
      _post_date = '',
      _post_id = '';
  int _like = 0,
      _view = 0;
  bool _isLike = true;
  bool is_View = true;

  @override
  void onInit() {
    setState(() {
      getDataArguments();
    });

    super.onInit();
    _cubit = BlocProvider.of<PostCubit>(context);
    _getUserId();

  }

  @override
  Widget setView() {
    return BlocConsumer<PostCubit, PostState>(listener: (context, state) {
      if (state.isLikeSuccess) {
        _isLike = true;
        _like++;
       // _cubit.fetchPostData('3','3',userID,false);
      }

      if(state.isViewSuccess){
        is_View = true;
        _view++;
      }





    }, builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.darkBlue),
          title: Text(
            'Detail',
            style: textTheme.headline6,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              /*Center(
                child: Container(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: _postImage,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => AppLoader(),
                    //errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),*/
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width:55.w,
                      child: Text(_post_author,maxLines: 1,style: textTheme.headline5!.copyWith(color: AppColors.darkBlue,fontSize: 16),)),
                  (_post_date !=null)?
                  Container(
                      width: 25.w,
                      child: Text(_post_date.toString(),maxLines: 1,style: textTheme.subtitle2!.copyWith(color: AppColors.darkBlue,fontSize: 12))):Container(
                    width: 15.w,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        if(!_isLike) {
                          _cubit.like_posts(_post_id.toString(), userID);
                        }else{
                          ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
                              SnackBar(content: Text('You already liked this post')));
                        }
                      },
                      child: Column(
                        children: [
                          Text('Like',),
                          Row(
                            children: [
                              Icon(Icons.thumb_up_alt_sharp,color: AppColors.black,),
                              SizedBox(width: 2,),
                              Text(_like.toString(),style: textTheme.headline6!.copyWith(color: AppColors.darkBlue,fontSize: 18),),
                            ],
                          ),
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){
                       // _cubit.view_posts(_post_id.toString(), userID);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('View'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.remove_red_eye,color: AppColors.black,),
                              SizedBox(width: 2,),
                              Text(_view.toString(),style: textTheme.subtitle2!.copyWith(color: AppColors.darkBlue,fontSize: 18))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              _content !=null ?
              Html(
                data: _content,
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

            ]),
          ),
        ),
      ));

      return AppLoader(
        isLoading: true,
      );
    });
  }




  _getVillageId(bool isLoad) async {
    _dataHelper.cacheHelper.getVillage().then((value) {
      setState(() {
        print("VillageId>>>>>$value");
        if (widget.arguments?.get('departmentID') != null) {
          var departmentID = widget.arguments?.get('departmentID');
          //_cubit.fetchPostData(departmentID,value);
          _cubit.fetchPostData('3', '3',userID, isLoad);
        }
      });
    });
  }

  _getUserId() async {
    _dataHelper.cacheHelper.getUserInfo().then((value) {
      setState(() {
        userID = value;
        if(!is_View) {
          _cubit.view_posts(_post_id.toString(), userID);
        }
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

  getDataArguments() {
    if (widget.arguments?.get('content') != null) {
      _content = widget.arguments?.get('content');
    }
    if (widget.arguments?.get('like') != null) {
      _like = widget.arguments?.get('like');
    }
    if (widget.arguments?.get('view') != null) {
      _view = widget.arguments?.get('view');
    }
    if (widget.arguments?.get('post_author') != null) {
      _post_author = widget.arguments?.get('post_author');
    }
    if (widget.arguments?.get('post_date') != null) {
      _post_date = widget.arguments?.get('post_date');
    }
    if (widget.arguments?.get('post_id') != null) {
      _post_id = widget.arguments?.get('post_id');
    }
    if (widget.arguments?.get('postImage') != null) {
      _postImage = widget.arguments?.get('postImage');
    }

    if (widget.arguments?.get('is_like') != null) {
      _isLike = widget.arguments?.get('is_like');
    }

    if (widget.arguments?.get('is_view') != null) {
      is_View = widget.arguments?.get('is_view');
      print('is_View$is_View');
    }
 }
}
