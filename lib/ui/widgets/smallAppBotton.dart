import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';

class SmallAppBotton extends StatelessWidget {
  double width,height,borderRadius;
  String title;
  TextStyle textStyle;
  Color boderColor;
  Color color;
  Function onTap;
  SmallAppBotton({this.height,this.width,this.title,this.borderRadius,this.textStyle,this.boderColor,this.color,this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        child:Center(
          child: Text(title,style: textStyle),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!=null?borderRadius:MediaQuery.of(context).size.height*0.03),
            color: color!=null?color:AppColors.whiteColor,
          border: Border.all(
            color: boderColor!=null?boderColor:Colors.transparent
          )
        ),
      ),
      onTap: onTap,
    );
  }
}
