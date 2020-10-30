import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/models/product.dart';
import 'package:turing_academy/ui/screens/detailScreen.dart';
import '../../constants/appColors.dart';
import '../../constants/appStyle.dart';
import '../../constants/sizeConfig.dart';

class ProductItem extends StatelessWidget {
  ProductModel product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              product: product,
            ),
          )),
      child: Container(
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
              child: Container(
                child: Column(children: <Widget>[
                  Container(
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
                      imageUrl: AppUrl.storageAddress + product.image,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * .01),
                  Text(
                    product.name,
                    style: AppStyles.productItemTitleStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * .01),
                  Text(
                    FlutterMoneyFormatter(
                            settings: MoneyFormatterSettings(symbol: "₹"),
                            amount: double.parse(product.price))
                        .output
                        .symbolOnLeft,
                    style: AppStyles.productItemPriceStyle,
                  ),
                  Text(
                    product.tax_class.tax_title,
                    style: AppStyles.smallerWhiteBoldTextStyle,textAlign: TextAlign.center,
                  )
                ]),
              ),
            ),
          )),
    );
  }
}
