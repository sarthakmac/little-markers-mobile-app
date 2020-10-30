import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appColors.dart';
import 'package:turing_academy/constants/appConstants.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/appStyle.dart';
import 'package:turing_academy/constants/assetsString.dart';
import 'package:turing_academy/constants/sizeConfig.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/model/responseModel.dart';
import 'package:turing_academy/core/viewModel/kidViewModel.dart';
import 'package:turing_academy/providers/authProvider.dart';
import 'package:turing_academy/ui/widgets/AppBotton.dart';
import 'package:turing_academy/ui/widgets/appTextFieldWidget.dart';
import 'package:turing_academy/ui/widgets/profileImageWidget.dart';
import 'package:turing_academy/ui/widgets/smallAppBotton.dart';
import 'package:image_cropper/image_cropper.dart';

class AddKid extends StatefulWidget {
  final KidModel kid;
  final bool isUpdate;
  static const String routeName = '/addkid';

  const AddKid({Key key, this.kid, this.isUpdate}) : super(key: key);
  @override
  _AddKidState createState() => _AddKidState();
}

class _AddKidState extends State<AddKid> {

  File imageFile;
  var formatter = new DateFormat('yyyy-MM-dd');

  ResponseModel responseModel =
      new ResponseModel(isSUcessfull: null, responseMessage: null);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _educationController =
      new TextEditingController();
  final TextEditingController _schoolNameController =
      new TextEditingController();
  final TextEditingController _univeristyController =
      new TextEditingController();
  DateTime selectDate =DateTime.now();
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
    _firstNameController.text = widget.kid != null ? widget.kid.firstname : "";
    _lastNameController.text = widget.kid != null ? widget.kid.lastname : "";
    _dateOfBirthController.text = widget.kid != null ? widget.kid.dob : "";
    _educationController.text = widget.kid != null ? widget.kid.education : "";
    _schoolNameController.text = widget.kid != null ? widget.kid.school : "";
    _univeristyController.text =
        widget.kid != null ? widget.kid.university : "";

