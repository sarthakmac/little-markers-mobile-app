import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/viewModel/kidViewModel.dart';
import 'package:turing_academy/ui/screens/course/addKid.dart';



String deleteKidMessage='Do you really want to delete kid details';

class ViewKidWidget extends StatefulWidget {
  final Color color;
  final KidModel kid;
  ViewKidWidget({this.color, this.kid});

  @override
  _ViewKidWidgetState createState() => _ViewKidWidgetState();
}

class _ViewKidWidgetState extends State<ViewKidWidget> {
  Widget fieldView(String fieldName, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          fieldName,
          style: AppStyles.mykidFieldNameTextStyle,
        ),
        Text(
          value,
          style: AppStyles.mykidFieldValueTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<KidViewModel>(context);
    return Container(
      width: SizeConfig.screenWidth,
//          height: SizeConfig.screenHeight * .25,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth * .25,
                    height: SizeConfig.screenHeight * .15,
                    decoration: BoxDecoration(
                        color: AppColors.fontGreyColor,
                        image: DecorationImage(
                          image:NetworkImage(AppUrl.storageAddress+widget.kid.image),
                          fit: BoxFit.fill,
                        ),
                        border:
                            Border.all(color: AppColors.whiteColor, width: 3)),
                  ),
                  fieldView(AppString.kidAge, "${widget.kid.age} Years"),
                  SizedBox(
                    height: SizeConfig.screenHeight * .01,
                  ),
                ],
              ),
              SizedBox(
                width: SizeConfig.screenWidth * .6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    fieldView(AppString.kidFullName,
                        "${widget.kid.firstname} ${widget.kid.lastname}"),
                    fieldView(AppString.eduction, "${widget.kid.education}"),
                    fieldView(AppString.schoolName, "${widget.kid.school}"),
                    fieldView(
                        AppString.boardOrUniversityDetails, "${widget.kid.university}"),

                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * .01,
              ),
              Expanded(
                child: OutlineButton(
                  child: Text(AppString.editKid,style: AppStyles.mediumWhiteLightTextStyle),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AddKid(
                        isUpdate: true,
                        kid: widget.kid,
                      );
                    }));
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: AppColors.fontGreyColor,
                  borderSide: BorderSide(color: AppColors.whiteColor
                  ),
                ),

              ),
              SizedBox(
                width: SizeConfig.screenWidth * .01,
              ),
              Expanded(
                child: OutlineButton(
                  child:  Text(AppString.deletekid,style: AppStyles.mediumWhiteLightTextStyle,),
                  onPressed: (){
                    AppConstant.comfirmsDialogue(deleteKidMessage, context,(){
                      model.deleteKid(widget.kid);
                      setState(() {

                      });
                    });
//                              Navigator.of(context).pushNamed(MyResult.routeName,arguments: subscriptions.id.toString());
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: AppColors.whiteColor)),
                  borderSide: BorderSide(color: AppColors.whiteColor
                  ),
                  highlightedBorderColor: AppColors.whiteColor,
                ),
              ),
              SizedBox(
                width: SizeConfig.screenWidth * .01,
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * .005,
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(.2),
              blurRadius: 5.0,
            ),
          ]),
    );
  }
}
