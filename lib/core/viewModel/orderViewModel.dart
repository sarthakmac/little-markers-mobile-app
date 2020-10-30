
import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/createOrderCredential.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/services/kidApi.dart';
import 'package:turing_academy/core/services/orderApi.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/models/product.dart';

GetIt getIt = GetIt.instance;

class OrderViewModel extends BaseModel {
  OrderApi _api = getIt<OrderApi>();
  int currentIndex=0;

  List<Order> orders = [];
//  List<ProductModel> get items => List<ProductModel>.from(_items);


  Future<List<Order>> getOrderList() async {
    try{
      return  await _api.getOrderApi();
    }catch(e){
      print(e);
    }


  }


  Future<ResponseMessage>createOrder(CreateOrderCredential createOrderCredential)async{

    return await _api.createOrderApi(createOrderCredential);


  }

  Future<ResponseMessage>clearCart()async{

    return await _api.clearCart();

  }




}
