import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appDialog.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/updateProfileCredential.dart';
import 'package:turing_academy/core/model/SendApi/userImageCredential.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';

class ProfileImageWidget extends StatefulWidget {
  String imageUrl;
  double width,height;
  String page;
  Function onpictureChange;
  File imageFile;
  ProfileImageWidget({this.imageFile,this.imageUrl,this.height,this.width,this.onpictureChange});

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: (){
            AppDilog.pickImageDialog(context: context,
            onChange: (val){
             if(val!=null){
               setState(() {
                 widget.imageFile=val;
               });
               widget.onpictureChange(val);

             }
            });
          },
          child: Container(
           width: widget.height,
            height: widget.height,
            child:CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              radius: widget.height,
              backgroundImage:  widget.imageFile!=null?FileImage( widget.imageFile):widget.imageUrl!=null&& widget.imageFile==null?NetworkImage(AppUrl.storageAddress+widget.imageUrl):AssetImage(AssetsStrings.user),
            ),
//        Padding(
//          padding:  EdgeInsets.all(widget.height*.2),
////          child: Center(
////            child:image!=null?Image.file(image):
////            widget.imageUrl!=null&&image==null?Image.network(AppUrl.storageAddress+widget.imageUrl):Image.asset(AssetsStrings.user),
////          ),
//        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.fontGreyColor,
                blurRadius: 6.0,
                spreadRadius: 0.5)
          ],
//
        ),
          ),
        ),
      ],
    );
  }
}
