import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/wishlistItem.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/ui/screens/detailScreen.dart';


class WishListItemView extends StatelessWidget {
  WishlistItem wishListItem;

  WishListItemView({this.wishListItem});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
        margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * .01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.repeated,
            colors: AppColors.turquoiseGradient,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 11, top: 11, right: 11, bottom: 5),
          child: SizedBox.expand(
            child: Column(
              children: [
                Container(
                  child: Column(children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              product: ProductModel(id: wishListItem.product.id, name: wishListItem.product.name, type: wishListItem.product.type,
                                  sku: wishListItem.product.sku, image: wishListItem.product.image, short_desc: wishListItem.product.shortDesc,
                                  long_desc: wishListItem.product.longDesc, price: wishListItem.product.price, created_at: wishListItem.product.createdAt,
                                  updated_at: wishListItem.product.updatedAt, tax_id: wishListItem.product.taxId,
                                  shipping_id: null, status: wishListItem.product.status, sub_products: null, tax_class: null),
                            ),
                          )),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: SizeConfig.screenWidth *
                            (Orientation.portrait ==
                                MediaQuery.of(context).orientation
                                ? .38
                                : .28),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: CachedNetworkImage(
                          imageUrl: AppUrl.storageAddress + wishListItem.product.image,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * .01),
                    Text(
                      wishListItem.product.name,
                      style: AppStyles.productItemTitleStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * .01),
                    Text(
                      FlutterMoneyFormatter(
                          settings: MoneyFormatterSettings(symbol: "₹"),
                          amount: double.parse(wishListItem.product.price))
                          .output
                          .symbolOnLeft,
                      style: AppStyles.productItemPriceStyle,
                    )
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
