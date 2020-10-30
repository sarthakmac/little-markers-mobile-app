import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/ui/screens/Result/photosScreen.dart';
import 'package:turing_academy/ui/screens/Result/reviewScreen.dart';
import 'package:turing_academy/ui/screens/Result/videoScreen.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'package:turing_academy/ui/widgets/smallAppBotton.dart';


class MyResult extends StatefulWidget {
  static const String routeName = 'my-result';
  final String subscriptionId;
  MyResult({this.subscriptionId});

  @override
  _MyResultState createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  ScrollController _scrollController;
  bool showPhotos = false;
  bool showReviews = true;
  bool showVideos = false;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink =>
      _scrollController.hasClients && _scrollController.offset > 5;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Widget getContent() {
    if (showReviews) {
      return Container(
        width: SizeConfig.screenWidth * 0.9,
        height: SizeConfig.screenHeight * 0.75,
        child: ReviewScreen(subscriptionId: widget.subscriptionId,),
      );
    }

    if (showPhotos) {
      return Container(
        width: SizeConfig.screenWidth * 0.9,
        height: SizeConfig.screenHeight * 0.75,
        child: PhotoScreen(subcriptionId: widget.subscriptionId,),
      );
    }

    if (showVideos) {
      return Container(
          height: SizeConfig.screenHeight * 0.7,
          width: SizeConfig.screenWidth * 0.8,
          child: VideoScreen(subcriptionId: widget.subscriptionId,));

      // VideoPlayerWidhet();

    }
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = SizeConfig.screenWidth * .03;

    SizeConfig.init(context);

    return Scaffold(
        appBar: AppBar(
//      pinned: true,
          elevation: !isShrink ? 0.0 : 2.0,
          backgroundColor: !isShrink ? Colors.transparent : Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              color: AppColors.yellowColor,
              child: Image.asset(
                AssetsStrings.backArrow,
                width: 20,
              ),
              padding: EdgeInsets.all(3),
              shape: CircleBorder(),
            ),
          ),
          title: Text(
            AppString.timeline, // + _scrollController.offset.toString(),
            style: AppStyles.headingTextStyle,
          ),
          centerTitle: true,
        ),
//        key: MyResult.scaffoldkey,
        body: Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
            ),
            ScreenBackGround(
                child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: sidePadding * 2,
                      right: sidePadding * 2,
                    ),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.screenHeight * .005),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SmallAppBotton(
                                height: SizeConfig.screenHeight * .05,
                                width: SizeConfig.screenWidth,
                                title: AppString.reviews,
                                textStyle: showReviews
                                    ? AppStyles.smallerWhiteTextStyle
                                    : AppStyles.smallBrownTextStyle,
                                color: showReviews
                                    ? AppColors.brownColor
                                    : AppColors.whiteColor,
                                onTap: () {
                                  setState(() {
                                    showReviews = true;
                                    showPhotos = false;
                                    showVideos = false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * .02,
                            ),
                            Expanded(
                              child: SmallAppBotton(
                                height: SizeConfig.screenHeight * .05,
                                width: SizeConfig.screenWidth,
                                title: AppString.photos,
                                textStyle: showPhotos
                                    ? AppStyles.smallerWhiteTextStyle
                                    : AppStyles.smallBrownTextStyle,
                                color: showPhotos
                                    ? AppColors.brownColor
                                    : AppColors.whiteColor,
                                onTap: () {
                                  setState(() {
                                    showPhotos = true;
                                    showReviews = false;
                                    showVideos = false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * .02,
                            ),
                            Expanded(
                              child: SmallAppBotton(
                                height: SizeConfig.screenHeight * .05,
                                width: SizeConfig.screenWidth,
                                title: AppString.videos,
                                textStyle: showVideos
                                    ? AppStyles.smallerWhiteTextStyle
                                    : AppStyles.smallBrownTextStyle,
                                color: showVideos
                                    ? AppColors.brownColor
                                    : AppColors.whiteColor,
                                onTap: () {
                                  setState(() {
                                    showPhotos = false;
                                    showReviews = false;
                                    showVideos = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.03)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  getContent()
                ],
              ),
            )),
          ],
        ));
  }
}
