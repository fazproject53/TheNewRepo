import 'dart:io';

import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class advArea extends StatefulWidget{
  _advAreaState createState() => _advAreaState();
}

class _advAreaState extends State<advArea>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controlName = new TextEditingController();
  final TextEditingController controlEmail = new TextEditingController();
  final TextEditingController controlDesc = new TextEditingController();

  File? image;
  static DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: drowAppBar('مساحة اعلانية', context),
          body: SingleChildScrollView(
          child: Container(
          child: Form(
          key: _formKey,
          child: paddingg(12, 12, 5, Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          SizedBox(height: 120.h,),
            padding(10, 12, Container( alignment : Alignment.topRight,child:  Text(' اطلب مساحتك الاعلانية', style: TextStyle(fontSize: 18.sp, color: textBlack , fontFamily: 'Cairo'), )),),

            SizedBox(height: 20.h,),

            paddingg(15, 15, 12,textFieldNoIcon(context, 'رابط صفحة المعلن', 14, false, controlEmail,(String? value) {if (value == null || value.isEmpty) {
              return 'Please enter some text';} return null;},false),),



             SizedBox(height: 20.h),
            paddingg(15, 15, 12, uploadImg(200, 54,text(context, 'قم برفع الصورة التي تريد وضعها بالاعلان', 12, black),(){pickImage(image);}),),

            SizedBox(height: 20.h),
            InkWell(
              child: padding(0.w,15.w, Row(children: [
                  GradientIcon(scheduale, 30, const LinearGradient(
                    begin: Alignment(0.7, 2.0),
                    end: Alignment(-0.69, -1.0),
                    colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                    stops: [0.0, 1.0],
                  ),),
                 SizedBox(width: 10.w,),
                  text(context, 'تاريخ الاعلان', 12, black)
                ],),
              ),
              onTap: (){ tableCalendar(context, dateTime);},
            ),
            const SizedBox(height: 30,),
            padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'رفع الطلب', 15, white, (){})),),
            const SizedBox(height: 30,),
          ]),
          ),

          )))),
    );}


}