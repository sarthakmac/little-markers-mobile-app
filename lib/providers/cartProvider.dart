import 'package:flutter/material.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/cartModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/shippingProvider.dart';

List<CartModel> currentCartList;

class CartProvider with ChangeNotifier {
  double _totalPrice = 0;
  double get totalPrice {
    return _totalPrice;
  }

  double _totalPhysicalPrice = 0;
  double get totalPhysicalPrice {
    return _totalPhysicalPrice;
  }

  double getTax(CartItem cartItem) {
    double tax = 0;
    cartItem.cartCollection.forEach((ct) {
      tax += (double.parse(ct.taxClass.taxPercentage) / 100) *
          (double.parse(ct.product.price));
    });
    return tax;
  }

  double getTotalShippingRate(CartItem cartItem) {
    double totalShippingRate = 0;
    cartItem.cartCollection.forEach((ct) {
      totalShippingRate =
          totalShippingRate + getItemShippingRate(ct.product.id);
    });
    return totalShippingRate;
  }

  double getItemShippingRate(int productId) {
    final shippingRate = shippingListModel.firstWhere(
        (sh) => sh.id == productId && sh.status == "active",
        orElse: () => null);
    if (shippingRate == null) {
      return 0.0;
    }
    return double.parse(shippingRate.shipping_cost);
  }

  int getPhysicalProduct(CartItem cartItem) {
    int physicalCount = 0;
    final allPhysical = cartItem.cartCollection
        .where((p) => p.product.type.toLowerCase() == "physical")
        .toList();
    if (allPhysical != null) {
      allPhysical.forEach((pr) {
        physicalCount += int.parse(pr.quantity);
      });
    }
    return physicalCount;
  }

  int getVirtualProduct(CartItem cartItem) {
    int virtualCount = 0;
    final allVirtual = cartItem.cartCollection
        .where((p) => p.product.type.toLowerCase() == "virtual")
        .toList();
    if (allVirtual != null) {
      allVirtual.forEach((pr) {
        virtualCount +=int.parse( pr.quantity);
      });
    }
    return virtualCount;
  }

  double getTotalPhyicalPrice(CartItem cartItem) {
    double productsPrice = 0;
    final allproducts = cartItem.cartCollection
        .where((p) => p.product.type.toLowerCase() == "physical")
        .toList();
    if (allproducts != null) {
      allproducts.forEach((pr) {
        productsPrice += double.parse(pr.product.price);
      });
    }
    return productsPrice;
  }

  double getTotalVirtualPrice(CartItem cartItem) {
    double productsPrice = 0;
    final allproducts = cartItem.cartCollection
        .where((p) => p.product.type.toLowerCase() == "virtual")
        .toList();
    if (allproducts != null) {
      allproducts.forEach((pr) {
        productsPrice += double.parse(pr.product.price);
      });
    }
    return productsPrice;
  }

  addItemtoCart(bool isFromCartList, ProductModel product) {
    currentCartList = currentCartList != null ? currentCartList : [];
    var cartItem = currentCartList
        .firstWhere((ct) => ct.product.id == product.id, orElse: () => null);
    if (cartItem != null) {
      int cartIndex = currentCartList.indexOf(cartItem);
      cartItem.quantity = isFromCartList ? cartItem.quantity + 1 : 1;
      currentCartList[cartIndex] = cartItem;
    } else {
      CartModel cartModel = new CartModel();
      cartModel.product = product;
      cartModel.quantity = 1;
      currentCartList.add(cartModel);
    }
    caluclatetotal();
    notifyListeners();
  }

  removeItemFromCart(ProductModel product) {
    currentCartList = currentCartList != null ? currentCartList : [];
    var cartItem = currentCartList
        .firstWhere((ct) => ct.product.id == product.id, orElse: () => null);
    if (cartItem != null) {
      int cartIndex = currentCartList.indexOf(cartItem);
      cartItem.quantity = cartItem.quantity - 1;
      if (cartItem.quantity == 0) {
        currentCartList.remove(cartItem);
      } else {
        currentCartList[cartIndex] = cartItem;
      }
    }
    caluclatetotal();
    notifyListeners();
  }

  caluclatetotal() {
    _totalPrice = 0;
    if (currentCartList.length == 0) return 0;
    currentCartList.forEach((cartItem) {
      _totalPrice += cartItem.quantity * double.parse(cartItem.product.price);
    });
  }
}
