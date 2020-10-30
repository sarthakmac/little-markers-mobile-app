import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/core/model/userModel.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/shippingProvider.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/screens/loginScreen.dart';

class LancherPage extends StatefulWidget {

  @override
  _LancherPageState createState() => _LancherPageState();
}

class _LancherPageState extends State<LancherPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(value: Stream.fromFuture(Prefs.getUser()),
    child:Wrapper() ,);
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ShippingProvider>(context, listen: false)
        .getAllShippingRates();
  }
  @override
  Widget build(BuildContext context) {
    loggedInUser = Provider.of<UserModel>(context);


    if(loggedInUser!=null){
     if(loggedInUser.token!=null){
       return HomeScreen(currentHome: 1,);
     }else{
       return LoginScreen();
     }
    }else{
      return LoginScreen();
    }

  }
}

