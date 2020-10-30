
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:geocoder/geocoder.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/updateAddressCredential.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/services/userAPi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/providers/authProvider.dart';

import '../get_it.dart';

class AddShippingAddressViewModel extends BaseModel{
  UserApi _api = getIt<UserApi>();
  TextEditingController shippingAddress1Controller=TextEditingController();
  TextEditingController shippingAddress2Controller=TextEditingController();
  TextEditingController shippingCityController=TextEditingController();
  TextEditingController shippingStateController=TextEditingController();
  TextEditingController shippingCountryController=TextEditingController();
  TextEditingController shippingZipCodeController=TextEditingController();
  var phoneController = MaskedTextController(mask: '0000000000');


  void onChangeZipCode(val,BuildContext context)async{
    try{
      var addresses = await Geocoder.local.findAddressesFromQuery(val);
      shippingCountryController.text=addresses.first.countryName;
      shippingStateController.text=addresses.first.adminArea;
      shippingCityController.text=addresses.first.subAdminArea;
      setState(ViewState.IDLE);
    }catch(e){
      AppConstant.showFailToast(context, 'invalid zipcode');
      shippingZipCodeController.clear();
      setState(ViewState.IDLE);

      print(e.toString());

    }
  }
  void updateUserShippingAddress(BuildContext context)async{
    setState(ViewState.BUSY);

    ResponseMessage response=await _api.updateUserShippingAddressApi(
      UpdateAddressCredential(
        shipping_address_1: shippingAddress1Controller.text,
        shipping_address_2: shippingAddress2Controller.text,
        shipping_city: shippingCityController.text,
        shipping_country: shippingCountryController.text,
        shipping_phone: phoneController.text,
        shipping_state: shippingStateController.text,
        shipping_zipcode: shippingZipCodeController.text,
        user_id: loggedInUser.id
      )
    );

    if(response.statuscode==1){
      setState(ViewState.IDLE);
      AppConstant.showSuccessToast(context, response.msg);
      Navigator.pop(context);
    }else{
      setState(ViewState.IDLE);
      AppConstant.showFailToast(context, response.msg);
    }




  }


}