import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/sizeConfig.dart';

class SocialLogInRow extends StatelessWidget {
  Function selectFacebook,selectGoogle;
  SocialLogInRow({this.selectFacebook,this.selectGoogle});
  @override
  Widget build(BuildContext context) {
    return Container();
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width*.38,
            height: SizeConfig.screenHeight*.05,
            child: Center(child: RichText(text: TextSpan(
                text: "f  ",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.accentColor,fontSize: AppConstant.fontSizeSmall),
                children: [
                  TextSpan(
                      text: "Facebook",style: TextStyle(fontWeight: FontWeight.w400,color: AppColors.accentColor,fontSize: AppConstant.fontSizeSmall)
                  )
                ]
            )
            ),
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(5.0),

            ),
          ),
          onTap: selectFacebook,
        ),
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width*.38,
            height:SizeConfig.screenHeight*.05,
            child: Center(child: RichText(text: TextSpan(
                text: "G  ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent,fontSize: AppConstant.fontSizeSmall),
                children: [
                  TextSpan(
                      text: "Google",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.redAccent,fontSize: AppConstant.fontSizeSmall)
                  )
                ]
            )
            ),
            ),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(5.0),

            ),
          ),
          onTap: selectGoogle,
        ),
      ],
    );
  }
}
