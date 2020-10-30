import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/providers/cartProvider.dart';
import 'package:turing_academy/ui/screens/payment/paymentScreen.dart';
import 'package:turing_academy/ui/widgets/cartItemWidhet.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = 'cart-screen';
  static GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ScrollController _scrollController;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink =>
      _scrollController.hasClients && _scrollController.offset > 5;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Widget checkOutButton(CartItem cartItem) {
    return Container(
        width: double.infinity,
        height: 60,
        child: RawMaterialButton(
            onPressed: () {
              Navigator.of(context).pushNamed(PaymentScreen.routeName,arguments: cartItem);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            fillColor: AppColors.bottomBarColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            elevation: 0.0,
            child: Text("CHECKOUT", style: AppStyles.btnCheckout)));
  }

  Widget totalWidget(CartItem cartItem) {
    return Container(
      width: SizeConfig.screenWidth * 0.9,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total",
                style: AppStyles.productItemTitleStyle,
              ),
              Consumer<CartProvider>(
                  builder: (_, cart, ch) => Text(
                      FlutterMoneyFormatter(
                              settings: MoneyFormatterSettings(symbol: "₹"),
                              amount: double.parse(cartItem.cartGrandTotal.toString()))
                          .output
                          .symbolOnLeft,
                      style: AppStyles.productItemPriceStyle)),
            ]),
      ),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.height * 0.02),
          color: AppColors.redBottonColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final model = Provider.of<ProductViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: !isShrink ? 0.0 : 2.0,
          backgroundColor: !isShrink ? Colors.transparent : Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
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
          title: Text(
            "My Cart", // + _scrollController.offset.toString(),
            style: AppStyles.headingTextStyle,
          ),
          centerTitle: true,
        ),
        // key: CartScreen.scaffoldkey,
        body: FutureBuilder(
        future: model.getCartList(),
            builder: (BuildContext context,AsyncSnapshot<CartItem>snapshot){
         if(snapshot.hasData){
           return Stack(
             children: <Widget>[
               Container(
                 width: SizeConfig.screenWidth,
                 height: SizeConfig.screenHeight,

               ),
               ScreenBackGround(
                   child: Container(
                     margin: const EdgeInsets.only(bottom: 120),
                     child: snapshot.data.cartCollection.length > 0
                         ? ListView.builder(
                         itemCount: snapshot.data.cartCollection.length,
                         itemBuilder: (context, index) {
                           return CartItemWidget(snapshot.data.cartCollection[index]);
                         })
                         : Center(
                       child: Text(
                         "Cart is Currently Empty",
                         style: AppStyles.headingTextStyle,
                       ),
                     ),
                   )),
               Positioned.fill(
                   child: Align(
                       alignment: Alignment.bottomCenter,
                       child: Container(
                         height: 200,
                         child: snapshot.data.cartCount > 0
                             ? Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: <Widget>[
                             totalWidget(snapshot.data),
                             SizedBox(
                               height: 15,
                             ),
                             checkOutButton(snapshot.data),
                           ],
                         )
                             : Text(""),
                       )))
             ],
           );
         }else{
           return AppConstant.circularInidcator();
         }

    }));
  }
}
