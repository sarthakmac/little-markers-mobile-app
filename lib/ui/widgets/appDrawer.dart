import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appDialog.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/screens/authentication/changePasswordScreen.dart';
import 'package:turing_academy/ui/screens/course/myAddress.dart';
import 'package:turing_academy/ui/screens/course/myProfile.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class AppDrawer extends StatelessWidget {
  int currnetIndex;
  AppDrawer({this.currnetIndex});
  @override
  Widget build(BuildContext context) {
    final sidePading = SizeConfig.screenWidth * .05;
    final model = Provider.of<ProductViewModel>(context);

    Widget _devider() {
      return Row(
        children: <Widget>[
          SizedBox(
            width: SizeConfig.screenWidth * .135,
          ),
          Container(
            height: 1,
            width: SizeConfig.screenWidth * .6,
            color: AppColors.fontGreyColor.withOpacity(.5),
          )
        ],
      );
    }

    Widget getNavRoute({String title, String routeName, String asset,Function secondaryFunction}) {
      return InkWell(
        child: Padding(
          padding: EdgeInsets.only(
              left: sidePading,
              right: sidePading,
              top: SizeConfig.screenHeight * .015,
              bottom: SizeConfig.screenHeight * .015),
          child: Row(
            children: <Widget>[
              Image.asset(
                asset,
                scale: 22,
              ),
              SizedBox(
                width: sidePading * .7,
              ),
              Text(
                title,
                style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: AppConstant.fontSizeSmaller),
              )
            ],
          ),
        ),
        onTap: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          if(secondaryFunction!=null){
            secondaryFunction();
          }
          Navigator.of(context).pushNamed(routeName);
        },
      );
    }

    Widget drawerIcon({String asset, title, int index,Color color}) {
      return InkWell(
        child: Padding(
          padding: EdgeInsets.only(
              left: sidePading,
              right: sidePading,
              top: SizeConfig.screenHeight * .015,
              bottom: SizeConfig.screenHeight * .015),
          child: Row(
            children: <Widget>[
              color!=null?Image.asset(
                asset,
                scale: 22,
                color: color,
              ):Image.asset(
                asset,
                scale: 22,
              ),
              SizedBox(
                width: sidePading * .7,
              ),
              Text(
                title,
                style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: AppConstant.fontSizeSmaller),
              )
            ],
          ),
        ),
        onTap: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          if(index!=10){
            model.changeIndex(index);
            Provider.of<ProductViewModel>(context, listen: false).changeHomeIndex(0);
          }else{
            AppDilog().logOut(context, (){
              Prefs.logOut();

            },currnetIndex);
//
          }
        },
      );
    }

    return Container(
      width: SizeConfig.screenWidth * .735,
      child: Drawer(
        child: ScreenBackGround(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: sidePading, right: sidePading),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context)
                            .pushNamed(MyProfile.routeName);
                      },
                      child: Container(
                        height: SizeConfig.screenHeight*.05,
                        width: SizeConfig.screenHeight*.05,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(AppUrl.storageAddress+loggedInUser.userImage),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.fontGreyColor,
                                blurRadius: 6.0,
                                spreadRadius: 0.5)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sidePading,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${loggedInUser.firstname} ${loggedInUser.lastname}",
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.normalheadingTextStyle,
                          ),
                          Text(loggedInUser.email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.redBottonColor,
                                  fontSize: AppConstant.fontSizeSmaller))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * .02,
              ),
              _devider(),
              drawerIcon(asset: AssetsStrings.menuHome, title: AppString.home, index: 0),
              _devider(),
              drawerIcon(asset: AssetsStrings.mykids, title: AppString.myKids,index: 1),
              _devider(),
              drawerIcon(asset: AssetsStrings.courseBottomIcon, title: AppString.course, index: 2),
              _devider(),
               getNavRoute(
                  title: AppString.product,
                  routeName: HomeScreen.routeName,
                  asset: AssetsStrings.productBottomIcon,
                  secondaryFunction: (){
                    model.changeHomeIndex(1);

                  }),
              // drawerIcon(asset: AssetsStrings.productBottomIcon, title: AppString.product, index: 3),
              _devider(),
              drawerIcon(
                  asset: AssetsStrings.menuActiveService,title:  AppString.activeService, index: 4),
              _devider(),
//              getNavRoute(
//                  title: "My Results",
//                  routeName: MyResult.routeName,
//                  asset: AssetsStrings.myResult),
//              _devider(),
              drawerIcon(asset: AssetsStrings.orderHistory, title: AppString.orderHistory, index: 5),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.screenWidth * .135,
                  ),
                  Container(
                    height: 1,
                    width: SizeConfig.screenWidth * .6,
                    color: AppColors.fontGreyColor,
                  )
                ],
              ),
              drawerIcon(
                  asset: AssetsStrings.notificationBarIcon, title: AppString.notification, index: 6),
              _devider(),
              getNavRoute(
                  title: AppString.changePassword,
                  routeName: ChangePassword.routeName,
                  asset: AssetsStrings.menuProfile),
              _devider(),
              drawerIcon(asset: AssetsStrings.wishlist, title: AppString.wishList, index: 8,color: AppColors.redBottonColor),
              _devider(),
              getNavRoute(
                title: AppString.myAddress,
                routeName: MyAddress.routeName,
                asset: AssetsStrings.menuAddress
              ),
//              drawerIcon(asset: AssetsStrings.menuAddress,title:  AppString.myAddress, index: 9),
              _devider(),
              drawerIcon(asset: AssetsStrings.menuLogOut, title: AppString.logOut, index: 10),
              _devider(),
            ],
          ),
        ),
      ),
    );
  }
}
