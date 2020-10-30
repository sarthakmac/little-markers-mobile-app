
import 'dart:convert';

import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addProductCartCredential.dart';
import 'package:turing_academy/core/model/SendApi/addWishListCredential.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/checkWishlist.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/wishlistItem.dart';
import 'package:turing_academy/core/services/baseApi.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';

class ProductApi extends BaseApi{

Future<dynamic>getProductList(){
  return getRequest(AppUrl.productsAddress, (r) {
    print(r.body);
    return (json.decode(r.body)['products'] as List).map((e) => ProductModel.fromJson(e)).toList();
  });

}
Future<dynamic>getVirtualProductList(){
  return getRequest(AppUrl.virtualProductsAddress, (r) {
    print(r.body);
    return (json.decode(r.body)['products'] as List).map((e) => ProductModel.fromJson(e)).toList();
  });

}
Future<dynamic> addToCartApi(AddProductCartCredentail addProductCartCredentail){
  return postRequest(AppUrl.addToCartAddress, (r) {
    print(r.body);
    final responseError = json.decode(r.body)['error'];
    if (responseError != null) {
      String allErrors = "";
      final error = responseError as Map<String, dynamic>;
      error.forEach((k, v) {
        allErrors += v.toString() + "\n";
      });
      return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
    }else{
      return ResponseMessage(
          msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
      );
    }

  },addProductCartCredentail);
}
Future<dynamic> updateToCartApi(AddProductCartCredentail addProductCartCredentail){
  return postRequest(AppUrl.updateCartItemAddress, (r) {
//    print(r.body);

    final responseError = json.decode(r.body)['error'];
    if (responseError != null) {
      String allErrors = "";
      final error = responseError as Map<String, dynamic>;
      error.forEach((k, v) {
        allErrors += v.toString() + "\n";
      });
      return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
    }else{
      return ResponseMessage(
          msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
      );
    }

  },addProductCartCredentail);
}

Future<CartItem> getCartListApi()async{
  print('loggedInUser.id=${loggedInUser.id}');
  CartItem cartItem=await getRequest(AppUrl.getCartItemsAddress.trim()+loggedInUser.id.toString().trim(), (r) {
    print('loggedInUser.id=${loggedInUser.id}');
    print(r.body);
//    print(AppUrl.getCartItemsAddress+loggedInUser.id.toString());
    try{
      return CartItem.fromJson(json.decode(r.body));
    }catch(e){
      print('error$e');
      return CartItem();
    }

  });
  return cartItem;

}
Future<dynamic>deleteCartItemApi(CartCollection cartCollection){

  return getRequest(AppUrl.deleteCartItemAddress+loggedInUser.id.toString()+'/'+cartCollection.productId.toString(), (r) {
    print(r.body);
    final responseError = json.decode(r.body)['error'];
    if (responseError != null) {
      String allErrors = "";
      final error = responseError as Map<String, dynamic>;
      error.forEach((k, v) {
        allErrors += v.toString() + "\n";
      });
      return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
    }else{
      return ResponseMessage(
          msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
      );
    }

  });

}
Future<dynamic>clearCartItemApi(){

  return getRequest(AppUrl.clearCartAddress+loggedInUser.id.toString(), (r) {
    print(r.body);
    final responseError = json.decode(r.body)['error'];
    if (responseError != null) {
      String allErrors = "";
      final error = responseError as Map<String, dynamic>;
      error.forEach((k, v) {
        allErrors += v.toString() + "\n";
      });
      return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
    }else{
      return ResponseMessage(
          msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
      );
    }

  });

}

Future<dynamic> addToWishListApi(AddWishListCredentail addWishListCredentail){
  return postRequest(AppUrl.addWishListAddress, (r) {
    print(r.body);
    final responseError = json.decode(r.body)['error'];
    if (responseError != null) {
      String allErrors = "";
      final error = responseError as Map<String, dynamic>;
      error.forEach((k, v) {
        allErrors += v.toString() + "\n";
      });
      return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
    }else{
      return ResponseMessage(
          msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
      );
    }

  },addWishListCredentail);
}


Future<dynamic>getWishlistApi(){
  return getRequest(AppUrl.myWishList+loggedInUser.id.toString(), (r) {
    print(r.body);
    return (json.decode(r.body)['wishlist'] as List).map((e) => WishlistItem.fromJson(e)).toList();
  });

}
Future<dynamic>deleteWishListItemApi(AddWishListCredentail addWishListCredentail){

  return postRequest(AppUrl.removeFromWishlistAddress, (r) {
    print(r.body);
    final responseError = json.decode(r.body)['error'];
    if (responseError != null) {
      String allErrors = "";
      final error = responseError as Map<String, dynamic>;
      error.forEach((k, v) {
        allErrors += v.toString() + "\n";
      });
      return ResponseMessage(statuscode: json.decode(r.body)['status'], msg: allErrors);
    }else{
      return ResponseMessage(
          msg: json.decode(r.body)['msg'],statuscode: json.decode(r.body)['status']
      );
    }

  },addWishListCredentail);

}
Future<bool>checkWishListApi(AddWishListCredentail addWishListCredentail)async{

  final bool result=await postRequest(AppUrl.checkwishlist, (r) {
    print(r.body);
    final responseError = json.decode(r.body)['error'];
    if (responseError != null) {
      String allErrors = "";
      final error = responseError as Map<String, dynamic>;
      error.forEach((k, v) {
        allErrors += v.toString() + "\n";
      });
      return false;
    }else{
      return json.decode(r.body)['exist'];
    }

  },addWishListCredentail);

  return result??false;

}
}