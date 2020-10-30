
import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/subscriptionModel.dart';
import 'package:turing_academy/core/services/kidApi.dart';
import 'package:turing_academy/core/services/orderApi.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/services/subsriptionApi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/models/product.dart';

GetIt getIt = GetIt.instance;

class SubScriptionViewModel extends BaseModel {
  SubscriptionApi _api = getIt<SubscriptionApi>();
  int currentIndex=0;

  List<Subscriptions> orders = [];
//  List<ProductModel> get items => List<ProductModel>.from(_items);


  Future<List<Subscriptions>> getSubScriptionList() async {



    return  await _api.getSubcriptionApi();
  }




}
