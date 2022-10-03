import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getinforme/Model/SettingModel.dart';
import 'package:getinforme/Thems/Responsive.dart';
import 'package:getinforme/feature/Onbording/OnboardingItems.dart';


import '../../utility/colors.dart';
import '../../utility/images.dart';
import '../../utility/sizes.dart';
import '../../utility/spaces.dart';
import '../../utility/strings.dart';

class IntroScreenBody extends StatefulWidget {
  Function onGetstart;
  List<SettingData> settingData;


  IntroScreenBody({Key? key, required this.onGetstart,required this.settingData}) : super(key: key);

  @override
  State<IntroScreenBody> createState() => _IntroScreenBodyState(settingData);
}

class _IntroScreenBodyState extends State<IntroScreenBody> {
  List<SettingData> settingData = [];
  _IntroScreenBodyState( this.settingData);
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    
    return SafeArea(
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ( settingData!=null && settingData.length>0 &&  settingData[0].logo !=null ) ?  Container(
          height: 30.h,
          color: Colors.white,
          child: Center(child: CachedNetworkImage(
            imageUrl: settingData[0].logo!,
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
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),



            ),
        ) : new Container( height: 30.h,),

            ( settingData!=null && settingData.length>0) ?  new Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width,

            color:Colors.white,
              child: Center(child: Center(child:CachedNetworkImage(
                imageUrl: settingData[0].splashScreen!,
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
                errorWidget: (context, url, error) => Icon(Icons.error),
              ))),
            ): new Container( height: 50.h,color: Colors.white,),

            InkWell(
              onTap: (){
                this.widget.onGetstart();
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin:EdgeInsets.all(15) ,
                  alignment: Alignment.bottomRight,
                  width: 100 ,
                  height: 5.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      CommonButtons.Skip,
                      style: textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.TEXT_SIZE_14,
                          color: AppColors.subtitleColor),
                    ),
                  ),
                ),
              ),
            ),




          ],
        )




      ),
    );
  }
}
