import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/subscriptionModel.dart';
import 'package:turing_academy/ui/screens/subscription/subProductDetails.dart';

class CourseContainScreen extends StatefulWidget {
  Subscriptions subscriptions;
  static const String routeName = 'courseContain';
  CourseContainScreen({this.subscriptions});


  @override
  _CourseContainScreenState createState() => _CourseContainScreenState();
}

class _CourseContainScreenState extends State<CourseContainScreen> {

  ScrollController _scrollController;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink =>
      _scrollController.hasClients && _scrollController.offset > 5;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    final sidePadding=SizeConfig.screenWidth*.03;
    return Scaffold(
      appBar: AppBar(
//      pinned: true,
        elevation: !isShrink ? 0.0 : 2.0,
        backgroundColor: !isShrink ? Colors.transparent : Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: AppColors.yellowColor,
            child: Image.asset(
              AssetsStrings.backArrow,
              width: 20,
            ),
            padding: EdgeInsets.all(3),
            shape: CircleBorder(),
          ),
        ),
        title: Text(AppString.courseContent, // + _scrollController.offset.toString(),
          style: AppStyles.headingTextStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.only(
          left: sidePadding,right: sidePadding,
          top:  SizeConfig.screenHeight*.01
        ),
        child: ListView.builder(itemCount: widget.subscriptions.product.subProducts.length,itemBuilder: (BuildContext context,int index){
          return Padding(
            padding: EdgeInsets.only(
                bottom: SizeConfig.screenHeight*.01
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(SubProductDetailScreen.routeName,arguments: widget.subscriptions.product.subProducts[index]);
              },
              child: Container(
                child: ListTile(
                  title: Text(widget.subscriptions.product.subProducts[index].name,style:  AppStyles.titleTextStyle,),
                  subtitle: Text(widget.subscriptions.product.subProducts[index].shortDesc,style: AppStyles.smallerGrayTextStyle),
                ),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(SizeConfig.screenWidth*.03),
                    boxShadow: [BoxShadow(
                      color: Colors.black12.withOpacity(.2),
                      blurRadius: 5.0,
                    ),]
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
