import 'dart:convert';

import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'UserForm.dart';

class SingUp extends StatefulWidget {
  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  GlobalKey<FormState>singUpKey=GlobalKey();
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
          child: Form(
            key: singUpKey,
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
                        isChang!
                            ? userForm(context, true)
                            : userForm(context, false),
//create account------------------------------
                        gradientContainer(
                            347,
                            buttoms(context, 'انشاء حساب', 14, white, () {
                              isChang == true
                                  ? famusSingUpMethod(
                                      "مشهور",
                                      userNameConttroller.text,
                                      emailConttroller.text,
                                      passConttroller.text,
                                      "الدولة",
                                      "كوميدي")
                                  : fallowerSingUpMethod(
                                      "متابع",
                                      userNameConttroller.text,
                                      emailConttroller.text,
                                      passConttroller.text,
                                      "الدولة");
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
        ),
      )),
    );
  }

  famusSingUpMethod(String userType, String username, String email, String pass,
      String country, String catogary) async {
   if(singUpKey.currentState?.validate()==true){
     try {
       Map<String, dynamic> user = {
         "username": username,
         "email": email.trim(),
         "password": pass,
         "country_id": 1,
         "category_id": 1,
       };
       const url = "https://mobile.celebrityads.net/api/celebrity/register";
       var response = await http.post(Uri.parse(url), body: jsonEncode(user));
       if (response.statusCode == 201) {
         print("donnnnnnnnnnnnnnnnnne");
       } else {
         print(response.statusCode);
       }
     } catch (e) {
       print(e.toString());
       print(userType);
     }
   }else{
     //show snakpar
     print("fill all fields");
   }

  }

  fallowerSingUpMethod(String userType, String username, String email,
      String pass, String country) {
    //print(userType);
  }

  // void singUpMethod(String text, String text2, String text3) {
  //   try {
  //     Map<String, dynamic> user = {
  //       "username": "alaa",
  //       "email": "alaaALAA ",
  //       "password": "123456789",
  //       "country_id": 1,
  //       "category_id": 1,
  //     };
  //     // Map<String,dynamic>user={
  //     //   "username": "wafaabasil1996_10@gmail.com",
  //     //   "password": "123456789",
  //     // };
  //     const url = "https://mobile.celebrityads.net/api/celebrity/register";
  //     var response = await http.post(Uri.parse(url), body: jsonEncode(user));
  //     if (response.statusCode == 201) {
  //       print("donnnnnnnnnnnnnnnnnne");
  //     } else {
  //       print(response.statusCode);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