    Future.microtask((){
      Provider.of<KidViewModel>(context, listen: false).setState(ViewState.IDLE);
    });


    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _educationController.dispose();
    _schoolNameController.dispose();
    _univeristyController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
  Future<Null> _selectTime(BuildContext context) async {
    final DateTime pickedS = await showDatePicker(
        context: context,
        initialDate: DateTime(2000,8,8), builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );},
        firstDate: DateTime(1990, 8),
        lastDate: DateTime.now()
    );

    if (pickedS != null && pickedS != selectDate )

      print('pickedS########$pickedS');
      setState(() {
        selectDate = pickedS;
        _dateOfBirthController.text=formatter.format(selectDate);
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

  void updateKid() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }


    try {

      final KidCredentail kidModel = new KidCredentail(
          kidId:widget.kid!=null?widget.kid.id:0,
          id: widget.kid!=null?widget.kid.id:0,
          user_id: loggedInUser.id,
          firstname: _firstNameController.text,
          lastname: _lastNameController.text,
          dob: _dateOfBirthController.text,
          education: _educationController.text,
          school: _schoolNameController.text,
          university: _univeristyController.text,
          status: 'active',
          created_at: widget.kid?.createdAt,
          updated_at: widget.kid?.updatedAt);
      if (widget.isUpdate) {
        //update kid
        ResponseMessage responseMessage = await Provider.of<KidViewModel>(context, listen: false)
            .updateKidDetails(kidModel);
        if (responseMessage.statuscode!=1) {
          AppConstant.showFialureDialogue(
              responseMessage.msg, context);
        } else {
//          AppConstant.showSuccessDialogue(
//              responseMessage.msg, context);
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                return AlertDialog(
                  title: Text(
                    "Operation successful",
                    style: AppStyles.headingTextStyle,
                  ),
                  content: Text(
                    responseMessage.msg,
                    style: AppStyles.smallGreenTextStyle,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                       Navigator.pop(context);
                       Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        }
      } else {

        ResponseMessage responseMessage = await Provider.of<KidViewModel>(context, listen: false)
            .addKid(kidModel);
        if (responseMessage.statuscode!=1) {
          AppConstant.showFialureDialogue(
              responseMessage.msg, context);
        } else {
          _educationController.clear();
          _firstNameController.clear();
          _lastNameController.clear();
          _dateOfBirthController.clear();
          _schoolNameController.clear();
          _univeristyController.clear();
          if(imageFile!=null){
            Provider.of<KidViewModel>(context, listen: false).updateKidImage(responseMessage.kidId, imageFile);
          }

//          AppConstant.showSuccessDialogue(
//              responseMessage.msg, context);
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                return AlertDialog(
                  title: Text(
                    "Operation successful",
                    style: AppStyles.headingTextStyle,
                  ),
                  content: Text(
                    responseMessage.msg,
                    style: AppStyles.smallGreenTextStyle,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        }
      }
    } catch (e) {
      AppConstant.showFialureDialogue(e.toString(), context);
    }

    //move to kids list
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<KidViewModel>(context);
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
          widget.isUpdate
              ? AppString.updateKid
              : AppString.addkid, // + _scrollController.offset.toString(),
          style: AppStyles.headingTextStyle,
        ),
        centerTitle: true,
      ),
      body: model.state==ViewState.BUSY?AppConstant.circularInidcator():Form(
        key: _formKey,
        child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.screenHeight * .01),
                      child: ListView(
                        controller: _scrollController,
                        children: <Widget>[
                          ProfileImageWidget(
                            imageUrl: widget.kid?.image,
                            height: SizeConfig.screenHeight * .12,
                            width: SizeConfig.screenHeight * .12,
                            imageFile: imageFile,
                            onpictureChange: (image){

                             setState(() {
                               imageFile =image;
                             });
                              if(widget.isUpdate){
                                Provider.of<KidViewModel>(context,listen: false)
                                    .updateKidImage(widget.kid.id.toString(),image).then((value){

                                  if(value.statuscode==1){

                                    AppConstant.showSuccessDialogue(value.msg, context);

                                  }else{

                                    AppConstant.showFialureDialogue(value.msg, context);

                                  }
                                });
                              }
                            },
                          ),

                          SizedBox(
                            height: SizeConfig.screenHeight * .02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: sidePadding * 2,
                              right: sidePadding * 2,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SmallAppBotton(
                                    height: SizeConfig.screenHeight * .05,
                                    width: SizeConfig.screenWidth,
                                    title: AppString.capturePhoto,
                                    textStyle: AppStyles.smallerRedTextStyle,
                                    boderColor: AppColors.redBottonColor,
                                    onTap: ()async{
                                      final picker = ImagePicker();
                                      final file=await picker.getImage(source: ImageSource.camera);
                                      if(file!=null){
                                        imageFile = await ImageCropper.cropImage(
                                            sourcePath: file.path,
                                            aspectRatioPresets: Platform.isAndroid
                                                ? [
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio16x9
                                            ]
                                                : [
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio5x3,
                                              CropAspectRatioPreset.ratio5x4,
                                              CropAspectRatioPreset.ratio7x5,
                                              CropAspectRatioPreset.ratio16x9
                                            ],
                                            androidUiSettings: AndroidUiSettings(
                                                toolbarTitle: 'Cropper',
                                                toolbarColor: Colors.deepOrange,
                                                toolbarWidgetColor: Colors.white,
                                                initAspectRatio: CropAspectRatioPreset.original,
                                                lockAspectRatio: false),
                                            iosUiSettings: IOSUiSettings(
                                              title: 'Cropper',
                                            ));
                                        setState(() {

                                        });
                                        if(widget.isUpdate){
                                          Provider.of<KidViewModel>(context,listen: false)
                                              .updateKidImage(widget.kid.id.toString(),imageFile).then((value){

                                            if(value.statuscode==1){

                                              AppConstant.showSuccessDialogue(value.msg, context);

                                            }else{

                                              AppConstant.showFialureDialogue(value.msg, context);

                                            }
                                          });
                                        }
                                      }
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
                                    title: AppString.choosephoto,
                                    textStyle: AppStyles.smallerRedTextStyle,
                                    boderColor: AppColors.redBottonColor,
                                    onTap: ()async{
                                      final picker = ImagePicker();
                                      final file=await picker.getImage(source: ImageSource.gallery);
                                      if(file!=null){
                                        imageFile = await ImageCropper.cropImage(
                                            sourcePath: file.path,
                                            aspectRatioPresets: Platform.isAndroid
                                                ? [
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio16x9
                                            ]
                                                : [
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio5x3,
                                              CropAspectRatioPreset.ratio5x4,
                                              CropAspectRatioPreset.ratio7x5,
                                              CropAspectRatioPreset.ratio16x9
                                            ],
                                            androidUiSettings: AndroidUiSettings(
                                                toolbarTitle: 'Cropper',
                                                toolbarColor: Colors.deepOrange,
                                                toolbarWidgetColor: Colors.white,
                                                initAspectRatio: CropAspectRatioPreset.original,
                                                lockAspectRatio: false),
                                            iosUiSettings: IOSUiSettings(
                                              title: 'Cropper',
                                            ));
                                        setState(() {

                                        });
                                        if(widget.isUpdate){
                                          Provider.of<KidViewModel>(context,listen: false)
                                              .updateKidImage(widget.kid.id.toString(),imageFile).then((value){

                                            if(value.statuscode==1){

                                              AppConstant.showSuccessDialogue(value.msg, context);

                                            }else{

                                              AppConstant.showFialureDialogue(value.msg, context);

                                            }
                                          });
                                        }
                                      }

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * .01,
                          ),
                          _devider(),
                          Padding(
                            padding: EdgeInsets.only(
                              left: sidePadding, right: sidePadding,
//                      top: verticalPadding,bottom: verticalPadding
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: AppTextFormFieldWidget(
                                    controller: _firstNameController,
                                    labelText: AppString.firstName,
                                    obsecureText: false,
                                    validator: (value) {
                                      return AppConstant.stringValidator(
                                          value, AppString.firstName);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth * .05,
                                ),
                                Expanded(
                                  child: AppTextFormFieldWidget(
                                    controller: _lastNameController,
                                    labelText: AppString.lastName,
                                    obsecureText: false,
                                    validator: (value) {
                                      return AppConstant.stringValidator(
                                          value, AppString.lastName);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: sidePadding, right: sidePadding,
//                      top: verticalPadding,bottom: verticalPadding
                            ),
                            child: InkWell(
                              child: AppTextFormFieldWidget(
                                controller: _dateOfBirthController,
                                textInputType: TextInputType.number,
                                labelText: "Dob",
                                enabled: false,
                                obsecureText: false,

                                validator: (value) {

                                  return AppConstant.stringValidator(
                                      value, "Dob");
                                },
                              ),
                              onTap: (){
                                _selectTime(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: sidePadding, right: sidePadding,
//                      top: verticalPadding,bottom: verticalPadding
                            ),
                            child: AppTextFormFieldWidget(
                              controller: _educationController,
                              labelText: AppString.eduction,
                              obsecureText: false,
                              validator: (value) {
                                return AppConstant.stringValidator(
                                    value, AppString.eduction);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: sidePadding, right: sidePadding,
//                      top: verticalPadding,bottom: verticalPadding
                            ),
                            child: AppTextFormFieldWidget(
                              controller: _schoolNameController,
                              labelText: AppString.schoolName,
                              obsecureText: false,
                              validator: (value) {
                                return AppConstant.stringValidator(
                                    value, AppString.schoolName);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: sidePadding,
                                right: sidePadding,
                                bottom: verticalPadding),
                            child: AppTextFormFieldWidget(
                              controller: _univeristyController,
                              labelText: AppString.boardAndUniversity,
                              obsecureText: false,
                              validator: (value) {
                                return AppConstant.stringValidator(
                                    value, AppString.boardAndUniversity);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: sidePadding,
                                right: sidePadding,
                                top: verticalPadding,
                                bottom: verticalPadding),
                            child: AppBotton(
                              onTap: (){
                                if(widget.isUpdate){
                                  AppConstant.comfirmsDialogue(widget.isUpdate?'Really want to update Kid Details':'Really want to add Kid', context, updateKid);
                                }else{
                                  updateKid();
                                }

                              },
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight * .06,
                              title: widget.isUpdate
                                  ? AppString.updateKid
                                  : AppString.addkids,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
