
import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/changePasswordCredential.dart';
import 'package:turing_academy/core/model/SendApi/otpCredential.dart';
import 'package:turing_academy/core/model/SendApi/profile_otp_credential.dart';
import 'package:turing_academy/core/model/SendApi/updateAddressCredential.dart';
import 'package:turing_academy/core/model/SendApi/updateProfileCredential.dart';
import 'package:turing_academy/core/model/SendApi/userImageCredential.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/model/userAddressModel.dart';
import 'package:turing_academy/core/services/kidApi.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/services/userAPi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/userProvider.dart';
UserAddressModel userAddress;
GetIt getIt = GetIt.instance;



class UserViewModel extends BaseModel {
  UserApi _api = getIt<UserApi>();


  Future<ResponseMessage> updateProfile(UpdateProfileCredential updateProfileCredential)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage=await _api.updateUserApi(updateProfileCredential);
    loggedInUser=await _api.getUserDetailsApi();
    setState(ViewState.IDLE);
    return responseMessage;
  }

  Future<ResponseMessage>updateUserbillingAddress(UpdateAddressCredential updateAddressCredential)async{
    setState(ViewState.BUSY);

    ResponseMessage responseMessage=await _api.updateUserBillingAddressApi(updateAddressCredential);
    setState(ViewState.IDLE);

    return responseMessage;


  }
  Future<ResponseMessage>updateUserShippingAddress(UpdateAddressCredential updateAddressCredential)async{
    setState(ViewState.BUSY);

    ResponseMessage responseMessage=await _api.updateUserShippingAddressApi(updateAddressCredential);
    setState(ViewState.IDLE);

    return responseMessage;


  }
  Future<UserAddressModel>getUserAddress()async{

    userAddress=await _api.getUserAddressApi();

    return userAddress;

  }

  Future<ResponseMessage>updateUserImage(UserImageCredential userImageCredential)async{
    setState(ViewState.BUSY);




    ResponseMessage responseMessage=await _api.updateUserImageApi(userImageCredential);

    print('object${responseMessage.msg}');
    loggedInUser=await _api.getUserDetailsApi();
    setState(ViewState.IDLE);
    return responseMessage;


  }
  Future<ResponseMessage>changePassword(ChangePasswordCredentail changePasswordCredentail)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage =await _api.changePasswordApi(changePasswordCredentail);
    setState(ViewState.IDLE);
    return responseMessage;
  }
  Future<ResponseMessage>sendOtp(OtpCredential otpCredential)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage =await _api.sendOtpApi(otpCredential);
    setState(ViewState.IDLE);
    return responseMessage;
  }
  Future<ResponseMessage>sendProfileOtp(ProfileOtpCredential otpCredential)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage =await _api.sendProfileOtpApi(otpCredential);
    setState(ViewState.IDLE);
    return responseMessage;
  }
  Future<ResponseMessage>verifyOtp(OtpCredential otpCredential)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage =await _api.verifyOtpApi(otpCredential);
    setState(ViewState.IDLE);
    return responseMessage;
  }
  Future<ResponseMessage>profileVerifyOtp(ProfileOtpCredential otpCredential)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage =await _api.profileVerifyOtpApi(otpCredential);
    setState(ViewState.IDLE);
    return responseMessage;
  }
  Future<ResponseModel>loginverifyOtp(OtpCredential otpCredential)async{
    setState(ViewState.BUSY);
    ResponseModel responseModel =await _api.loginVerifyOtpApi(otpCredential);
    setState(ViewState.IDLE);
    return responseModel;
  }
}
