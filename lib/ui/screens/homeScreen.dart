import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appDialog.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/ui/screens/course/courseHome.dart';
import 'package:turing_academy/ui/screens/course/notificationScreen.dart';
import 'package:turing_academy/ui/screens/product/productHome.dart';
import 'package:turing_academy/ui/widgets/appDrawer.dart';
import '../../constants/appColors.dart';
import '../../constants/assetsString.dart';
import '../../constants/sizeConfig.dart';
// GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  int currentHome;
  HomeScreen({this.currentHome:1});


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int currentIndex = 2;

  Widget tabBarIcon(String assetsPath, String title, int index,ProductViewModel model) {

    return Expanded(
      child: InkWell(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * .012,
                bottom: SizeConfig.screenHeight * .012),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.screenHeight * .034,
                  child: Image.asset(
                    assetsPath,color: model.homePageIndex==index?AppColors.green:null,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .01,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: model.homePageIndex==index?AppColors.green:AppColors.whiteColor,
                      fontSize: AppConstant.fontSizeVerySmall),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Provider.of<ProductViewModel>(context, listen: false).changeHomeIndex(index);
          Provider.of<ProductViewModel>(context, listen: false).changeIndex(0);
        },
      ),
    );
  }



  Widget body(ProductViewModel model) {

    if (model.homePageIndex == 0) {
      return CourseHome(scaffoldkey: scaffoldkey,);
    } else if (model.homePageIndex == 1) {
      return ProductHome(scaffoldkey: scaffoldkey,);
    } else {
      return NotificationScreen(scaffoldkey: scaffoldkey,);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.currentHome!=null){
      Provider.of<ProductViewModel>(context,listen: false).homePageIndex=widget.currentHome;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final model = Provider.of<ProductViewModel>(context,);

    return WillPopScope(
      onWillPop:(){
        return AppDilog().onBackPressed(context);
      },
      child: Scaffold(
          key: scaffoldkey,
          drawer: AppDrawer(currnetIndex: model.homePageIndex,),
          body: Stack(
            children: <Widget>[
              body(model),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: SizeConfig.screenHeight * .09,
                  decoration: BoxDecoration(
                      color: AppColors.bottomBarColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: model.currentIndex == 16
                      ? Text("")
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            tabBarIcon(AssetsStrings.courseBottomIcon,
                                AppString.course, 0,model),
                            tabBarIcon(AssetsStrings.productBottomIcon,
                                AppString.product, 1,model),
                            tabBarIcon(AssetsStrings.notificationBarIcon,
                                AppString.notification, 2,model),
                          ],
                        ),
                ),
              ))
            ],
          )),
    );
  }
}
