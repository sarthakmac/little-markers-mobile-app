import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/ui/screens/loginScreen.dart';

class AppDilog{
   Future<bool> onBackPressed(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(AppString.realyWantToexits),
              actions: <Widget>[
                FlatButton(onPressed: () => Navigator.pop(context, false),
                    child: Text(AppString.no)),
                FlatButton(onPressed: () {

                  exit(0);
                },
                    child: Text(AppString.yes))
              ],
            ));
  }
   Future<bool> logOut(BuildContext context,Function clickFunction,int homeIndex) {
     return showDialog(
         context: context,
         builder: (context) =>
             AlertDialog(
               title: Text(AppString.realyWantTLogout),
               actions: <Widget>[
                 FlatButton(onPressed: () => Navigator.pop(context, false),
                     child: Text(AppString.no)),
                 FlatButton(onPressed: () {

                  clickFunction();
                  Navigator.pop(context);
                  Prefs.setCurrentIndex(homeIndex);
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
//                  Navigator.pop(context);

                 },
                     child: Text(AppString.yes))
               ],
             ));
   }
   static Future pickImageDialog({context,
     Function onChange}) {
     showDialog(context: context, child: Dialog(
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: <Widget>[


           Container(
             child: Column(
               children: <Widget>[
                 MaterialButton(
                   child: Container(width: MediaQuery
                       .of(context)
                       .size
                       .width, child: Center(child: Text("Camera"))),
                   onPressed: () async {
                     if(Navigator.canPop(context)){
                       Navigator.pop(context);
                     }
                     final picker = ImagePicker();
                     final image=await picker.getImage(source: ImageSource.camera);
                     if(image!=null){
                       File croppedFile = await ImageCropper.cropImage(
                           sourcePath: image.path,
                           aspectRatioPresets: Platform.isAndroid
                               ? [
                             CropAspectRatioPreset.square,
                             CropAspectRatioPreset.ratio3x2,
                             CropAspectRatioPreset.original,
                             CropAspectRatioPreset.ratio4x3,
                             CropAspectRatioPreset.ratio16x9
                           ]
                               : [
                             CropAspectRatioPreset.original,
                             CropAspectRatioPreset.square,
                             CropAspectRatioPreset.ratio3x2,
                             CropAspectRatioPreset.ratio4x3,
                             CropAspectRatioPreset.ratio5x3,
                             CropAspectRatioPreset.ratio5x4,
                             CropAspectRatioPreset.ratio7x5,
                             CropAspectRatioPreset.ratio16x9
                           ],
                           androidUiSettings: AndroidUiSettings(
                               toolbarTitle: 'Cropper',
                               toolbarColor: Colors.deepOrange,
                               toolbarWidgetColor: Colors.white,
                               initAspectRatio: CropAspectRatioPreset.original,
                               lockAspectRatio: false),
                           iosUiSettings: IOSUiSettings(
                             title: 'Cropper',
                           ));
                       onChange(croppedFile);
                     }


                   },
                 ),
                 MaterialButton(
                   child: Container(width: MediaQuery
                       .of(context)
                       .size
                       .width,
                       child: Center(child: Text("Gallery"))),
                   onPressed: () async {
                     if(Navigator.canPop(context)){
                       Navigator.pop(context);
                     }
                     final picker = ImagePicker();
                     final image=await picker.getImage(source: ImageSource.gallery);
                     if(image!=null){
                       File croppedFile = await ImageCropper.cropImage(
                           sourcePath: image.path,
                           aspectRatioPresets: Platform.isAndroid
                               ? [
                             CropAspectRatioPreset.square,
                             CropAspectRatioPreset.ratio3x2,
                             CropAspectRatioPreset.original,
                             CropAspectRatioPreset.ratio4x3,
                             CropAspectRatioPreset.ratio16x9
                           ]
                               : [
                             CropAspectRatioPreset.original,
                             CropAspectRatioPreset.square,
                             CropAspectRatioPreset.ratio3x2,
                             CropAspectRatioPreset.ratio4x3,
                             CropAspectRatioPreset.ratio5x3,
                             CropAspectRatioPreset.ratio5x4,
                             CropAspectRatioPreset.ratio7x5,
                             CropAspectRatioPreset.ratio16x9
                           ],
                           androidUiSettings: AndroidUiSettings(
                               toolbarTitle: 'Cropper',
                               toolbarColor: Colors.deepOrange,
                               toolbarWidgetColor: Colors.white,
                               initAspectRatio: CropAspectRatioPreset.original,
                               lockAspectRatio: false),
                           iosUiSettings: IOSUiSettings(
                             title: 'Cropper',
                           ));
                       onChange(croppedFile);
                     }


                   },
                 )
               ],
             ),
           )

         ],
       ),

     ));
   }
}