import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/get_it.dart';
import 'package:turing_academy/core/model/starterValues.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/services/pushNotification.dart';
import 'package:turing_academy/core/viewModel/homeViewModel.dart';
import 'package:turing_academy/core/viewModel/orderViewModel.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/core/viewModel/resultViewModel.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/cartProvider.dart';
import 'package:turing_academy/providers/kidsProvider.dart';
import 'package:turing_academy/providers/orderProvider.dart';
import 'package:turing_academy/providers/productProvider.dart';
import 'package:turing_academy/providers/shippingProvider.dart';
import 'package:turing_academy/providers/userProvider.dart';
import 'package:turing_academy/ui/routes.dart';
import 'package:turing_academy/ui/screens/authentication/changePasswordScreen.dart';
import 'package:turing_academy/ui/screens/contact_developer_support.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/screens/lancherPage.dart';
import 'package:turing_academy/ui/screens/onBoardingScreen.dart';

import 'core/viewModel/kidViewModel.dart';
import 'core/viewModel/notifcationViewModel.dart';
import 'core/viewModel/subscriptionViewModel.dart';
import 'ui/screens/loginScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  Prefs.getFirstTime().then((value) {
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ProductViewModel()),
          ChangeNotifierProvider.value(value: AuthProvider()),
//        ChangeNotifierProvider.value(value: UserProvider()),
          ChangeNotifierProvider.value(value: CartProvider()),
          ChangeNotifierProvider.value(value: KidsProvider()),
          ChangeNotifierProvider.value(value: OrderProvider()),
          ChangeNotifierProvider.value(value: ShippingProvider()),
          ChangeNotifierProvider.value(value: KidViewModel()),
          ChangeNotifierProvider.value(value: UserViewModel()),
          ChangeNotifierProvider.value(value: OrderViewModel()),
          ChangeNotifierProvider.value(value:ResultViewModel()),
          ChangeNotifierProvider.value(value: SubScriptionViewModel()),
          ChangeNotifierProvider.value(value: NotificationViewModel()),

        ],child:
    MyApp(starterValues: value,)));
  });

}

class MyApp extends StatefulWidget {
  StarterValues starterValues;
  MyApp({this.starterValues});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocalNotification().configLocalNotification();
    PushNotificationsManager().init();

  }
  @override
  Widget build(BuildContext context) {

    if(widget.starterValues.isAvailable){
      return MaterialApp(
        title: AppString.title,
        theme: ThemeData(
            primaryColor: AppColors.accentColor, fontFamily: 'Montserrat'),
        home: widget.starterValues.isLogin?LancherPage():OnBoardingScreen(),
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      );
    }else{
      return MaterialApp(
        title: AppString.title,
        theme: ThemeData(
            primaryColor: AppColors.accentColor, fontFamily: 'Montserrat'),
        home: ContactDeveloperSupport(),
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      );
    }
  }

  void setStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }


}
