
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:turing_academy/constants/appStrings.dart';
import 'package:turing_academy/constants/sizeConfig.dart';

class FormMaterial extends StatefulWidget {
  @override
  _FormMaterialState createState() => _FormMaterialState();
}

class _FormMaterialState extends State<FormMaterial> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyTwo = GlobalKey<FormState>();
  // final _user = User();
  int formno=1;
  String questionTypeValue;
  String selectCategory;
  String selectCorrectAnswer;
  List questionTypes=['Mock Test-1',"Mock Test-2",'Category'];
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    Provider.of<QuestionViewModel>(context,listen: false).getCategorylist();
//
//  }
  TextEditingController questionController=TextEditingController();
  TextEditingController optionAController=TextEditingController();
  TextEditingController optionBController=TextEditingController();
  TextEditingController optionCController=TextEditingController();
  TextEditingController optionDController=TextEditingController();
  TextEditingController answerController=TextEditingController();
  TextEditingController answerDiscription=TextEditingController();
  Uint8List imageByte;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        margin: EdgeInsets.fromLTRB(64, 32, 64, 64),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: formno== 1? Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButton<String>(
                          items: questionTypes.map((item) {
                            return new DropdownMenuItem(
                              child:SizedBox(
                                width: SizeConfig.screenWidth,
                                child: new Text(
                                  item,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              value: item.toString(),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              questionTypeValue = value;
                            });
                          },
                          hint: SizedBox(
                              width: SizeConfig.screenWidth,
                              child: Text(AppString.addkid)),
                          value: questionTypeValue,
                        ),
//                            questionTypeValue==AppStrings.category?DropdownButton<String>(
//                              items: model.categories.map((item) {
//                                return new DropdownMenuItem(
//                                  child:SizedBox(
//                                    width: SizeConfig.screenWidth,
//                                    child: new Text(
//                                      item.name,
//                                      style: TextStyle(fontSize: 14.0),
//                                    ),
//                                  ),
//                                  value: item.name.toString(),
//                                );
//                              }).toList(),
//                              onChanged: (String value) {
//                                setState(() {
//                                  selectCategory = value;
//                                });
//                              },
//                              hint: SizedBox(
//                                  width: SizeConfig.screenWidth,
//                                  child: Text(AppStrings.selectQuestionType)),
//                              value: selectCategory,
//                            ):Container(),

//                            AppTextField(
//                              controller: questionController,
//                              autofocus: false,
//                              lableText: AppStrings.question,
//                              validator: (value)=>AppConstant.stringValidator(value, AppStrings.password),
//
//                            ),
//                        SizedBox(
//                          height: SizeConfig.screenHeight*.02,
//                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text('uploadImage')),
                              Icon(Icons.attach_file)
                            ],
                          ),
                          onTap: ()async{
//                                imageByte =
//                                await ImagePickerWeb.getImage(outputType: ImageType.bytes);
//
//                                if (imageByte!= null) {
//                                  debugPrint(imageByte.toString());
//                                }
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight*.01,
                        ),
                        imageByte!=null?Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight*.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(imageByte),),
                              borderRadius: BorderRadius.circular(20)
                          ),

                        ):Container(),
//                            SizedBox(
//                              height: SizeConfig.screenHeight*.02,
//                            ),
//                            AppTextField(
//                              controller: optionAController,
//                              autofocus: false,
//                              lableText: AppStrings.optionA,
//                              validator: (value){
//                                if (value.isEmpty) {
//                                  return 'Please enter Option-A';
//                                }else if(value==optionDController.text||value==optionBController.text||value==optionCController.text){
//                                  return 'Answer not be same';
//
//                                }
//                                return null;
//
//                              },
//
//                            ),
//                            AppTextField(
//                              controller: optionBController,
//                              autofocus: false,
//                              lableText: AppStrings.optionB,
//                              validator: (value){
//                                if (value.isEmpty) {
//                                  return 'Please enter Option-B';
//                                }else if(value==optionAController.text||value==optionDController.text||value==optionCController.text){
//                                  return 'Answer not be same';
//
//                                }
//                                return null;
//
//                              },
//
//                            ),
//                            AppTextField(
//                              controller: optionCController,
//                              autofocus: false,
//                              lableText: AppStrings.optionC,
//                              validator: (value){
//                                if (value.isEmpty) {
//                                  return 'Please enter Option-C';
//                                }else if(value==optionAController.text||value==optionBController.text||value==optionDController.text){
//                                  return 'Answer not be same';
//
//                                }
//                                return null;
//
//                              },
//
//                            ),
//                            AppTextField(
//                              controller: optionDController,
//                              autofocus: false,
//                              lableText: AppStrings.optionD,
//                              validator: (value){
//                                if (value.isEmpty) {
//                                  return 'Please enter Option-D';
//                                }else if(value==optionAController.text||value==optionBController.text||value==optionCController.text){
//                                  return 'Answer not be same';
//
//                                }
//                                return null;
//
//                              },
//
//                            ),


                        Container(
                            height: 80,
                            // margin: EdgeInsets.only(left: 200, right: 200),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: RaisedButton(
//                                    color: ColorConstants.blue,
                                onPressed: () {

                                },
                                child: Text(
                                  'AppStrings.next',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ))),
                      ])) : Form(
                  key: _formKeyTwo,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
//                            DropdownButton<String>(
//                              items: ['model.question.questionOption.optionA', model.question.questionOption.optionB, model.question.questionOption.optionC,
//                                model.question.questionOption.optionD].map((item) {
//                                return new DropdownMenuItem(
//                                  child:SizedBox(
//                                    width: SizeConfig.screenWidth,
//                                    child: new Text(
//                                      item,
//                                      style: TextStyle(fontSize: 14.0),
//                                    ),
//                                  ),
//                                  value: item.toString(),
//                                );
//                              }).toList(),
//                              onChanged: (String value) {
//                                setState(() {
//                                  selectCorrectAnswer = value;
//                                });
//                              },
//                              hint: SizedBox(
//                                  width: SizeConfig.screenWidth,
//                                  child: Text("Please choose answer")),
//                              value: selectCorrectAnswer,
//                            ),
//                            AppTextField(
//                              controller: answerDiscription,
//                              autofocus: false,
//                              lableText: AppStrings.answerDiscription,
//                              validator: (value){
//                                if (value.isEmpty) {
//                                  return 'Please enter Discription';
//                                }
//                                return null;
//
//                              },
//
//                            ),


                        Container(
                            height: 80,
                            // margin: EdgeInsets.only(left: 200, right: 200),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: RaisedButton(
//                                    color: ColorConstants.blue,
                                onPressed: () {


                                },
                                child: Text(
                                  'AppStrings.submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                ))),
                      ]))),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
