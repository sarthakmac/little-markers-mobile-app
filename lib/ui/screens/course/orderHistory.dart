import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/viewModel/orderViewModel.dart';
import 'package:turing_academy/ui/widgets/course/viewHistoryWidget.dart';
import 'package:turing_academy/ui/widgets/courseAppBar.dart';

class OrderHistory extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldkey;

  OrderHistory({this.scaffoldkey});


  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  ScrollController _scrollController;
  bool lastStatus = true;
  bool showbillingAddres=true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink => _scrollController.hasClients && _scrollController.offset > 5;

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
  calculateTotalamount(List<Order>list){

    num total=0;
    list.forEach((Order e){
      print('object##${e.grandTotal}');
      total += double.parse(e.grandTotal);
    });
    return total.round();

  }
  @override
  Widget build(BuildContext context) {
    final sidePadding=SizeConfig.screenWidth*.03;
    final model=Provider.of<OrderViewModel>(context);
    return Column(
      children: <Widget>[
        CourseAppBar(isShrink: isShrink,title: AppString.orderHistory,
        scaffoldkey: widget.scaffoldkey,),
        FutureBuilder(
          future: model.getOrderList(),
          builder: (BuildContext context,AsyncSnapshot<List<Order>>snapshot){
           if(snapshot.hasData){
             return Expanded(child: Column(
               children: <Widget>[
//                 Padding(
//                   padding:  EdgeInsets.only(
//                       left: sidePadding,
//                       right: sidePadding
//
//                   ),
//                   child: Container(
//                     child: Padding(
//                       padding:  EdgeInsets.only(
//                           top: SizeConfig.screenHeight*.02,
//                           bottom: SizeConfig.screenHeight*.02,
//                           left: sidePadding,right: sidePadding
//                       ),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(child: Text(AppString.totalSpent,style: AppStyles.mediumWhiteTextStyle,)),
//                           Text('\u20B9 ${calculateTotalamount(snapshot.data)}',style: AppStyles.mediumWhiteTextStyle,)
//                         ],
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: AppColors.accentColor,
//                         borderRadius: BorderRadius.circular(SizeConfig.screenWidth*.03)
//
//                     ),
//                   ),
//                 ),

                 SizedBox(height: SizeConfig.screenHeight*.01,),
                 Expanded(child:
                 Padding(
                   padding:  EdgeInsets.only(
                       left: sidePadding,
                       right: sidePadding
                   ),
                   child:ListView.builder(padding: EdgeInsets.all(0),itemCount: snapshot.data.length,itemBuilder: (BuildContext context,int index){
                     return Padding(
                       padding:  EdgeInsets.only(
                           bottom: SizeConfig.screenHeight*.01
                       ),
                       child: ViewHistoryWidget(order: snapshot.data[index],),
                     );
                   }),
                 )),
                 SizedBox(height: SizeConfig.screenHeight*.1,),
               ],
             ));

           }else{
             return AppConstant.circularInidcator();
           }
        },
        ),
      ],
    );
  }
}
