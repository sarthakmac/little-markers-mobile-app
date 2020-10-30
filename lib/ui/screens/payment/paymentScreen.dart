import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/createOrderCredential.dart';
import 'package:turing_academy/core/model/cartItem.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/viewModel/kidViewModel.dart';
import 'package:turing_academy/core/viewModel/orderViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/cartProvider.dart';
import 'package:turing_academy/ui/screens/homeScreen.dart';
import 'package:turing_academy/ui/screens/payment/showKidDialog.dart';
import 'package:turing_academy/ui/widgets/add_shipping_address_screen.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';


class PaymentScreen extends StatefulWidget {
  CartItem cartItem;
  static const String routeName = 'payment-screen';
  static GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  PaymentScreen({this.cartItem});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const platform = const MethodChannel("razorpay_flutter");

  KidModel selectedKid;
  Razorpay _razorpay;
  int _physicalProductCount = 0;
  int _virtualProductCount = 0;
  double _virtualProductPrice = 0;
  double _physicalProductPrice = 0;
  double _subtotalProductTotal = 0;
  double _shippingTotal;
  double _tax = 0;
  double _grandTotal = 0;
  String _kidId;

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
    var cartData = Provider.of<CartProvider>(context, listen: false);
    _physicalProductCount = cartData.getPhysicalProduct(widget.cartItem);
    _virtualProductCount = cartData.getVirtualProduct(widget.cartItem);
    _physicalProductPrice = cartData.getTotalPhyicalPrice(widget.cartItem);
    _virtualProductPrice = cartData.getTotalVirtualPrice(widget.cartItem);
//    _tax = double.parse(widget.cartItem.cartTaxTotal.toString());
    _tax = cartData.getTax(widget.cartItem);
//    _subtotalProductTotal =  double.parse(widget.cartItem.cartSubTotal.toString());

