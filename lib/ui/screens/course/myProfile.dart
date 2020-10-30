import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/updateProfileCredential.dart';
import 'package:turing_academy/core/model/SendApi/userImageCredential.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/services/pushNotification.dart';
import 'package:turing_academy/core/viewModel/baseView.dart';
import 'package:turing_academy/core/viewModel/myprofile_viewmodel.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/profileImageWidget.dart';
import 'package:turing_academy/constants/assetsString.dart';

class MyProfile extends StatefulWidget {
  static const String routeName = "my-profile";
  GlobalKey<ScaffoldState> scaffoldkey ;
  MyProfile({this.scaffoldkey});
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ScrollController _scrollController;
  bool lastStatus = true;
  ResponseModel responseModel =
      new ResponseModel(isSUcessfull: null, responseMessage: null);
  bool _isLoading = false;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  var _phoneNumber = MaskedTextController(mask: AppConstant.phoneNumberFormate);
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController= TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  final _formKey2 = GlobalKey<FormState>();

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
    _nameController.text = loggedInUser.firstname;
    _lastNameController.text = loggedInUser.lastname;
    _phoneNumber.text = loggedInUser.phone;

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  void updDateProfile() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final UpdateProfileCredential updateProfileCredential = new UpdateProfileCredential(
          firstname: _nameController.text,
          lastname: _lastNameController.text,
          phone: _phoneNumber.text,
        fcmToken: await PushNotificationsManager().getToken()
          );
      ResponseMessage responseMessage = await Provider.of<UserViewModel>(context, listen: false)
          .updateProfile(updateProfileCredential);
      if (responseMessage.statuscode!=1) {
        AppConstant.showFialureDialogue(responseMessage.msg, context);

      } else {
        loggedInUser.firstname=_nameController.text;
        loggedInUser.lastname=_lastNameController.text;
        loggedInUser.phone=_phoneNumber.text;
        AppConstant.showSuccessDialogue(
            responseMessage.msg, context);
        Navigator.pop(context);
        if(Navigator.canPop(context)){
          Navigator.pop(context);
        }

      }
    } catch (e) {
      AppConstant.showFialureDialogue(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
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
    final model=Provider.of<UserViewModel>(context);
    final sidePadding = SizeConfig.screenWidth * .03;
    final verticalPadding = SizeConfig.screenHeight * .01;
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
          AppString.myprofile, // + _scrollController.offset.toString(),
          style: AppStyles.headingTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * .01,
                  bottom: SizeConfig.screenHeight * .01),
              child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  Form(
                    key: _formKey,
                   child: Column(
                     children: <Widget>[
                       BaseView<MyProfileViewModel>(
                         builder: (context,model,child){
                           if(model.state==ViewState.BUSY){
                             return AppConstant.circularInidcator();
                           }else{
                             return ProfileImageWidget(
                               height: SizeConfig.screenHeight * .12,
                               width: SizeConfig.screenHeight * .12,
                               imageUrl: loggedInUser.userImage,
                               onpictureChange: (image){

                                 model.updateUserImage(UserImageCredential(
                                     userId: loggedInUser.id,
                                     file: image
                                 ), context);
//                                 Provider.of<UserViewModel>(context,listen: false)
//                                     .updateUserImage(UserImageCredential(
//                                     userId: loggedInUser.id,
//                                     file: image
//                                 )).then((value){
//
//                                   if(value.statuscode==1){
//
//                                     AppConstant.showSuccessDialogue(value.msg, context);
//
//                                   }else{
//
//                                     AppConstant.showFialureDialogue(value.msg, context);
//
//                                   }
//                                 });
                               },
                             );
                           }
                         },
                       ),
                       SizedBox(
                         height: SizeConfig.screenHeight * .02,
                       ),
                       Center(
                           child: Text(
                             "${loggedInUser.firstname} ${loggedInUser.lastname}",
                             style: AppStyles.titleTextStyle,
                           )),
                       SizedBox(
                         height: SizeConfig.screenHeight * .005,
                       ),
                       Center(
                         child: Text(
                           loggedInUser.email,
                           style: AppStyles.verySmallRedTextStyle,
                         ),
                       ),
                       _devider(),
                       Padding(
                         padding: EdgeInsets.only(
                           left: sidePadding, right: sidePadding,
//                    top: verticalPadding,bottom: verticalPadding
                         ),
                         child: AppTextFormFieldWidget(
                           controller: _nameController,
                           labelText: "First Name",
                           obsecureText: false,
                           validator: (value) {
                             return AppConstant.stringValidator(
                                 value, "First Name");
                           },
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(
                           left: sidePadding, right: sidePadding,
//                    top: verticalPadding,bottom: verticalPadding
                         ),
                         child: AppTextFormFieldWidget(
                           controller: _lastNameController,
                           labelText: "Last Name",
                           obsecureText: false,
                           validator: (value) {
                             return AppConstant.stringValidator(
                                 value, "Last Name");
                           },
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(
                           left: sidePadding, right: sidePadding,
//                    top: verticalPadding,bottom: verticalPadding
                         ),
                         child: AppTextFormFieldWidget(
                           controller: _phoneNumber,
                           labelText: AppString.parentMobileNumber,
                           obsecureText: false,
                           validator: (value) {
                             return AppConstant.phoneValidator(
                                 value, 'Phone Number');

                           },
                         ),
                       ),
                       SizedBox(
                         height: SizeConfig.screenHeight * 0.05,
                       ),
                     ],
                   ),
                 ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: sidePadding,
                        right: sidePadding,
                        top: verticalPadding,
                        bottom: verticalPadding),
                    child: _isLoading
                        ? AppCircularProgress()
                        : AppBotton(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * .06,
                            title: AppString.updateProfile,
                            onTap: updDateProfile,
                          ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * .02,
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
