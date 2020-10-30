import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/textReport.dart';
import 'package:turing_academy/core/viewModel/resultViewModel.dart';

class PhotoScreen extends StatelessWidget {
  String subcriptionId;
  PhotoScreen({this.subcriptionId});
  @override
  Widget build(BuildContext context) {
    final model= Provider.of<ResultViewModel>(context);
    return FutureBuilder(
      future: model.getResultImage(subcriptionId),
        builder: (BuildContext context,AsyncSnapshot<List<TextReport>>snapshot){
         if(snapshot.hasData){
           if(snapshot.data.length==0){
             return Container(
               child: Center(child: Text('No data found',style: TextStyle(color: AppColors.blackBackgroundColor),)),
             );
           }
           return GridView.builder(

             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
               mainAxisSpacing: 9.0,
               crossAxisSpacing: 14.0,
               childAspectRatio: 1,
             ),
             itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index) {
               return Container(
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     color: AppColors.whiteColor,
                     image: DecorationImage(
                         image: snapshot.data[index].image!=null?
                         NetworkImage(AppUrl.storageAddress+snapshot.data[index].image):AssetImage("assets/tutorials_1.png"),
                         fit: BoxFit.cover)),
               );
             },
           );
         }else{
           return AppConstant.circularInidcator();
         }
        });
  }
}