    _subtotalProductTotal = double.parse(widget.cartItem.cartSubTotal.toString());
    _grandTotal = _subtotalProductTotal + _tax;
//    _grandTotal = double.parse(widget.cartItem.cartGrandTotal.toString());
    _shippingTotal = cartData.getTotalShippingRate(widget.cartItem);
//    _shippingTotal = double.parse(widget.cartItem..toString());
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() async {
    print('amount ${widget.cartItem.cartGrandTotal*100}');

    var options = {
      'key': 'rzp_live_PjVN1w4AFR6loN',
      'amount': (widget.cartItem.cartGrandTotal*100).toInt(),
      'name': AppString.title,
      'description': 'Payment for School Product',
//      'prefill': {'contact': '8888888888', 'email': 'turingacademy@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    Map am={
      'oderId':response.orderId,
      'paymentId':response.paymentId,
      'signature':response.signature


    };

    try{
      print('object===${widget.cartItem.cartCollection.length}');
CreateOrderCredential createOrderCredential =CreateOrderCredential(
  user_id: loggedInUser.id.toString(),
  kid_id: selectedKid!=null?selectedKid.id.toString():null,
  sub_total: widget.cartItem.cartSubTotal.toString(),
  tax_total: widget.cartItem.cartTaxTotal.toString(),
  shipping_total: widget.cartItem.cartShippingTotal.toString(),
  grand_total: widget.cartItem.cartGrandTotal.toString(),
  date_time: DateTime.now().toString(),
  payment_id: response.paymentId,
  cartContent: widget.cartItem.cartCollection
);

      //final apiResponse =
      await Provider.of<OrderViewModel>(context, listen: false)
          .createOrder(createOrderCredential)
          .then((val) async {
        Provider.of<OrderViewModel>(context, listen: false).clearCart();


//        Navigator.of(context).pushNamed(HomeScreen.routeName);
//       AppConstant.showSuccessDialogue(
//           "Payment Order Sucessfull for ${response.paymentId}", context);

        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              return AlertDialog(
                title: Text(
                  "${val.msg}",
                  style: AppStyles.headingTextStyle,
                ),
                content: Text(
                  "Payment successful ",
                  style: AppStyles.smallGreenTextStyle,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      currentCartList = [];
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    },
                  )
                ],
              );
            });
      });

    }catch(e){
      print('#########################################$e');
    }

    // if (apiResponse.isSUcessfull) {
    //   AppConstant.showSuccessDialogue(
    //       "Payment Order Sucessfull for ${response.paymentId}", context);
    // }

    // go to products page
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    AppConstant.showFialureDialogue("Error : ${response.message}", context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    AppConstant.showSuccessDialogue(
        "EXTENAL WALLET : ${response.walletName}", context);
  }

  Widget completePayment(KidViewModel model) {
    return Container(
        width: double.infinity,
        height: 60,
        child: RawMaterialButton(
            onPressed:()async{
              bool address=await model.checkUser();

              if(address){
                _showKidsDialog();
              }else{
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(
                          AppString.pleaseUpdateYourShippingAddress,
                          style: AppStyles.headingTextStyle,
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(AppString.ok),
                            onPressed: () {
                              Navigator.of(context).popAndPushNamed(AddShippingAddressScreen.routeName);
                            },
                          )
                        ],
                      );
                    });

              }

            },
            // openCheckout,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            fillColor: AppColors.bottomBarColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            elevation: 0.0,
            child: Text(AppString.completeAndPay, style: AppStyles.btnCheckout)));
  }

  Widget rowWidget(String title, subtitle) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: AppStyles.smallerPaymentBoldTextStyle,
            ),
            Expanded(
              child: Text(
                FlutterMoneyFormatter(
                        settings: MoneyFormatterSettings(symbol: "₹"),
                        amount: double.parse(subtitle))
                    .output
                    .symbolOnLeft,
                textAlign: TextAlign.end,
                style: AppStyles.smallerGrayBoldTextStyle,
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.fontGreyColor.withOpacity(.2)))),
    );
  }

  Widget grandTotalRowWidget(String title, subtitle) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: AppStyles.smallerRedTextStyle,
            ),
            Expanded(
              child: Text(
                FlutterMoneyFormatter(
                        settings: MoneyFormatterSettings(symbol: "₹"),
                        amount: double.parse(subtitle))
                    .output
                    .symbolOnLeft,
                textAlign: TextAlign.end,
                style: AppStyles.smallerRedTextStyle,
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.fontGreyColor.withOpacity(.2)))),
    );
  }

  int _selectedIndex = 0;

  void _showKidsDialog() async {
//    selectedKid = kidListModel[_selectedIndex];
    List<KidModel>kids=[];
    kids=await Provider.of<KidViewModel>(context,listen: false).getKids();
    if(kids.length>0){
      showDialog(
          context: context,
          builder: (ctx) =>ShowKidDialog(
            payFunction: (kid){
              setState(() {
                selectedKid=kid;
              });
              openCheckout();
            },
          ));
    }else{
      openCheckout();
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final model=Provider.of<KidViewModel>(context);

    return Scaffold(
        appBar: AppBar(
//      pinned: true,
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
            AppString.payment, // + _scrollController.offset.toString(),
            style: AppStyles.headingTextStyle,
          ),
          centerTitle: true,
        ),
        key: PaymentScreen.scaffoldkey,
        body: model.state==ViewState.BUSY?AppConstant.circularInidcator():Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
            ),
            ScreenBackGround(
                child: Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: SizeConfig.screenHeight * 0.4,
                            width: SizeConfig.screenWidth * 0.9,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    AppString.paymentSummary,
                                    style: AppStyles.headingTextStyle,
                                  ),
                                ),
                                rowWidget(
                                    "$_physicalProductCount X Physical Product",
                                    "${_physicalProductPrice}"),
                                rowWidget("$_virtualProductCount x Virtual",
                                    "${_virtualProductPrice * _virtualProductCount}"),
                                rowWidget(
                                    "Sub Total", "${widget.cartItem.cartSubTotal}"),
                                rowWidget("Tax", "${widget.cartItem.cartTaxTotal}"),
                                rowWidget("Shipping Rate", "${widget.cartItem.cartShippingTotal}"),
                                grandTotalRowWidget(
                                    "Grand Total", "${widget.cartItem.cartGrandTotal}"),

                              ],
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.screenWidth * .03),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(.2),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 7,
                          ),


                        ],
                      ),
                    ))),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: completePayment(model),
            ))
          ],
        ));
  }
}
