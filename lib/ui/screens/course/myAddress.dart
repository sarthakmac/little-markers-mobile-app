import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/updateAddressCredential.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/model/userAddressModel.dart';
import 'package:turing_academy/core/services/locationManager.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/providers/userProvider.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/courseAppBar.dart';
import 'package:turing_academy/ui/widgets/profileImageWidget.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'package:turing_academy/ui/widgets/smallAppBotton.dart';

class MyAddress extends StatefulWidget {
  static const String routeName = "myaddress";
  GlobalKey<ScaffoldState> scaffoldkey;
  MyAddress({this.scaffoldkey});
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final TextEditingController billing_address1Controller = TextEditingController();
  final TextEditingController shipping_address1Controller =
       TextEditingController();

  final TextEditingController billing_address2Controller =
      new TextEditingController();
  final TextEditingController shipping_address2Controller =
      new TextEditingController();

  final TextEditingController billingCityController =
      new TextEditingController();
  final TextEditingController shippingCityController =
      new TextEditingController();

  final TextEditingController billingStateController =
      new TextEditingController();
  final TextEditingController shippingStateController =
      new TextEditingController();

  final TextEditingController billingCountrtController =
      new TextEditingController();
  final TextEditingController shippingCountryController =
      new TextEditingController();

  var billingZipCodeController =
  MaskedTextController(mask: '000000');
  var phoneController =
  MaskedTextController(mask: '0000000000');
  var  shippingZipCodeController =
  MaskedTextController(mask: '000000');

  final _formKey = GlobalKey<FormState>();
  ResponseModel responseModel =
      new ResponseModel(isSUcessfull: null, responseMessage: null);

  ScrollController _scrollController;
  bool lastStatus = true;
  bool showbillingAddres = true;
  bool _isLoading = false;
  bool _isUpdatingUserAddress = false;

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
    getUserAddress();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  getUserAddress() async {
    _isLoading = true;
    await Provider.of<UserViewModel>(context, listen: false)
        .getUserAddress();
    billing_address1Controller.text = userAddress.billing_address_1;
    shipping_address1Controller.text = userAddress.shipping_address_1;

    billing_address2Controller.text = userAddress.billing_address_2;
    shipping_address2Controller.text = userAddress.shipping_address_2;

    billingCityController.text = userAddress.billing_city;
    shippingCityController.text = userAddress.shipping_city;

    billingStateController.text = userAddress.billing_state;
    shippingStateController.text = userAddress.shipping_state;

    billingCountrtController.text = userAddress.billing_country;
    shippingCountryController.text = userAddress.shipping_country;

    billingZipCodeController.text = userAddress.billing_zipcode;
    shippingZipCodeController.text = userAddress.shipping_zipcode;
    phoneController.text=userAddress.shipping_phone;

//
//    if (responseModel.isSUcessfull == false) {
//      AppConstant.showFialureDialogue(
//          "User does Not Currently have an Address", context);
//    }
    setState(() {
      _isLoading = false;
    });
  }

