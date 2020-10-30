import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/core/model/textReport.dart';
import 'package:turing_academy/core/viewModel/resultViewModel.dart';
import 'package:turing_academy/ui/widgets/reviewWidget.dart';

class ReviewScreen extends StatefulWidget {
  String subscriptionId;
  ReviewScreen({this.subscriptionId});
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final model=Provider.of<ResultViewModel>(context);
    return FutureBuilder(
      future: model.getResulText(widget.subscriptionId),
    builder: (BuildContext context,AsyncSnapshot<List<TextReport>>snapshot){
      if(snapshot.hasData){
        if(snapshot.data.length==0){
          return Container(
            child: Center(child: Text('No data found',style: TextStyle(color: AppColors.blackBackgroundColor),)),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ReviewWidget(textReport: snapshot.data[index],),
              );
            });
      }else{
        return AppConstant.circularInidcator();
      }
    });
  }
}
