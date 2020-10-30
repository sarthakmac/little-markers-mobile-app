import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:turing_academy/constants/appColors.dart';

import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';

import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class AddNewCardScreen extends StatefulWidget {
  static const String routeName = 'add-new-card-screen';
  static GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  ScrollController _scrollController;

  bool lastStatus = true;
  bool showbillingAddres = true;

  final sidePadding = SizeConfig.screenWidth * .03;
  final verticalPadding = SizeConfig.screenHeight * .01;

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

  Widget completePayment() {
    return Container(
        width: double.infinity,
        height: 60,
        child: RawMaterialButton(
            onPressed: () {},
            materialTapTargetSize: MaterialTapTargetSize.padded,
            fillColor: AppColors.bottomBarColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            elevation: 0.0,
            child: Text("ADD CARD", style: AppStyles.btnCheckout)));
  }

  Widget _devider() {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.screenHeight * .01,
          bottom: SizeConfig.screenHeight * .01),
      child: Container(
        height: 1,
        width: SizeConfig.screenWidth,
        color: AppColors.fontGreyColor.withOpacity(.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

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
            "Add New Card", // + _scrollController.offset.toString(),
            style: AppStyles.headingTextStyle,
          ),
          centerTitle: true,
        ),
        key: AddNewCardScreen.scaffoldkey,
        body: Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
            ),
            ScreenBackGround(
                child: Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.8,
                            height: SizeConfig.screenHeight * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.accentColor.withOpacity(0.9)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Holder Name",
                                    style: AppStyles.smallerWhiteLightTextStyle,
                                  ),
                                  Text(
                                    "Dhey Rathod",
                                    style: AppStyles.mediumWhiteTextStyle,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "9781 - XXXX - XXXX - XXXX",
                                    style: AppStyles.mediumWhiteLightTextStyle,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Exp. Date",
                                            style: AppStyles
                                                .smallerWhiteLightTextStyle,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "11/12",
                                            style:
                                                AppStyles.mediumWhiteTextStyle,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.2,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "CCV",
                                            style: AppStyles
                                                .smallerWhiteLightTextStyle,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "***",
                                            style:
                                                AppStyles.mediumWhiteTextStyle,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 400,
                            width: 300,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: SizeConfig.screenHeight * .01),
                                    child: ListView(
                                      controller: _scrollController,
                                      children: <Widget>[
                                        SizedBox(
                                          height: SizeConfig.screenHeight * .01,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: sidePadding,
                                            right: sidePadding,
                                          ),
                                          child: AppTextFieldWidget(
                                            controller: TextEditingController(
                                                text: '4787  7878  7878  4568'),
                                            labelText: "Card Number",
                                            obsecureText: false,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: sidePadding,
                                            right: sidePadding,
                                          ),
                                          child: AppTextFieldWidget(
                                            controller: TextEditingController(
                                                text: 'Dhey Rathod'),
                                            labelText: "Card Holder Name",
                                            obsecureText: false,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: sidePadding,
                                            right: sidePadding,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: AppTextFieldWidget(
                                                  controller:
                                                      TextEditingController(
                                                          text: '11/12'),
                                                  labelText: "Expiry Date",
                                                  obsecureText: false,
                                                ),
                                              ),
                                              SizedBox(
                                                width: SizeConfig.screenWidth *
                                                    .05,
                                              ),
                                              Expanded(
                                                child: AppTextFieldWidget(
                                                  controller:
                                                      TextEditingController(
                                                          text: '898'),
                                                  labelText: "CCV",
                                                  obsecureText: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: completePayment(),
            ))
          ],
        ));
  }
}
