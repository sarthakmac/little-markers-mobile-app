import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/ui/screens/loginScreen.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';

class TutorialScreen extends StatefulWidget {
  static String tag = 'mysilder';

  TutorialScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

List<Widget> getStoryList(Color primaryColor, BuildContext context) {
  List<Widget> list = new List();
  list.add(getSlider(1, primaryColor, context));
  list.add(getSlider(2, primaryColor, context));
  list.add(getSlider(3, primaryColor, context));
  list.add(getSlider(4, primaryColor, context));
  return list;
}

Widget getSlider(int number, Color primaryColor, BuildContext context) {
  String imageName = number == 1
      ? AssetsStrings.tutorialOne
      : number == 2 ? AssetsStrings.tutorialTwo :number==3? AssetsStrings.tutorialThree:AssetsStrings.totorialFour;

  String text = number == 1
      ? AppString.tutorialOneTitle
      : number == 2
      ? AppString.tutorialTwoTitle
      :number==3? AppString.tutorialThreeTitle:AppString.tutorialFourTitile;
  return new Column(children: <Widget>[
    SizedBox(
      height: SizeConfig.screenHeight*.15,
    ),
    Container(
      height: SizeConfig.screenHeight*.4,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imageName),fit: BoxFit.contain)
      ),
    ),
    SizedBox(height: SizeConfig.screenHeight*.055),
    Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: AppColors.accentColor, fontWeight: FontWeight.w700, fontSize:AppConstant.fontSizeLarge),
    )
  ]);
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    Color primaryColor = Colors.white;
    Color accentColor = Colors.indigo;
    List<Widget> list = getStoryList(primaryColor, context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 240, 244, 1),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: SizeConfig.screenHeight*.3,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsStrings.topBacground),fit: BoxFit.cover)
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.screenHeight*.47,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsStrings.bottomBacground),fit: BoxFit.cover)
                ),
              ),
            ),
          ),
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return list[index];
            },
            itemCount: list.length,
            autoplay: true,
            duration: 500,
            pagination: new SwiperPagination(
                builder: new DotSwiperPaginationBuilder(
                  activeColor: AppColors.redBottonColor, color: accentColor,)),
          ),

          Positioned(
              top: MediaQuery.of(context).size.height*.66,
              right: 0,
              left: 0,

              child: new Column(

                  children: <Widget>[
                    Text(AppString.appName,style: TextStyle(
                      color: AppColors.redBottonColor,fontSize: AppConstant.fontSizeMedium
                    ),),
                    SizedBox(
                      height: SizeConfig.screenHeight*.03,
                    ),
                    Text("Lorem lpsum is simply dummy text of the\n printing and typesetting industry. Lorem \nlpsum is simply dummy text of the\n printing and typesetting",
                        style: TextStyle(color: Colors.grey, fontSize:AppConstant.fontSizeSmall,),textAlign: TextAlign.center,),

                    SizedBox(height: SizeConfig.screenHeight*.04),
                    AppBotton(
                      width: SizeConfig.screenWidth*.5,
                      height: MediaQuery.of(context).size.height*0.06,
                      title: AppString.getStarted,
                      onTap: (){
                        Prefs.setFirstTime();
                        Navigator.of(context).pushNamed(LoginScreen.routeName);

                      },
                    )

                  ]))
        ],
      ),
    );
  }
}
