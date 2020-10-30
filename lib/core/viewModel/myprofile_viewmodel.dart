
import 'package:flutter/cupertino.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/userImageCredential.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/services/userAPi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/providers/authProvider.dart';

import '../get_it.dart';

class MyProfileViewModel extends BaseModel{

  UserApi _api = getIt<UserApi>();

  void updateUserImage(UserImageCredential userImageCredential,BuildContext context)async{
    setState(ViewState.BUSY);




    ResponseMessage responseMessage=await _api.updateUserImageApi(userImageCredential);


    if(responseMessage.statuscode==1){
          loggedInUser=await _api.getUserDetailsApi();
          Prefs.setUserProfile(loggedInUser);
          print('object${loggedInUser.userImage}');
      AppConstant.showSuccessDialogue(responseMessage.msg, context);


    }else{

      AppConstant.showFialureDialogue(responseMessage.msg, context);

    }
    setState(ViewState.IDLE);


  }

}