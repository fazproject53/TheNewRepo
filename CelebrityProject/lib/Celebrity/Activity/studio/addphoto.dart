import 'dart:io';

import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class addphoto extends StatefulWidget{

  _addphotoState createState() => _addphotoState();
}

class _addphotoState extends State<addphoto> {

  final _formKey = GlobalKey<FormState>();
 TextEditingController controlphototitle = new TextEditingController();
   TextEditingController controlphotodesc = new TextEditingController();

  File? newsimage;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Form(        key: _formKey,

                      child: paddingg(12, 12, 5, Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            padding(10, 12, Container( alignment : Alignment.topRight,child:  Text(' اضافة صورة جديدة', style: TextStyle(fontSize: 18.sp, color: textBlack , fontFamily: 'Cairo'), )),),

                            SizedBox(height: 20.h,),

                            paddingg(15, 15, 12,textFieldNoIcon(context, 'عنوان الصورة', 14, false, controlphototitle,(String? value) {if (value == null || value.isEmpty) {
                              return 'Please enter some text';} return null;},false),),
                            paddingg(15, 15, 12,textFieldDesc(context, 'وصف الصورة', 14, false, controlphotodesc,(String? value) {if (value == null || value.isEmpty) {
                              return 'Please enter some text';} return null;}),),


                            SizedBox(height: 20.h),
                            paddingg(15, 15, 12, uploadImg(200, 54,text(context, 'قم برفع صورة ', 12, black),(){pickImage(image);}),),

                            SizedBox(height: 20.h),
                            padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'اضافة ', 15, white, (){})),),
                            const SizedBox(height: 30,),
                          ]),
                      ),

                    ))
            )
        ),
      ),
    );
  }
}