import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/viewModel/add_address_viewmodel.dart';
import 'package:turing_academy/core/viewModel/baseView.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';


class AddShippingAddressScreen extends StatefulWidget {
  static const String routeName = 'addShippingAddressScreen';
  @override
  _AddShippingAddressScreenState createState() => _AddShippingAddressScreenState();
}

class _AddShippingAddressScreenState extends State<AddShippingAddressScreen> {

  ScrollController _scrollController;
  bool lastStatus = true;
  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }
  final _formKey = GlobalKey<FormState>();

  bool get isShrink =>
      _scrollController.hasClients && _scrollController.offset > 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
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
          AppString.addAddress, // + _scrollController.offset.toString(),
          style: AppStyles.headingTextStyle,
        ),
        centerTitle: true,
      ),
      body: BaseView<AddShippingAddressViewModel>(
        builder: (context,model,child){
          if(model.state==ViewState.BUSY){
            return AppConstant.circularInidcator();
          }
          return Padding(padding: SizeConfig.verticalPadding,
            child: Container(
              child: Form(
                key: _formKey,
                  child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  SizeConfig.verticalSmallSpace(),
                  Padding(
                    padding: SizeConfig.sidePadding,
                    child: AppTextFormFieldWidget(
                      controller: model.shippingAddress1Controller,
                      labelText:AppString.shippingAddress1,
                      obsecureText: false,
                      validator: (value) {
                        return AppConstant.stringValidator(
                            value,AppString.shippingAddress1);
                      },
                    ),
                  ),
                  Padding(
                    padding:SizeConfig.sidePadding,
                    child: AppTextFormFieldWidget(
                      controller: model.shippingAddress2Controller,
                      labelText: AppString.shippingAddress2,
                      obsecureText: false,
                      validator: (value) {
                        return AppConstant.stringValidator(
                            value, AppString.shippingAddress2);
                      },
                    ),
                  ),
                  Padding(
                    padding: SizeConfig.sidePadding,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AppTextFormFieldWidget(
                            controller:model.shippingCityController,
                            labelText: AppString.shippingCity,
                            obsecureText: false,
                            validator: (value) {
                              return AppConstant.stringValidator(
                                  value, AppString.shippingCity);
                            },
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * .05,
                        ),
                        Expanded(
                          child: AppTextFormFieldWidget(
                            controller: model.shippingStateController,
                            labelText:AppString.shippingState,
                            obsecureText: false,
                            validator: (value) {
                              return AppConstant.stringValidator(
                                  value,AppString.shippingState);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: SizeConfig.sidePadding,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AppTextFormFieldWidget(
                            controller: model.shippingCountryController,
                            labelText: AppString.shippingCountry,
                            obsecureText: false,
                            validator: (value) {
                              return AppConstant.stringValidator(
                                  value, AppString.shippingCountry);
                            },
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * .05,
                        ),
                        Expanded(
                          child: AppTextFormFieldWidget(
                            controller:model.shippingZipCodeController,
                            textInputType: TextInputType.number,
                            labelText: AppString.shippingZipcode,
                            obsecureText: false,
                            validator: (value) {
                              return AppConstant.stringValidator(
                                  value,AppString.shippingZipcode);
                            },
                            onSubmit: (val)=>model.onChangeZipCode(val, context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: SizeConfig.sidePadding,
                    child: AppTextFormFieldWidget(
                      controller: model.phoneController,
                      labelText: AppString.mobileNumber,
                      obsecureText: false,
                      textInputType: TextInputType.phone,
                      validator: (value) {
                        return AppConstant.phoneValidator(
                            value, AppString.parentMobileNumber);
                      },
                    ),
                  ),
                  SizeConfig.verticalSmallSpace(),

                  Padding(padding: SizeConfig.sidePadding,
                    child: AppBotton(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * .06,
                      title: AppString.updateshippingAddress,
                      onTap:(){
                        bool isValid = _formKey.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        model.updateUserShippingAddress(context);
                      },
                    ),)

                ],
              )),
            ),);
        },
      ),
    );
  }
}

