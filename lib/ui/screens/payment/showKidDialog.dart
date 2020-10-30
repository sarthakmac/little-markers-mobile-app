import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appDialog.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/viewModel/kidViewModel.dart';
import 'package:turing_academy/ui/screens/course/addKid.dart';

class ShowKidDialog extends StatefulWidget {
  Function onChangeKid;
  Function payFunction;
  ShowKidDialog({this.onChangeKid,this.payFunction});
  @override
  _ShowKidDialogState createState() => _ShowKidDialogState();
}

class _ShowKidDialogState extends State<ShowKidDialog> {

  int selectedindex=0;
  KidModel selectedKid;
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<KidViewModel>(context);
    return FutureBuilder(future: model.getKids(),builder: (context, AsyncSnapshot<List<KidModel>> snapshot){
      if(snapshot.hasData){

        return AlertDialog(
          title: Text(
            "Select Kid For Payment",
            style: AppStyles.smallRedTextStyle,
          ),
          actions: <Widget>[
            FlatButton(
                color: Colors.red,
                child: Text(
                  "CANCEL",
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            snapshot.data.length != 0
                ? FlatButton(
              child: Text("PAY"),
              onPressed: ()async {
//                openCheckout();
              widget.payFunction(snapshot.data[selectedindex]);
              Navigator.of(context).pop();

              },
              color: AppColors.accentColor,
            )
                : FlatButton(
              child: Text("ADD KIDS"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (contexr) {
                  return AddKid(
                    isUpdate: false,
                    kid: null,
                  );
                }));
              },
              color: AppColors.accentColor,
            ),
          ],
          content: snapshot.data.length==0? Text(
            AppString.pleaseAddKids,
            style: AppStyles.smallAccentTextStyle,
          ):Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: ((context, index) {
//              final kid = kidListModel[index];
                  return GestureDetector(
                    onTap: () {
                  setState(() {
                    selectedindex = index;
                    selectedKid =
                    snapshot.data[selectedindex];
                  });
                    },
                    child: Container(

                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                          AssetImage(AssetsStrings.user),
                        ),
                        title: Text(
                          "${snapshot.data[index].firstname} ${snapshot.data[index].lastname}",
                          style: AppStyles.smallerAccentTextStyle,
                        ),
                        subtitle: Text(
                          "${snapshot.data[index].school}",
                      style: selectedindex == index
                          ? AppStyles.smallWhiteBoldTextStyle
                          : AppStyles.smallBrownTextStyle,
                        ),
                        trailing: Text(
                          "age : ${snapshot.data[index].age}",
                      style: selectedindex == index
                          ? AppStyles.smallWhiteBoldTextStyle
                          : AppStyles.smallerAccentTextStyle,
                        ),
                      ),
                      decoration: BoxDecoration(
                      color: selectedindex == index
                          ? AppColors.redBottonColor
                          : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(15)

                      ),

                    ),
                  );
                })),
          ),
        );


      }else{
        return Container(child:  Center(
            child:AppConstant.circularInidcator()
        ),);
      }
    });
  }
}
