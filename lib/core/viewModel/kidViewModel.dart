
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/userAddressModel.dart';
import 'package:turing_academy/core/services/kidApi.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/services/userAPi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';

GetIt getIt = GetIt.instance;

class KidViewModel extends BaseModel {
  UserApi _userApi = getIt<UserApi>();
  KidApi _api = getIt<KidApi>();
  int currentIndex=0;

  List<KidModel> kids = [];
//  List<ProductModel> get items => List<ProductModel>.from(_items);


  Future<List<KidModel>> getKids() async {

    kids = await _api.getkitList();

    return kids;
  }
  Future<ResponseMessage> addKid(KidCredentail kidCredentail)async{
    setState(ViewState.BUSY);
    ResponseMessage msg= await _api.addKidList(kidCredentail);
    kids = await _api.getkitList();

    print('£££££${kids.length}');
    setState(ViewState.IDLE);
    return msg;
  }
  Future<ResponseMessage> updateKidDetails(KidCredentail kidCredentail)async{
    setState(ViewState.BUSY);
    ResponseMessage msg= await _api.updateKid(kidCredentail);
    kids = await _api.getkitList();

    print('£££££${kids.length}');
    setState(ViewState.IDLE);
    return msg;
  }
  Future deleteKid(KidModel kidModel)async{

    ResponseMessage msg= await _api.deleteKid(kidModel);
    setState(ViewState.IDLE);

    return msg;
  }
  Future<ResponseMessage>updateKidImage(String kidId,File image)async{
    setState(ViewState.BUSY);


    ResponseMessage responseMessage=await _api.updateKidImageApi(kidId, image);

    print('object${responseMessage.msg}');
    setState(ViewState.IDLE);
    return responseMessage;


  }


  Future<bool>checkUser()async{
    UserAddressModel userAddress=await _userApi.getUserAddressApi();
    if(userAddress.shipping_address_1!=null&&userAddress.shipping_address_1!=''&&userAddress.shipping_city!=null&&userAddress.shipping_city!=''&&
    userAddress.shipping_state!=null&&userAddress.shipping_state!=''&&userAddress.shipping_zipcode!=null&&userAddress.shipping_zipcode!=''&&
    userAddress.shipping_address_2!=null&&userAddress.shipping_address_2!=''){
      return true;
    }else{
      return false;
    }
  }



}
