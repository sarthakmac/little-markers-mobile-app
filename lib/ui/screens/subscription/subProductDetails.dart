import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
//import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/constants/urls.dart';
import 'package:turing_academy/core/model/subscriptionModel.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'package:toast/toast.dart';



class SubProductDetailScreen extends StatefulWidget {
  final SubProducts subProducts;
  static const String routeName = 'subProductDetails';

  const SubProductDetailScreen({Key key, this.subProducts}) : super(key: key);

  @override
  _SubProductDetailScreenState createState() => _SubProductDetailScreenState();
}

class _SubProductDetailScreenState extends State<SubProductDetailScreen> {
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
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
                                imageUrl: AppUrl.storageAddress + widget.subProducts.image,
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
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    widget.subProducts.name,
                                    style: TextStyle(
                                        color: AppColors.yellowColor,
                                        fontSize: AppConstant.fontSizeLarge),
                                  ),
                                ),
                                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    AppString.lnlProductDescription,
                                    style: AppStyles.productItemPriceStyle
                                        .copyWith(color: AppColors.turquoiseColor),
                                  ),
                                ),
                                SizedBox(height: SizeConfig.blockSizeVertical * 2),
//                                Text(
//                                  widget.product.long_desc,
//                                  style: AppStyles.mainTextStyle,
//                                ),
                              widget.subProducts.subProductsContent.length>0?Container(
                                child: widget.subProducts.subProductsContent.first.description!=null?Html(data: widget.subProducts.subProductsContent.first.description,
                                  style: {
                                    "html": Style(
                                      color: AppColors.whiteColor
                                    ),

                                  },

                                ):Container(),
                              ):Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(child: Text(AppString.noContentFound,
                                style: AppStyles.mediumWhiteTextStyle,),),
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


          ],
        ));
  }
}
