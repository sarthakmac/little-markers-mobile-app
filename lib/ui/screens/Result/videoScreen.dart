import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/core/model/textReport.dart';
import 'package:turing_academy/core/viewModel/resultViewModel.dart';
import 'package:turing_academy/ui/widgets/videoWidget.dart';
import 'package:turing_academy/ui/widgets/youtubeVideoWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
class VideoScreen extends StatelessWidget {
  String subcriptionId;
  VideoScreen({this.subcriptionId});
  @override
  Widget build(BuildContext context) {
    final model=Provider.of<ResultViewModel>(context);
    return FutureBuilder(
      future: model.getResultVideo(subcriptionId),
      builder: (BuildContext context,AsyncSnapshot<List<TextReport>>snapshot){
        if(snapshot.hasData){
          if(snapshot.data.length==0){
            return Container(
              child: Center(child: Text('No data found',style: TextStyle(color: AppColors.blackBackgroundColor),)),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child:YourTubeVideoWidget(
                    textReport: snapshot.data[index],
                  ),
//                child: FlutterYoutube.playYoutubeVideoByUrl(
//                    apiKey: "<API_KEY>",
//                    videoUrl: 'https://www.youtube.com/watch?v=7IG5kRFIMZw',
//                    autoPlay: true, //default falase
//                    fullScreen: false //default false
//                ),
                );
              });
        }else{
          return AppConstant.circularInidcator();
        }
      },
    );
  }
}
