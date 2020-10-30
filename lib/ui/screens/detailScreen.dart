import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/SendApi/addProductCartCredential.dart';
import 'package:turing_academy/core/model/SendApi/addWishListCredential.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/checkWishlist.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/cartProvider.dart';
import 'package:turing_academy/ui/screens/payment/cartSCreen.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'package:toast/toast.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;

  const DetailScreen({Key key, this.product}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Widget addToCatBotton() {
    return Container(
        width: double.infinity,
        height: 60,
        child: RawMaterialButton(
            onPressed: () {
              Provider.of<ProductViewModel>(context, listen: false)
                  .addToCart(AddProductCartCredentail(quantity: 1, user_id: loggedInUser.id, product_id: widget.product.id)).then((value) {
                    if(value.statuscode==1){
                      showToast(value.msg);
                    }
              });

              //show pop up item added to cart
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            fillColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            elevation: 0.0,
            child:
                Text(AppString.btnAddToCart, style: AppStyles.btnAddToCart)));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final imageContainerHeight = SizeConfig.screenHeight *
        (Orientation.portrait == MediaQuery.of(context).orientation ? .27 : .4);
    final model=Provider.of<ProductViewModel>(context);
    return Scaffold(
        body: Stack(
      children: [
        ScreenBackGround(
            child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 30),
                child: SizedBox(
                    width: SizeConfig.screenWidth,
                    height: imageContainerHeight,
                    child: CachedNetworkImage(
                        imageUrl: AppUrl.storageAddress + widget.product.image,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error)))),
            Stack(children: [
              ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight:
                          SizeConfig.screenHeight - imageContainerHeight),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(
                              color: AppColors.yellowColor,
                              fontSize: AppConstant.fontSizeLarge),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        Text(AppString.lbProductPrice,
                            style: AppStyles.productItemPriceStyle),
                        Text(
                            FlutterMoneyFormatter(
                                    settings:
                                        MoneyFormatterSettings(symbol: "₹"),
                                    amount: double.parse(widget.product.price))
                                .output
                                .symbolOnLeft,
                            style: AppStyles.productItemPriceStyle
                                .copyWith(fontSize: AppConstant.fontSizeLarge)),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        Text(
                            AppString.lblProductSku + ": " + widget.product.sku,
                            style: AppStyles.productItemPriceStyle
                                .copyWith(color: AppColors.redBottonColor)),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        Text(
                          AppString.lnlProductDescription,
                          style: AppStyles.productItemPriceStyle
                              .copyWith(color: AppColors.turquoiseColor),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        Text(
                          widget.product.long_desc,
                          style: AppStyles.mainTextStyle,
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  )),
            ])
          ]),
        )),
        Positioned(
          top: SizeConfig.screenHeight * .03,
          child: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: AppColors.yellowColor,
            child: Image.asset(
              AssetsStrings.backArrow,
              width: 20,
            ),
            padding: EdgeInsets.all(3),
            shape: CircleBorder(),
          ),
        ),
        wishListIcon(
          addWishListCredentail: AddWishListCredentail(user_id: loggedInUser.id, product_id: widget.product.id),
          productViewModel: model
        ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: addToCatBotton(),
        ))
      ],
    ));
  }

  Widget wishListIcon({ProductViewModel productViewModel,AddWishListCredentail addWishListCredentail}){
    return Positioned(
      top: SizeConfig.screenHeight * .03,
      right: 0,
      child: Row(
        children: [
          StreamBuilder(
            initialData: false,
            stream: productViewModel.existWishlist(addWishListCredentail),
            builder: (context,snapshot){
              return MaterialButton(
                onPressed: () {
                  if(!snapshot.data){
                    productViewModel
                        .addToWishList(AddWishListCredentail(user_id: loggedInUser.id, product_id: widget.product.id)).then((value) {
                      if(value.statuscode==1){
                        showToast(value.msg);
                      }
                    });
                  }else{
                    productViewModel.removeWishList(AddWishListCredentail(user_id: loggedInUser.id, product_id: widget.product.id)).then((value) {
                      if(value.statuscode==1){
                        showToast(value.msg);
                      }
                    });

                  }
                },
                color: snapshot.data?AppColors.redBottonColor:AppColors.fontGreyColor,
                child: Image.asset(
                  AssetsStrings.wishlist,
                  width: 20,

                ),
                padding: EdgeInsets.all(3),
                shape: CircleBorder(),
              );
            },
          ),
          StreamBuilder(
            initialData: CartItem(cartCount: 0),
            stream: productViewModel.getStreamCartList(),
            builder: (context,snapshot){
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                child: Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * .01,
                            right: SizeConfig.screenWidth * .02,
                            bottom: SizeConfig.screenHeight * .01),
                        child: Container(
                          height: 40,
                            child: Center(
                                child: InkWell(
                                  child: Padding(
                                    padding: EdgeInsets.all(9.0),
                                    child: Image.asset(AssetsStrings.cartIcon),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(CartScreen.routeName);
                                  },
                                )),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.redBottonColor,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.fontGreyColor,
                                    blurRadius: 6.0,
                                    spreadRadius: 0.5)
                              ],
                            ))),
                    snapshot.data.cartCount>0?Positioned(
                      right: 0,top:0,

                      child: Container(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(child: Text(snapshot.data.cartCount.toString(),
                              style: TextStyle(color: AppColors.redBottonColor,
                                  fontWeight: FontWeight.bold),),),
                          ),

                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor
                        ),
                      ),
                    ):Container(),
                  ],
                ),
              );
            },
          ),
          SizedBox(width: SizeConfig.screenWidth*.03,)
        ],
      ),
    );

  }
}
