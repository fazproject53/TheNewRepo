import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/Variables.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'UserForm.dart';

class SingUp extends StatefulWidget {
 
  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
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
              text(context, "استمتع بالتواصل", 18, white),
//انشاء حساب--------------------------------------------------
              text(context, "انشاء حساب", 13, darkWhite),
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
                      gradientContainer(347,
                          buttoms(context, 'انشاء حساب', 13, white, () {})),
//singup with-----------------------------------------------------------
                      SizedBox(
                        height: 14.h,
                      ),
                      text(context, "او التسجيل من خلال", 9, darkWhite),
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
                              text(context, "هل لديك حساب بالفعل؟", 12,
                                  darkWhite),
                              SizedBox(
                                width: 7.w,
                              ),
                              InkWell(child: text(context, "تسجيل الدخول",12, purple),onTap: (){goTopageReplacement(context,  Logging());},),
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
}
