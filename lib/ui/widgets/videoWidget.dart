import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidhet extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String videoUrl;

  const VideoPlayerWidhet({Key key, this.videoPlayerController, this.looping,this.videoUrl})
      : super(key: key);
  @override
  _VideoPlayerWidhetState createState() => _VideoPlayerWidhetState();
}

class _VideoPlayerWidhetState extends State<VideoPlayerWidhet> {
  ChewieController _chewieController;
  Future<void> _initializeVideoPlayerFuture;
//  VideoPlayerController _videoPlayerController1;
  @override
  void initState() {
//    _videoPlayerController1 = VideoPlayerController.network(
//        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
//    _chewieController = ChewieController(
//      videoPlayerController: widget.videoPlayerController,
//      aspectRatio: 16 / 9,
//      // Prepare the video to be played and display the first frame
//      autoInitialize: true,
//      looping: widget.looping,
//      // Errors can occur for example when trying to play a video
//      // from a non-existent URL
//      errorBuilder: (context, errorMessage) {
//        print(errorMessage);
//        return Center(
//          child: Text(
//            errorMessage,
//            style: TextStyle(color: Colors.white),
//          ),
//        );
//      },
//    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Chewie(
            controller: _chewieController,
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
                    "Video Title Here",
                    style: AppStyles.normalheadingTextStyle,
                  ),
                  Text(
                    "20 March, 2020",
                    style: AppStyles.smallerRedTextStyle,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(SizeConfig.screenWidth * .03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(.2),
              blurRadius: 2.0,
            ),
          ]),
    );
  }
}
