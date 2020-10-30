
import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addProductCartCredential.dart';
import 'package:turing_academy/core/model/SendApi/addWishListCredential.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/checkWishlist.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/wishlistItem.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/models/product.dart';

GetIt getIt = GetIt.instance;

class ProductViewModel extends BaseModel {
  ProductApi _api = getIt<ProductApi>();
  int currentIndex=0;
  int homePageIndex=1;

  List<ProductModel> _items = [];
  CartItem cartItem=CartItem();
  List<WishlistItem>wishlistItems=[];
  List<ProductModel> get items => _items;


  void getProducts() async {
   setState(ViewState.BUSY);
    _items = await _api.getProductList();
    setState(ViewState.IDLE);
  }
  void getvirtualProducts() async {
    setState(ViewState.BUSY);
    _items = await _api.getVirtualProductList();
    setState(ViewState.IDLE);
  }

  void changeIndex(int index){
    setState(ViewState.BUSY);
    currentIndex =index;
    setState(ViewState.IDLE);
  }
  void changeHomeIndex(int index){
    setState(ViewState.BUSY);
    homePageIndex =index;
    setState(ViewState.IDLE);
  }
  Future<ResponseMessage> addToCart(AddProductCartCredentail addProductCartCredentail)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage=await _api.addToCartApi(addProductCartCredentail);
    setState(ViewState.IDLE);
    return responseMessage;

  }
  Future<CartItem>getCartList()async{
    try{
      return await _api.getCartListApi();
    }catch(e){
      return await _api.getCartListApi();
    }



  }
  Stream<CartItem>getStreamCartList(){
    final result =_api.getCartListApi();
    return result.asStream();

  }

  Future deleteCartItem(CartCollection cartCollection)async{

    ResponseMessage msg= await _api.deleteCartItemApi(cartCollection);
    notifyListeners();

  }
  Future<ResponseMessage> updateToCart(AddProductCartCredentail addProductCartCredentail)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage=await _api.updateToCartApi(addProductCartCredentail);
    setState(ViewState.IDLE);
    return responseMessage;

  }
  Future<ResponseMessage> clearToCart()async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage=await _api.clearCartItemApi();
    setState(ViewState.IDLE);
    return responseMessage;

  }
  Future<ResponseMessage> addToWishList(AddWishListCredentail addWishListCredentail)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage=await _api.addToWishListApi(addWishListCredentail);
    setState(ViewState.IDLE);
    return responseMessage;

  }
  Future<List<WishlistItem>> getWishList() async {
    setState(ViewState.BUSY);
    wishlistItems = await _api.getWishlistApi();
    setState(ViewState.IDLE);
  }
  Future<List<WishlistItem>> getFutureWishList() async {
    return await _api.getWishlistApi() ;

  }
  Stream<bool>existWishlist(AddWishListCredentail addWishListCredentail){

    final result= _api.checkWishListApi(addWishListCredentail);

    return result.asStream();

  }

  Future<ResponseMessage> removeWishList(AddWishListCredentail addWishListCredentail)async{
    setState(ViewState.BUSY);
    ResponseMessage responseMessage=await _api.deleteWishListItemApi(addWishListCredentail);
    setState(ViewState.IDLE);
    return responseMessage;

  }
}
