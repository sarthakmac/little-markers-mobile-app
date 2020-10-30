
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/core/model/userModel.dart';

import 'model/starterValues.dart';

class Prefs{
  static Future<UserModel> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("id");
    String firstname= preferences.getString('firstname');
    String lastname= preferences.getString('lastname');
    String email= preferences.getString('email');
    String password= preferences.getString('password');
    String phone= preferences.getString('phone');
    String token=preferences.getString('token');
    String image=preferences.getString('image');


    if(id!=null){
      return UserModel(id: int.parse(id), firstname: firstname, lastname: lastname, email: email,
          password: password, phone: phone,token: token,userImage: image);
    }else{
      return UserModel(id: null, token: null, firstname: null, lastname: null, email: null, password: null, phone: null);
    }



  }


  static void setCurrentIndex(int currentIndex) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("currentIndex", currentIndex);
    preferences.commit();
  }
  static Future getCurrentIndex()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int currentIndex=preferences.getInt('currentIndex');
    return currentIndex;
  }

  static void setUserProfile(UserModel userModel) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", userModel.id.toString());
    preferences.setString("firstname", userModel.firstname);
    preferences.setString("lastname", userModel.lastname);
    preferences.setString("email", userModel.email);
    preferences.setString("password", userModel.password);
    preferences.setString("phone", userModel.phone);
    preferences.setString('token', userModel.token);
    preferences.setString('image',userModel.userImage);
    preferences.commit();
  }


  static void logOut() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("phone", null);
    preferences.setString("username", null);
    preferences.setString("firstname", null);
    preferences.setString("lastname", null);
    preferences.setString("email", null);
    preferences.setString("password", null);
    preferences.setString('token', null);
    preferences.setString('image', null);
    preferences.commit();
  }
  static void setFirstTime()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLogin', true);
    preferences.commit();
  }

  static Future<StarterValues>getFirstTime()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool isAvailable=await AppConstant.checkAppStatus();

    return StarterValues(
      isLogin: preferences.getBool('isLogin')??false,
      isAvailable: isAvailable
    );

  }




}