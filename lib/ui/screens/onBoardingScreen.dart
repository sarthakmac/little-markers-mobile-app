import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/ui/screens/loginScreen.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/OnBoardingScreen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  Widget _buildImage(String assetName) {
    return Center(child: Image.asset("assets/$assetName.png", height: 2000.0,
    filterQuality: FilterQuality.high,fit: BoxFit.contain,));

      SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Image.asset('assets/$assetName.png',fit: BoxFit.cover,),
//      alignment: Alignment.bottomCenter,
    );
  }

  Widget _buildTitle(String title) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: AppStyles.headingBigTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
//        Text(
//          AppString.inTurningAcamdemy,
//          style: AppStyles.smallRedTextStyle,
//        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
        fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w700);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(39, 29, 110, 1)),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.all(20),
    );

    SizeConfig.init(context);
    return Scaffold(
      body: ScreenBackGround(
        child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: IntroductionScreen(
              key: introKey,
              pages: [
                PageViewModel(
                  titleWidget: Column(
                    children: <Widget>[
                      _buildTitle(AppString.firstSlidHeader),
                    ],
                  ),
                  body:
                      AppString.firstSlidContent,
                  image: _buildImage('tutorials_1'),
                  footer: AppBotton(
                    title: AppString.nextSlide,
                    width: SizeConfig.screenWidth * 0.4,
                    height: 40,
                    borderRadius: 20,
                    
                    onTap: () {

                      introKey.currentState?.animateScroll(1);
//                      Prefs.setFirstTime();
//                      Navigator.of(context)
//                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  titleWidget: _buildTitle(AppString.secondSlidheader),
                  body: AppString.secondSlidContent,
                  image: _buildImage('tutorials_2'),
                  footer: AppBotton(
                    title: AppString.nextSlide,
                    width: SizeConfig.screenWidth * 0.4,
                    height: 40,
                    borderRadius: 20,
                    onTap: () {
                      introKey.currentState?.animateScroll(2);
//                      Prefs.setFirstTime();
//                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  titleWidget: _buildTitle(AppString.thirdheader),
                  body:
                      AppString.thirdSlidContent,
                  image: _buildImage('tutorials_3'),
                  footer: AppBotton(
                    title: AppString.nextSlide,
                    width: SizeConfig.screenWidth * 0.4,
                    height: 40,
                    borderRadius: 20,
                    onTap: () {
                      introKey.currentState?.animateScroll(3);
//                      Prefs.setFirstTime();
//                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  titleWidget: _buildTitle(AppString.fouthSlidHeader),
                  body:
                    AppString.fouthSlidContent,
                    image: _buildImage('tutorials_4',),
                    footer: AppBotton(
                      title: AppString.getStarted,
                      width: SizeConfig.screenWidth * 0.4,
                      height: 40,
                    borderRadius: 20,
                    onTap: () {
                      Prefs.setFirstTime();
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                  decoration: pageDecoration,
                ),
              ],
              onDone: () => _onIntroEnd(context),
              //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
              showSkipButton: false,
              skipFlex: 0,
              nextFlex: 0,
              skip: const Text(''),
              next: const Text(""),
              done: const Text(''),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color.fromRGBO(39, 29, 110, 1),
                activeSize: Size(22.0, 10.0),
                activeColor: Color.fromRGBO(251, 81, 85, 1),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            )),
      ),
    );
  }
}
