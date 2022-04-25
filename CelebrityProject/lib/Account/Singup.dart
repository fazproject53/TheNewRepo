import 'dart:convert';

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
                                    celContry!,
                                    celCatogary!)
                                : userRegister(
                                    userNameUserController.text,
                                    emailUserController.text,
                                    passUserController.text,
                                    userContry!);
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
                          singWthisButtom(context, "تسجيل دخول بجوجل", black,
                              white, () {}, googelImage)),
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
          print("تم التسسسسسسسسسسسجيل بنجاح");
        } else if (result == "email and username found") {
          print('email and username foundddddddddddd');
        } else if (result == "username found") {
          print('username founddddddddddddddddddd');
        } else if (result == 'email found') {
          print('email foundddddddddddddddddddddd');
        } else {
          print('objecttttttttttttttt');
        }
      });
    } else {
      //show snakpar
      print("fill all fields");
    }
  }

  userRegister(String username, String email, String pass, String country) {
    if (userKey.currentState?.validate() == true) {
      // print(username);  print(email);  print(pass);  print(country);
      databaseHelper.userRegister(
          username, pass, email, '1') .then((result) {
        if (result == "user") {
          print("تم التسسسسسسسسسسسجيل بنجاح user ");
        } else if (result == "email and username found") {
          print('user email and username foundddddddddddd');
        } else if (result == "username found") {
          print('username founddddddddddddddddddd');
        } else if (result == 'email found') {
          print('user email foundddddddddddddddddddddd');
        } else {
          print('user objecttttttttttttttt');
        }
      });;
    } else {
      //show snakpar
      print("fill all fields");
    }
  }
}
