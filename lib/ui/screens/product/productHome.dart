import 'package:flutter/material.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/viewModel/baseView.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/widgets/courseAppBar.dart';
import 'package:turing_academy/ui/widgets/productItem.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';

class ProductHome extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldkey;
  ProductHome({this.scaffoldkey});
  @override
  _ProductHomeState createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {

  ScrollController _scrollController;
  bool lastStatus = true;
  bool _isLoading = false;
  ResponseModel responseModel =
  new ResponseModel(isSUcessfull: null, responseMessage: null);

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
    //get all products
//    getAllProducts();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    print(loggedInUser.id);
    return ScreenBackGround(
      child: Column(children: <Widget>[
        CourseAppBar(
          isShrink: isShrink,
          title: AppString.product,
          scaffoldkey: widget.scaffoldkey,
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * .02,
                  right: SizeConfig.screenWidth * .02,
                  bottom: SizeConfig.screenHeight * 0.1),
              child: BaseView<ProductViewModel>(
                  onModelReady: (model) => model.getProducts(),
                  builder: (context, productProvider, _) {
                    return productProvider.state==ViewState.BUSY
                        ? SizedBox(
                      height: SizeConfig.screenHeight * .02,
                      child:
                      Center(child: AppConstant.circularInidcator()),
                    )
                        : GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Orientation.portrait ==
                            MediaQuery.of(context).orientation
                            ? 2
                            : 3,
                        mainAxisSpacing: 9.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: productProvider.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(productProvider.items[index]);
                      },
                    );
                  })),
        )
      ]),
    );
  }
}
