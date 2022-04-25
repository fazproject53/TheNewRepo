import 'dart:convert';
import 'dart:math';

import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'LoggingSingUpAPI.dart';
import 'UserForm.dart';

class SingUp extends StatefulWidget {
  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  GlobalKey<FormState> singUpKey = GlobalKey();
  bool? isChang = false;

  IconData error=Icons.error;
  IconData done=Icons.task_alt;


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
//main container--------------------------------------------------
          body: container(
        double.infinity,
        double.infinity,
        0,
        0,
        black,
//==============================container===============================================================

        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 170.h),
//استمتع يالتواصل--------------------------------------------------
              text(context, "استمتع بالتواصل", 20, white),
//انشاء حساب--------------------------------------------------
              text(context, "انشاء حساب", 15, darkWhite),
              SizedBox(
                height: 22.h,
              ),
//==============================buttoms===============================================================

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
//famus buttom-------------------------------------
                  gradientContainer(
                    130,
                    buttoms(
                      context,
                      'متابع',
                      12,
                      white,
                      () {
                        setState(() {
                          isChang = false;
                        });
                        // print("fallower$isChang");
                      },
                    ),
                    gradient: isChang! ? true : false,
                  ),
                  SizedBox(
                    width: 21.w,
                  ),
//follwer buttom-------------------------------------

                  gradientContainer(
                    130,
                    buttoms(
                      context,
                      'مشهور',
                      12,
                      white,
                      () {
                        setState(() {
                          isChang = true;
                        });
                        print("famus$isChang");
                      },
                    ),
                    gradient: isChang! ? false : true,
                  ),
                ],
              ),

              SizedBox(
                height: 30.h,
              ),
//=============================================================================================
              padding(
                  20,
                  20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
//====================================TextFields=========================================================
                      isChang! ? celebratyForm(context) : userForm(context),
//create account------------------------------
                      gradientContainer(
                          347,
                          buttoms(context, 'انشاء حساب', 14, white, () {
                            isChang == true
                                ? celebrityRegister(
                                    userNameCeleController.text,
                                    emailCeleController.text,
                                    passCeleController.text,
                                    celContry,
                                    celCatogary)
                                : userRegister(
                                    userNameUserController.text,
                                    emailUserController.text,
                                    passUserController.text,
                                    userContry);
                          })),
//singup with-----------------------------------------------------------
                      SizedBox(
                        height: 14.h,
                      ),
                      text(
                        context,
                        "او التسجيل من خلال",
                        12,
                        darkWhite,
                        align: TextAlign.center,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
//googel buttom-----------------------------------------------------------
                      solidContainer(
                          347,
                          white,
                          singWthisButtom(
                              context, "تسجيل دخول بجوجل", black, white, () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar('تمت العملية بنجاح',green,done));
                          }, googelImage)),
                      SizedBox(
                        height: 14.h,
                      ),
//facebook buttom-----------------------------------------------------------
                      solidContainer(
                          347,
                          darkBlue,
                          singWthisButtom(context, "تسجيل دخول فيسبوك", white,
                              darkBlue, () {}, facebookImage)),
                      SizedBox(
                        height: 27.h,
                      ),
//have Account buttom-----------------------------------------------------------
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              text(context, "هل لديك حساب بالفعل؟", 13,
                                  darkWhite),
                              SizedBox(
                                width: 7.w,
                              ),
                              InkWell(
                                child:
                                    text(context, "تسجيل الدخول", 13, purple),
                                onTap: () {
                                  goTopageReplacement(context, Logging());
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
//----------------------------------------------------------------------------------------------------------------------
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }

  celebrityRegister(String username, String email, String pass, String country,
      String catogary) async {
    if (celebratyKey.currentState?.validate() == true) {
      // print(username);  print(email);  print(pass);  print(country);  print(catogary);
      databaseHelper
          .celebrityRegister(username, pass, email, '1', '2')
          .then((result) {
        if (result == "celebrity") {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar('تمت العملية بنجاح',green,done));
        } else if (result == "email and username found") {
          ScaffoldMessenger.of(context).showSnackBar(snackBar(
              'البريد الالكتروني واسم المستخدم موجود سابقا',
              red,error));
        } else if (result == "username found") {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar('اسم المستخدم موجود سابقا', red,error));
        } else if (result == 'email found') {
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar('البريد الالكتروني موجود سابقا', red,error));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar('توجد مشكله في استرجاع البيانات', red,error));
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('تاكد من تعبئة كل الحقول',red,error));
    }
  }

  userRegister(String username, String email, String pass, String country) {
    if (userKey.currentState?.validate() == true) {
      // print(username);  print(email);  print(pass);  print(country);
      databaseHelper.userRegister(username, pass, email, '1').then((result) {
        if (result == "user") {
          print("تم التسسسسسسسسسسسجيل بنجاح user ");
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar('تمت العملية بنجاح',green,error));
        } else if (result == "email and username found") {
          ScaffoldMessenger.of(context).showSnackBar(snackBar(
              'البريد الالكتروني واسم المستخدم موجود سابقا',
              red,error));
        } else if (result == "username found") {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar('اسم المستخدم موجود سابقا', red,error));
        } else if (result == 'email found') {
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar('البريد الالكتروني موجود سابقا', red,error));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar('توجد مشكله في استرجاع البيانات',red,error));
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('تاكد من تعبئة كل الحقول',red,error));
    }
  }

  SnackBar snackBar(String title, Color? color,IconData? icon) {
    return SnackBar(
        backgroundColor: color ?? white,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
        elevation: 20,
        // behavior: SnackBarBehavior.floating,

        content: Row(
          children: [
            Icon(icon,color: white,size: 20.sp,),
            SizedBox(width: 5.w,),
            text(context, title, 13,white)
          ],
        ));
  }
}
