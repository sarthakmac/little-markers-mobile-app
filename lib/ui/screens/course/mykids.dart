import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/viewModel/kidViewModel.dart';
import 'package:turing_academy/ui/screens/course/addKid.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/course/viewkidWidget.dart';
import 'package:turing_academy/ui/widgets/courseAppBar.dart';
import 'package:turing_academy/ui/widgets/productItem.dart';

class MyKids extends StatefulWidget {
  static const String routeName = "my-kids";
  final GlobalKey<ScaffoldState> scaffoldkey;
  MyKids({this.scaffoldkey});
  @override
  _MyKidsState createState() => _MyKidsState();
}

class _MyKidsState extends State<MyKids> {
  ScrollController _scrollController;
  bool lastStatus = true;
  bool _isLoading = false;
  ResponseModel responseModel =
      new ResponseModel(isSUcessfull: null, responseMessage: null);

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

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }


  Color getColor(int index) {
    if (index % 3 == 0) {
      return AppColors.redBottonColor;
    } else if (index % 3 == 1) {
      return AppColors.accentColor;
    } else {
      return AppColors.yellowColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = SizeConfig.screenWidth * .03;
    final verticalPadding = SizeConfig.screenHeight * .01;
     final model = Provider.of<KidViewModel>(context);
    return Column(
      children: <Widget>[
        CourseAppBar(
          isShrink: isShrink,
          title: AppString.myKids,
          scaffoldkey: widget.scaffoldkey,
        ),
        SizedBox(
          height: SizeConfig.screenHeight * .01,
        ),
        Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: AppBotton(
            height: SizeConfig.screenHeight * .06,
            width: SizeConfig.screenWidth,
            borderRadius: SizeConfig.screenHeight * .01,
            color: AppColors.accentColor,
            title: AppString.addkids,
            iconWidget: SizedBox(
              height: SizeConfig.screenHeight * .03,
              child: Image.asset(
                AssetsStrings.mykids,
                color: AppColors.whiteColor,
              ),
            ),
            onTap: () {
              //Navigator.of(context).pushNamed(AddKid.routeName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddKid(kid: null, isUpdate: false);
              }));
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * .01,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child:FutureBuilder(future: model.getKids(),builder: (context, AsyncSnapshot<List<KidModel>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(padding: EdgeInsets.all(0),shrinkWrap: true,itemCount: snapshot.data.length,itemBuilder: (BuildContext context,int index){

                return  Padding(
                  padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*.01),
                  child: ViewKidWidget(
                    color: getColor(index),
                    kid:snapshot.data[index],
                  ),
                );

              });

            }else{
              return Container(child:  Center(
                  child:AppConstant.circularInidcator()
              ),);
            }
          }),
        )),
        SizedBox(
          height: SizeConfig.screenHeight * .1,
        ),
      ],
    );
  }
}
