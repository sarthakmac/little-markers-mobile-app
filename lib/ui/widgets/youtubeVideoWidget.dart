//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/services.dart';
//import 'package:turing_academy/constants/appColors.dart';
//import 'package:turing_academy/constants/appConstants.dart';
//import 'package:turing_academy/constants/appStyle.dart';
//import 'package:turing_academy/constants/sizeConfig.dart';
//import 'package:turing_academy/core/model/textReport.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
//class YourTubeVideoWidget extends StatefulWidget {
//  TextReport textReport;
//
//  YourTubeVideoWidget({this.textReport});
//  @override
//  _YourTubeVideoWidgetState createState() => _YourTubeVideoWidgetState();
//}
//
//class _YourTubeVideoWidgetState extends State<YourTubeVideoWidget> {
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//  YoutubePlayerController _controller;
//
//
//  PlayerState _playerState;
//  YoutubeMetaData _videoMetaData;
//  double _volume = 100;
//  bool _muted = false;
//  bool _isPlayerReady = false;
//
//
//  @override
//  void initState() {
//    super.initState();
//    _controller = YoutubePlayerController(
//      initialVideoId: YoutubePlayer.convertUrlToId(widget.textReport.videoUrl),
//      flags: YoutubePlayerFlags(
//        mute: false,
//        autoPlay: true,
//        disableDragSeek: false,
//        loop: false,
//        isLive: false,
//        forceHD: false,
//        enableCaption: true,
//      ),
//
//    )..addListener(listener);
//
//    _videoMetaData = YoutubeMetaData();
//    _playerState = PlayerState.unknown;
//  }
//
//  void listener() {
//    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//      setState(() {
//        _playerState = _controller.value.playerState;
//        _videoMetaData = _controller.metadata;
//      });
//    }
//  }
//
//  @override
//  void deactivate() {
//    // Pauses video while navigating to next page.
//    _controller.pause();
//    super.deactivate();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return  Container(
//      margin: const EdgeInsets.only(top: 5, bottom: 5),
//      decoration: BoxDecoration(
//          color: AppColors.whiteColor,
//          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * .03),
//          boxShadow: [
//            BoxShadow(
//              color: Colors.black12.withOpacity(.2),
//              blurRadius: 2.0,
//            ),
//          ]),
//      child: Column(
//        children: <Widget>[
//          YoutubePlayer(
//
//            controller: _controller,
//            showVideoProgressIndicator: true,
//            progressIndicatorColor: Colors.blueAccent,
//
//
//            topActions: <Widget>[
//              SizedBox(width: 8.0),
//              Expanded(
//                child: Text(
//                  _controller.metadata.title,
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 18.0,
//                  ),
//                  overflow: TextOverflow.ellipsis,
//                  maxLines: 1,
//                ),
//              ),
////              IconButton(
////                icon: Icon(
////                  Icons.settings,
////                  color: Colors.white,
////                  size: 25.0,
////                ),
////                onPressed: () {
////
////                },
////              ),
//            ],
//
//            onReady: () {
//              _isPlayerReady = true;
//            },
//            onEnded: (data) {
//            },
//          ),
//          Container(
//            width: SizeConfig.screenWidth * 0.8,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.only(
//                  bottomLeft: Radius.circular(10),
//                  bottomRight: Radius.circular(10)),
//              color: AppColors.whiteColor,
//            ),
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    "${widget.textReport.title}",
//                    style: AppStyles.normalheadingTextStyle,
//                  ),
//                  Text(
//                    "${AppConstant.changeDateformate(widget.textReport.createdAt)}",
//                    style: AppStyles.smallerRedTextStyle,
//                  )
//                ],
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//
//
//
//
//
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/textReport.dart';


class YourTubeVideoWidget extends StatefulWidget {
  TextReport textReport;

  YourTubeVideoWidget({this.textReport});
  @override
  _YourTubeVideoWidgetState createState() => _YourTubeVideoWidgetState();
}

class _YourTubeVideoWidgetState extends State<YourTubeVideoWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  InAppWebViewController webView;


  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;



  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * .03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(.2),
              blurRadius: 2.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight*.3,
            width: SizeConfig.screenWidth,
            child: InAppWebView(
              initialUrl: widget.textReport.videoUrl,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                  )
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {

              },
              onLoadStop: (InAppWebViewController controller, String url) {

              },
            ),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: AppColors.whiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget.textReport.title}",
                    style: AppStyles.normalheadingTextStyle,
                  ),
                  Text(
                    "${AppConstant.changeDateformate(widget.textReport.createdAt)}",
                    style: AppStyles.smallerRedTextStyle,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }






}