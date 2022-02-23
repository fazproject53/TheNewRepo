import 'dart:io';

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
          SizedBox(height: 30.h,),
            padding(10, 12, Container( alignment : Alignment.topRight,child:  Text(' اطلب مساحتك الاعلانية', style: TextStyle(fontSize: 18.sp, color: textBlack , fontFamily: 'Cairo'), )),),

            SizedBox(height: 20.h,),
            paddingg(15, 15, 12,textFieldNoIcon(context, 'الاسم', 12, false, controlName,(String? value) {if (value == null || value.isEmpty) {
              return 'Please enter some text';} return null;},false),),
            paddingg(15, 15, 12,textFieldNoIcon(context, 'البريد الالكتروني', 12, false, controlEmail,(String? value) {if (value == null || value.isEmpty) {
              return 'Please enter some text';} return null;},false),),
            paddingg(15, 15, 12,textFieldDesc(context, 'الوصف الخاص بالمساحة', 12, false, controlDesc,(String? value) {if (value == null || value.isEmpty) {
              return 'Please enter some text';} return null;},),),


            const SizedBox(height: 20,),
            paddingg(15, 15, 12, uploadImg(200, 54,text(context, 'قم برفع الصورة التي تريد وضعها بالاعلان', 12, black),(){pickImage(image);}),),


            const SizedBox(height: 30,),
            padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'رفع الطلب', 15, white, (){})),),
            const SizedBox(height: 30,),
          ]),
          ),

          )))),
    );}


}