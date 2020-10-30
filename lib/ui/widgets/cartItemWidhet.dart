import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addProductCartCredential.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/cartModel.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/cartProvider.dart';
import 'package:turing_academy/ui/screens/detailScreen.dart';

class CartItemWidget extends StatefulWidget {
  final CartCollection cartCollection;

  const CartItemWidget(this.cartCollection);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int _itemCount;

  @override
  void initState() {
    _itemCount =int.parse(widget.cartCollection.quantity);
    super.initState();
  }

  void _incrementItemCount(bool addCount,CartCollection cartCollection) {
    if (addCount) {
      setState(() {
        _itemCount++;
      });
      Provider.of<ProductViewModel>(context, listen: false)
          .updateToCart(AddProductCartCredentail(quantity: _itemCount, user_id: loggedInUser.id,
          product_id: cartCollection.productId));
    } else {
      setState(() {
        if (_itemCount > 1) {
          _itemCount --;
          Provider.of<ProductViewModel>(context, listen: false)
              .updateToCart(AddProductCartCredentail(quantity: _itemCount, user_id: loggedInUser.id,
              product_id: cartCollection.productId));
        }else{
          Provider.of<ProductViewModel>(context, listen: false).deleteCartItem(widget.cartCollection);
        }

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
//      Dismissible(
//      // Specify the direction to swipe and delete
//      direction: DismissDirection.endToStart,
//      key: UniqueKey(),
//      onDismissed: (direction) async{
//        Provider.of<ProductViewModel>(context, listen: false).deleteCartItem(widget.cartCollection);
//
//
//
//      },
      InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  product:ProductModel(id: widget.cartCollection.product.id, name: widget.cartCollection.product.name, type: widget.cartCollection.product.type,
                      sku: widget.cartCollection.product.sku, image: widget.cartCollection.product.image,
                      short_desc: widget.cartCollection.product.shortDesc, long_desc: widget.cartCollection.product.longDesc,
                      price: widget.cartCollection.product.price, created_at: widget.cartCollection.product.createdAt,
                      updated_at: widget.cartCollection.product.updatedAt, tax_id: widget.cartCollection.product.taxId,
                      shipping_id: null, status: widget.cartCollection.product.status,
                      sub_products: null, tax_class: null)
                ),
              ));
        },
        child: FittedBox(
          child:
//        Slidable(
//            actionPane: SlidableDrawerActionPane(),
//            actionExtentRatio: 0.25,
//            secondaryActions: <Widget>[
//              IconSlideAction(
//                caption: 'Delete',
//                foregroundColor: AppColors.redBottonColor,
//                color: Colors.transparent,
//
//                iconWidget:Icon(Icons.delete,color: AppColors.redBottonColor,) ,
//                onTap: () {
//                  Provider.of<ProductViewModel>(context, listen: false).deleteCartItem(widget.cartCollection);
//                },
//              ),
//            ],
////      background: Container(color: Colors.red,child: Center(child: Text("REMOVE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
//          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
//            height: SizeConfig.screenHeight * 0.2,
              width: SizeConfig.screenWidth * 0.8,
              child: Padding(
                padding:  EdgeInsets.only(
                  top: SizeConfig.screenHeight*.01,
                  bottom: SizeConfig.screenHeight*.01,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: AppColors.whiteColor,
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CachedNetworkImage(
                              width: SizeConfig.screenWidth*.2,
                                imageUrl: AppUrl.storageAddress +
                                    widget.cartCollection.product.image,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error))),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth*.33,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.cartCollection.product.name,
                            textAlign: TextAlign.start,
                            style: AppStyles.cartProductTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Type :",
                                style: AppStyles.cartItemLabel,
                              ),
                              Text(
                                widget.cartCollection.product.type,
                                style: AppStyles.cartItemPriceStyle,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Price :",
                                style: AppStyles.cartItemLabel,
                              ),
                              Expanded(
                                child: Text(
                                    FlutterMoneyFormatter(
                                        settings:
                                        MoneyFormatterSettings(symbol: "₹"),
                                        amount: double.parse(widget.cartCollection.product.price.toString()))
                                        .output
                                        .symbolOnLeft,
                                    style: AppStyles.cartItemPriceStyle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.07,
                            height: SizeConfig.screenHeight * 0.04,
                            child: RawMaterialButton(
                              onPressed: () {
                                _incrementItemCount(true,widget.cartCollection);
                              },
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                              fillColor: AppColors.bottomBarColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(5))),
                              elevation: 0.0,
                              child: Icon(
                                Icons.add,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          Container(
                              child: Text(
                                _itemCount.toString(),
                                style: TextStyle(color: AppColors.accentColor),
                              ),
                              color: Colors.blueGrey[50],
                              alignment: Alignment.center,
                              width: SizeConfig.screenWidth * 0.07,
                              height: SizeConfig.screenHeight * 0.04),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.07,
                            height: SizeConfig.screenHeight * 0.04,
                            child: RawMaterialButton(
                                onPressed: () {
                                  _incrementItemCount(false,widget.cartCollection);
                                  //todo update item number
                                },
                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                fillColor: AppColors.bottomBarColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(5))),
                                elevation: 0.0,
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.whiteColor,
                                )),
                          ),
                        ],
                      ),
                    )
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//
//              ],
//                ),
//              )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(SizeConfig.screenWidth * .03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(.2),
                      blurRadius: 5.0,
                    ),
                  ]),
            ),
          ),
//    ),
        ),
      );
  }
}
