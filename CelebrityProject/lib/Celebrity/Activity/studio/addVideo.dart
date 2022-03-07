
import 'dart:io';

import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class addVideo extends StatefulWidget{

  _addVideoState createState() => _addVideoState();
}

class _addVideoState extends State<addVideo> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController controlvideotitle = new TextEditingController();
  TextEditingController controlvideodesc = new TextEditingController();

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
                            padding(10, 12, Container( alignment : Alignment.topRight,child:  Text(' اضافة فيديو جديد', style: TextStyle(fontSize: 18.sp, color: textBlack , fontFamily: 'Cairo'), )),),

                            SizedBox(height: 20.h,),

                            paddingg(15, 15, 12,textFieldNoIcon(context, 'عنوان الفيديو', 14, false, controlvideotitle,(String? value) {if (value == null || value.isEmpty) {
                              return 'Please enter some text';} return null;},false),),
                            paddingg(15, 15, 12,textFieldDesc(context, 'وصف الفيديو', 14, false, controlvideodesc,(String? value) {if (value == null || value.isEmpty) {
                              return 'Please enter some text';} return null;}),),


                            SizedBox(height: 20.h),
                            paddingg(15, 15, 12, uploadImg(200, 54,text(context, 'قم برفع فيديو ', 12, black),(){pickImage(image);}),),

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