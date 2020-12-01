import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turing_academy/ui/screens/authentication/changePasswordScreen.dart';
import 'package:turing_academy/ui/screens/authentication/signInwithOtp.dart';
import 'package:turing_academy/ui/screens/course/enter_profile_otp_screen.dart';
import 'package:turing_academy/ui/screens/course/myAddress.dart';
import 'package:turing_academy/ui/screens/course/timeline.dart';
import 'package:turing_academy/ui/screens/course/mykids.dart';
import 'package:turing_academy/ui/screens/enterOtp.dart';
import 'package:turing_academy/ui/screens/loginScreen.dart';
import 'package:turing_academy/ui/screens/onBoardingScreen.dart';
import 'package:turing_academy/ui/screens/otpOnMessageScreen.dart';
import 'package:turing_academy/ui/screens/payment/addNewCard.dart';
import 'package:turing_academy/ui/screens/payment/cartSCreen.dart';
import 'package:turing_academy/ui/screens/payment/paymentScreen.dart';
import 'package:turing_academy/ui/screens/registrationScreen.dart';
import 'package:turing_academy/ui/screens/subscription/courseContainScreen.dart';
import 'package:turing_academy/ui/screens/subscription/subProductDetails.dart';
import 'package:turing_academy/ui/screens/wishlist/wishlistScreen.dart';
import 'package:turing_academy/ui/widgets/add_shipping_address_screen.dart';
import 'screens/course/addKid.dart';
import 'screens/homeScreen.dart';
import 'package:turing_academy/ui/screens/course/myProfile.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      //AddKid

      case AddKid.routeName:
        return PageTransition(
          child: AddKid(kid: settings.arguments,),
          type: PageTransitionType.fade,
          settings: settings,
        );

      // case MyKids.routeName:
      //   return PageTransition(
      //     child: MyKids(),
      //     type: PageTransitionType.fade,
      //     settings: settings,
      //   );

      case OnBoardingScreen.routeName:
        return PageTransition(
          child: OnBoardingScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case MyResult.routeName:
        return PageTransition(
          child: MyResult(subscriptionId: settings.arguments,),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case LoginScreen.routeName:
        return PageTransition(
          child: LoginScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case OtpOnMessageScreen.routeName:
        return PageTransition(
            child: OtpOnMessageScreen(),
            type: PageTransitionType.fade,
            settings: settings);
      case SigInWithOtpScreen.routeName:
        return PageTransition(
            child: SigInWithOtpScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case ChangePassword.routeName:
        return PageTransition(
            child: ChangePassword(),
            type: PageTransitionType.fade,
            settings: settings);

      case EnterOtpScreen.routeName:
        return PageTransition(
            child: EnterOtpScreen(otpScreenArguments: settings.arguments,),
            type: PageTransitionType.fade,
            settings: settings);

      case HomeScreen.routeName:
        return PageTransition(
            child: HomeScreen(),
            type: PageTransitionType.fade,
            settings: settings);
      case CartScreen.routeName:
        return PageTransition(
            child: CartScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case PaymentScreen.routeName:
        return PageTransition(
            child: PaymentScreen(cartItem: settings.arguments,),
            type: PageTransitionType.fade,
            settings: settings);

      case AddNewCardScreen.routeName:
        return PageTransition(
            child: AddNewCardScreen(),
            type: PageTransitionType.fade,
            settings: settings);

      case RegistrationScreeen.routeName:
        return PageTransition(
          child: RegistrationScreeen(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case MyProfile.routeName:
        return PageTransition(
          child: MyProfile(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case CourseContainScreen.routeName:
        return PageTransition(
          child: CourseContainScreen(subscriptions: settings.arguments,),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case SubProductDetailScreen.routeName:
        return PageTransition(
          child: SubProductDetailScreen(subProducts: settings.arguments,),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case WishListScreen.routeName:
        return PageTransition(
          child: WishListScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case MyAddress.routeName:
        return PageTransition(
          child: MyAddress(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case AddShippingAddressScreen.routeName:
        return PageTransition(
          child: AddShippingAddressScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case EnterProfileOtpScreen.routeName:
        return PageTransition(
          child: EnterProfileOtpScreen(arguments: settings.arguments,),
          type: PageTransitionType.fade,
          settings: settings,
        );
    }
    return null;
  }
}
