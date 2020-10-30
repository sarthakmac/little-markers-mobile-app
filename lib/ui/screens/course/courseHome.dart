import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/ui/screens/subscription/activeSubcription.dart';
import 'package:turing_academy/ui/screens/authentication/changePasswordScreen.dart';
import 'package:turing_academy/ui/screens/course/coursehomeView.dart';
import 'package:turing_academy/ui/screens/course/myAddress.dart';
import 'package:turing_academy/ui/screens/course/myProfile.dart';
import 'package:turing_academy/ui/screens/course/mykids.dart';
import 'package:turing_academy/ui/screens/course/notificationScreen.dart';
import 'package:turing_academy/ui/screens/course/orderHistory.dart';
import 'package:turing_academy/ui/screens/wishlist/wishlistScreen.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class CourseHome extends StatefulWidget {
  static const String routeName = '/home';
  final GlobalKey<ScaffoldState> scaffoldkey ;
  CourseHome({this.scaffoldkey});

  @override
  _CourseHomeState createState() => _CourseHomeState();
}

class _CourseHomeState extends State<CourseHome> {
  Widget body(ProductViewModel model) {
    if (model.currentIndex == 0) {
      return HomeCourseView(scaffoldkey: widget.scaffoldkey,);
    } else if (model.currentIndex == 7) {
      return MyProfile();
    } else if (model.currentIndex == 1) {
      return MyKids(scaffoldkey: widget.scaffoldkey,);
      // } else if (model.currentIndex == 10) {
      //   return AddKid();
    } else if (model.currentIndex == 8) {
      return WishListScreen(scaffoldkey: widget.scaffoldkey,);
    }else if (model.currentIndex == 9) {
      return MyAddress(scaffoldkey: widget.scaffoldkey,);
    }else if (model.currentIndex == 4) {
      return ActiveSubCription(scaffoldkey: widget.scaffoldkey,);
    } else if (model.currentIndex == 5) {
      return OrderHistory(scaffoldkey: widget.scaffoldkey,);
    } else if (model.currentIndex == 6) {
      return NotificationScreen(scaffoldkey: widget.scaffoldkey,);
    } else if (model.currentIndex == 15) {
      return ChangePassword();
    } else {
      return HomeCourseView(scaffoldkey: widget.scaffoldkey,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProductViewModel>(context);

    return Scaffold(body: ScreenBackGround(child: body(model)));
  }
}
