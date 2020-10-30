
import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addProductCartCredential.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/textReport.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/services/resultApi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/models/product.dart';

GetIt getIt = GetIt.instance;

class ResultViewModel extends BaseModel {
  ResultApi _api = getIt<ResultApi>();
  int currentIndex = 0;

  List<TextReport> textResults = [];
  CartItem cartItem = CartItem();

//  List<ProductModel> get items => List<ProductModel>.from(_items);


  Future<List<TextReport>> getResulText(String subcriptionId) async {
    textResults = await _api.getTextResultApi(subcriptionId);

    return textResults;
  }

  Future<List<TextReport>> getResultImage(String subcriptionId) async {

    return await _api.getImageResultApi(subcriptionId);
  }
  Future<List<TextReport>> getResultVideo(String subcriptionId) async {

    return await _api.getVideoResultApi(subcriptionId);
  }
}