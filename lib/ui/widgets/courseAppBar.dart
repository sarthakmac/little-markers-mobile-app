import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/keys.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/viewModel/homeViewModel.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/screens/payment/cartSCreen.dart';

class CourseAppBar extends StatelessWidget {
  bool isShrink;
  GlobalKey<ScaffoldState> scaffoldkey;

  String title;
  CourseAppBar({@required this.isShrink, this.title,this.scaffoldkey});
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProductViewModel>(context);

    return StreamBuilder(
    stream: model.getStreamCartList(),
        builder:(BuildContext context,AsyncSnapshot<CartItem> snapshot){
      if(snapshot.hasData){
        return AppBar(
//      pinned: true,
          elevation: !isShrink ? 0.0 : 2.0,
          backgroundColor: !isShrink ? Colors.transparent : Colors.white,
          leading: Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * .001,
                  left: SizeConfig.screenWidth * .03,
                  bottom: SizeConfig.screenHeight * .01
                  ),
              child: Container(
                  child: Center(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Image.asset(AssetsStrings.menuIcon),
                        ),
                        onTap: () {
                          scaffoldkey.currentState.openDrawer();
                        },
                      )),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.yellowColor,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.fontGreyColor,
                          blurRadius: 6.0,
                          spreadRadius: 0.5)
                    ],
                  ))),
          title: Text(
            title, // + _scrollController.offset.toString(),
            style: AppStyles.headingTextStyle,
          ),
          centerTitle: true,
          actions: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight * .01,
                        right: SizeConfig.screenWidth * .05,
                        bottom: SizeConfig.screenHeight * .01),
                    child: Container(
                        child: Center(
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Image.asset(AssetsStrings.cartIcon),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(CartScreen.routeName);
                              },
                            )),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.redBottonColor,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.fontGreyColor,
                                blurRadius: 6.0,
                                spreadRadius: 0.5)
                          ],
                        ))),
                snapshot.data.cartCount>0?Positioned(
                  top: 0,right: 10,
                  child: Container(

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(snapshot.data.cartCount.toString(),
                      style: TextStyle(color: AppColors.redBottonColor,
                      fontWeight: FontWeight.bold),),),

                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor
                    ),
                  ),
                ):Container(),
              ],
            )
          ],
        );
      }else{
        return AppBar(
//      pinned: true,
          elevation: !isShrink ? 0.0 : 2.0,
          backgroundColor: !isShrink ? Colors.transparent : Colors.white,
          leading: Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * .01,
                  left: SizeConfig.screenWidth * .05,
                  bottom: SizeConfig.screenHeight * .01),
              child: Container(
                  child: Center(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Image.asset(AssetsStrings.menuIcon),
                        ),
                        onTap: () {
                         scaffoldkey.currentState.openDrawer();
                        },
                      )),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.yellowColor,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.fontGreyColor,
                          blurRadius: 6.0,
                          spreadRadius: 0.5)
                    ],
                  ))),
          title: Text(
            title, // + _scrollController.offset.toString(),
            style: AppStyles.headingTextStyle,
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * .01,
                    right: SizeConfig.screenWidth * .05,
                    bottom: SizeConfig.screenHeight * .01),
                child: Container(
                    child: Center(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(9.0),
                            child: Image.asset(AssetsStrings.cartIcon),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(CartScreen.routeName);
                          },
                        )),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.redBottonColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.fontGreyColor,
                            blurRadius: 6.0,
                            spreadRadius: 0.5)
                      ],
                    )))
          ],
        );
      }

    });
  }
}
