import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addWishListCredential.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/viewModel/baseView.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/widgets/courseAppBar.dart';
import 'package:turing_academy/ui/widgets/productItem.dart';
import 'package:turing_academy/ui/widgets/screenBackground.dart';
import 'package:turing_academy/ui/widgets/wishlist/wishlistItem.dart';

class WishListScreen extends StatefulWidget {
  static const String routeName = "wishList";
  GlobalKey<ScaffoldState> scaffoldkey;
  WishListScreen({this.scaffoldkey});
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

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
    final model= Provider.of<ProductViewModel>(context);
    return ScreenBackGround(
      child: Column(children: <Widget>[
        CourseAppBar(
          isShrink: isShrink,
          title: AppString.myWishList,
          scaffoldkey: widget.scaffoldkey,
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * .02,
                  right: SizeConfig.screenWidth * .02,
                  bottom: SizeConfig.screenHeight * 0.1),
              child: FutureBuilder(future:model.getFutureWishList() ,builder: (context,snapshot){
                if(snapshot.hasData){
                  if(snapshot.data.length==0){
                    return Center(
                      child: Text('wish list is empty',style: AppStyles.largeBlackTextStyle,),
                    );
                  }
                  return GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Orientation.portrait ==
                          MediaQuery.of(context).orientation
                          ? 2
                          : 3,
                      mainAxisSpacing: 9.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          WishListItemView(wishListItem: snapshot.data[index],),
                          Positioned(
                            top: SizeConfig.screenHeight * .01,
                            right: 0,
                            child: MaterialButton(
                              onPressed: () {
                                model.removeWishList(AddWishListCredentail(user_id: loggedInUser.id, product_id:snapshot.data[index].productId)).then((value) {
                                  if(value.statuscode==1){
                                    showToast(value.msg);


                                  }
                                });
                              },

                              child: Icon(Icons.delete,color: AppColors.redBottonColor,),
                              padding: EdgeInsets.all(3),
                              shape: CircleBorder(),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }else{
                  return AppConstant.circularInidcator();
                }
              })),
        ),

//        Expanded(
//          child: Padding(
//              padding: EdgeInsets.only(
//                  left: SizeConfig.screenWidth * .02,
//                  right: SizeConfig.screenWidth * .02,
//                  bottom: SizeConfig.screenHeight * 0.1),
//              child: BaseView<ProductViewModel>(
//                  onModelReady: (model) => model.getWishList(),
//                  builder: (context, productProvider, _) {
//                    return productProvider.state==ViewState.BUSY
//                        ? SizedBox(
//                      height: SizeConfig.screenHeight * .02,
//                      child:
//                      Center(child: AppConstant.circularInidcator()),
//                    )
//                        : GridView.builder(
//                      controller: _scrollController,
//                      gridDelegate:
//                      SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: Orientation.portrait ==
//                            MediaQuery.of(context).orientation
//                            ? 2
//                            : 3,
//                        mainAxisSpacing: 9.0,
//                        crossAxisSpacing: 20.0,
//                        childAspectRatio: 0.7,
//                      ),
//                      itemCount: productProvider.wishlistItems.length,
//                      itemBuilder: (BuildContext context, int index) {
//                        return Stack(
//                          children: [
//                            WishListItemView(wishListItem: productProvider.wishlistItems[index],),
//                        Positioned(
//                        top: SizeConfig.screenHeight * .01,
//                        right: 0,
//                              child: MaterialButton(
//                                onPressed: () {
//                                  productProvider.removeWishList(AddWishListCredentail(user_id: loggedInUser.id, product_id:productProvider.wishlistItems[index].productId)).then((value) {
//                                    if(value.statuscode==1){
//                                      showToast(value.msg);
//
//
//                                    }
//                                  });
//                                },
//
//                                child: Icon(Icons.delete,color: AppColors.redBottonColor,),
//                                padding: EdgeInsets.all(3),
//                                shape: CircleBorder(),
//                              ),
//                            )
//                          ],
//                        );
//                      },
//                    );
//                  })),
//        )
      ]),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);

  }
}