  void updateAddress() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isUpdatingUserAddress = true;
    });

    try {
      UpdateAddressCredential updateAddressCredential = new UpdateAddressCredential(
          user_id: loggedInUser.id,
          shipping_address_1: shipping_address1Controller.text,
          shipping_address_2: shipping_address2Controller.text,
          shipping_city: shippingCityController.text,
          shipping_state: shippingStateController.text,
          shipping_zipcode: shippingZipCodeController.text,
          shipping_country: shippingCountryController.text,
          billing_address_1: billing_address1Controller.text,
          billing_address_2: billing_address2Controller.text,
          billing_city: billingCityController.text,
          billing_zipcode: billingZipCodeController.text,
          billing_state: billingStateController.text,
          shipping_phone: phoneController.text,
          billing_country: billingCountrtController.text);
      ResponseMessage responseMessage=ResponseMessage(msg: null, statuscode: null);
      if(showbillingAddres){
       responseMessage = await Provider.of<UserViewModel>(context, listen: false)
            .updateUserbillingAddress(updateAddressCredential);

      }else{
        responseMessage = await Provider.of<UserViewModel>(context, listen: false)
            .updateUserShippingAddress(updateAddressCredential);
      }

      if (responseMessage.statuscode!=1) {
        AppConstant.showFialureDialogue(responseMessage.msg, context);
      }else{
        AppConstant.showSuccessDialogue(responseMessage.msg, context);
      }

    } catch (e) {
      AppConstant.showFialureDialogue(responseModel.responseMessage, context);
    }
    setState(() {
      _isUpdatingUserAddress = false;
    });
  }

  bool smabiling=false;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
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
    final sidePadding = SizeConfig.screenWidth * .03;
    final verticalPadding = SizeConfig.screenHeight * .01;
    final model=Provider.of<UserViewModel>(context);
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
            AppString.myAddress, // + _scrollController.offset.toString(),
            style: AppStyles.headingTextStyle,
          ),
          centerTitle: true,
        ),
      body:Form(
        autovalidate: true,
        key: _formKey,
        child: Column(
          children: <Widget>[
//            CourseAppBar(
//              isShrink: isShrink,
//              title: AppString.myAddress,
//              scaffoldkey: widget.scaffoldkey,
//            ),
            Expanded(
              child: model.state==ViewState.BUSY
                  ? AppConstant.circularInidcator()
                  : Padding(
                padding:
                EdgeInsets.only(bottom: SizeConfig.screenHeight * .01),
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.screenHeight * .1,
                      width: SizeConfig.screenHeight * .1,
                      child: Image.asset(AssetsStrings.menuAddress),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: sidePadding * 2,
                        right: sidePadding * 2,
                      ),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(
                              SizeConfig.screenHeight * .005),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: SmallAppBotton(
                                  height: SizeConfig.screenHeight * .05,
                                  width: SizeConfig.screenWidth,
                                  title: AppString.billingAddress,
                                  textStyle: showbillingAddres
                                      ? AppStyles.smallerWhiteTextStyle
                                      : AppStyles.smallBrownTextStyle,
                                  color: showbillingAddres
                                      ? AppColors.brownColor
                                      : AppColors.whiteColor,
                                  onTap: () {
                                    setState(() {
                                      showbillingAddres = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * .02,
                              ),
                              Expanded(
                                child: SmallAppBotton(
                                  height: SizeConfig.screenHeight * .05,
                                  width: SizeConfig.screenWidth,
                                  title: AppString.shippingAddress,
                                  textStyle: showbillingAddres
                                      ? AppStyles.smallBrownTextStyle
                                      : AppStyles.smallerWhiteTextStyle,
                                  color: showbillingAddres
                                      ? AppColors.whiteColor
                                      : AppColors.brownColor,
                                  onTap: () {
                                    setState(() {
                                      showbillingAddres = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.03)),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * .01,
                    ),
                    _devider(),
                    Row(
//                          crossAxisAlignment: CrossAxisAlignment.end,
//                          mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        showbillingAddres?Container():IconButton(icon: Icon(smabiling?Icons.check_box:Icons.check_box_outline_blank), onPressed: (){
                          setState(() {
                            smabiling=!smabiling;
                          });
                          if(smabiling){
                            shipping_address1Controller.text=billing_address1Controller.text;
                            shipping_address2Controller.text=billing_address2Controller.text;
                            shippingCityController.text=billingCityController.text;
                            shippingStateController.text=billingStateController.text;
                            shippingCountryController.text=billingCountrtController.text;
                            shippingZipCodeController.text=billingZipCodeController.text;

                          }

                        }),
                        showbillingAddres?Container():Text(AppString.sameasBilling),
                        Spacer(),
                        IconButton(icon: Icon(Icons.my_location),
                            onPressed: (){
                              LocationManager.getUserLocation().then((value){
                                if(showbillingAddres){


                                  setState(() {
                                    billing_address1Controller.text=value.billing_address_1;
                                    billingCityController.text=value.billing_city;
                                    billingStateController.text=value.billing_state;
                                    billingCountrtController.text=value.billing_country;
                                    billingZipCodeController.text=value.billing_zipcode;
                                  });

                                }else{
                                  setState(() {
                                    shipping_address1Controller.text=value.billing_address_1;
                                    shippingCityController.text=value.billing_city;
                                    shippingStateController.text=value.billing_state;
                                    shippingCountryController.text=value.billing_country;
                                    shippingZipCodeController.text=value.billing_zipcode;
                                  });

                                }

                              });

                            })
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: sidePadding,
                        right: sidePadding,
                      ),
                      child: AppTextFormFieldWidget(
                        controller: showbillingAddres
                            ? billing_address1Controller
                            : shipping_address1Controller,
                        labelText: showbillingAddres
                            ? AppString.billingAddress1
                            : AppString.shippingAddress1,
                        obsecureText: false,
                        validator: (value) {
                          return AppConstant.stringValidator(
                              value = showbillingAddres
                                  ? billing_address1Controller.text
                                  : shipping_address1Controller.text,
                              showbillingAddres
                                  ? AppString.billingAddress1
                                  : AppString.shippingAddress1);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: sidePadding,
                        right: sidePadding,
                      ),
                      child: AppTextFormFieldWidget(
                        controller: showbillingAddres
                            ? billing_address2Controller
                            : shipping_address2Controller,
                        labelText: showbillingAddres
                            ? AppString.billingAddress2
                            : AppString.shippingAddress2,
                        obsecureText: false,
                        validator: (value) {
                          return AppConstant.stringValidator(
                              value = showbillingAddres
                                  ? billing_address2Controller.text
                                  : shipping_address2Controller.text,
                              showbillingAddres
                                  ? AppString.billingAddress2
                                  : AppString.shippingAddress2);
                        },
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
                            child: AppTextFormFieldWidget(
                              controller: showbillingAddres
                                  ? billingCityController
                                  : shippingCityController,
                              labelText: showbillingAddres
                                  ? AppString.billingCity
                                  : AppString.shippingCity,
                              obsecureText: false,
                              validator: (value) {
                                return AppConstant.stringValidator(
                                    value = showbillingAddres
                                        ? billingCityController.text
                                        : shippingCityController.text,
                                    showbillingAddres
                                        ? AppString.billingCity
                                        : AppString.shippingCity);
                              },
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * .05,
                          ),
                          Expanded(
                            child: AppTextFormFieldWidget(
                              controller: showbillingAddres
                                  ? billingStateController
                                  : shippingStateController,
                              labelText: showbillingAddres
                                  ? AppString.billingState
                                  : AppString.shippingState,
                              obsecureText: false,
                              validator: (value) {
                                return AppConstant.stringValidator(
                                    value = showbillingAddres
                                        ? billingStateController.text
                                        : shippingStateController.text,
                                    showbillingAddres
                                        ? AppString.billingState
                                        : AppString.shippingState);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sidePadding,
                          right: sidePadding,
                          bottom: verticalPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: AppTextFormFieldWidget(
                              controller: showbillingAddres
                                  ? billingCountrtController
                                  : shippingCountryController,
                              labelText: showbillingAddres
                                  ? AppString.billingCountry
                                  : AppString.shippingCountry,
                              obsecureText: false,
                              validator: (value) {
                                return AppConstant.stringValidator(
                                    value = showbillingAddres
                                        ? billingCountrtController.text
                                        : shippingCountryController.text,
                                    showbillingAddres
                                        ? AppString.billingCountry
                                        : AppString.shippingCountry);
                              },
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * .05,
                          ),
                          Expanded(
                            child: AppTextFormFieldWidget(
                              controller: showbillingAddres
                                  ? billingZipCodeController
                                  : shippingZipCodeController,
                              textInputType: TextInputType.number,
                              labelText: showbillingAddres
                                  ? AppString.billingZipcode
                                  : AppString.shippingZipcode,
                              obsecureText: false,
                              validator: (value) {
                                return AppConstant.stringValidator(
                                    value = showbillingAddres
                                        ? billingZipCodeController.text
                                        : shippingZipCodeController.text,
                                    showbillingAddres
                                        ? AppString.billingZipcode
                                        : AppString.shippingZipcode);
                              },
                              onSubmit: (val)async{
                                try{
                                  var addresses = await Geocoder.local.findAddressesFromQuery(showbillingAddres
                                      ? billingZipCodeController.text
                                      : shippingZipCodeController.text);

                                  if(showbillingAddres){
                                    setState(() {
                                      billingCountrtController.text=addresses.first.countryName;
                                      billingStateController.text=addresses.first.adminArea;
                                      billingCityController.text=addresses.first.subAdminArea;
                                    });
                                  }else{
                                    setState(() {
                                      shippingCountryController.text=addresses.first.countryName;
                                      shippingStateController.text=addresses.first.adminArea;
                                      shippingCityController.text=addresses.first.subAdminArea;
                                    });
                                  }
                                }catch(e){
                                  AppConstant.showFailToast(context, 'invalid zipcode');

                                  setState(() {
                                    billingZipCodeController.clear();
                                    shippingZipCodeController.clear();

                                  });

                                  print(e.toString());

                                }



                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    showbillingAddres?Container():Padding(
                      padding: EdgeInsets.only(
                          left: sidePadding,
                          right: sidePadding,
                          bottom: verticalPadding),
                      child: AppTextFormFieldWidget(
                        controller: phoneController,
                        labelText: AppString.mobileNumber,
                        obsecureText: false,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          return AppConstant.phoneValidator(
                              value, AppString.parentMobileNumber);
                        },
                      ),
                    ),

                    _isUpdatingUserAddress
                        ? AppConstant.circularInidcator()
                        : Padding(
                      padding: EdgeInsets.only(
                          left: sidePadding,
                          right: sidePadding,
                          top: verticalPadding,
                          bottom: verticalPadding),
                      child: AppBotton(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * .06,
                        title: showbillingAddres
                            ? AppString.updatebillingAddress
                            : AppString.updateshippingAddress,
                        onTap: updateAddress,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
