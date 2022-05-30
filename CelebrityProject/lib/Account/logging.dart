import 'dart:convert';

import 'package:celepraty/Account/ResetPassword/Reset.dart';
import 'package:celepraty/Account/ResetPassword/VerifyToken.dart';
import 'package:celepraty/MainScreen/main_screen_navigation.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'LoggingSingUpAPI.dart';
import 'Singup.dart';
import 'UserForm.dart';



class Logging extends StatefulWidget {
  const Logging({Key? key}) : super(key: key);

  @override
  State<Logging> createState() => _LoggingState();
}

class _LoggingState extends State<Logging> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isChckid = false;
  final TextEditingController lgoingEmailConttroller = TextEditingController();
  final TextEditingController lgoingPassConttroller = TextEditingController();
  GlobalKey<FormState> logKey = GlobalKey();
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
//مرحبا بك مره اخري--------------------------------------------------
              text(context, "مرحبا بك مرة اخري", 20, white),
//تسجيل الدخول--------------------------------------------------
              text(context, "تسجيل الدخول", 15, darkWhite),
              SizedBox(
                height: 22.h,
              ),

//=============================================================================================
              padding(
                  20,
                  20,
                  Form(
                    key: logKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
//====================================TextFields=========================================================

//email------------------------------------------
                        textField(
                            context,
                            emailIcon,
                            "البريد الالكتروني او اسم المستخدم",
                            12,
                            false,
                            lgoingEmailConttroller,
                            empty),
                        SizedBox(
                          height: 15.h,
                        ),
//pass------------------------------------------
                        textField(context, passIcon, "كلمة المرور", 12, true,
                            lgoingPassConttroller, valedpass),
                        SizedBox(
                          height: 15.h,
                        ),
//remember me && forget pass------------------------------------------
                        rememberMe(),
                        SizedBox(
                          height: 15.h,
                        ),
//logging buttom-----------------------------------------------------------------------------
                        gradientContainer(
                            347,
                            buttoms(context, 'تسجيل الدخول', 14, white, () {
                              if (logKey.currentState?.validate() == true) {
                                loadingDialogue(context);
                                databaseHelper
                                    .loggingMethod(lgoingEmailConttroller.text,
                                        lgoingPassConttroller.text)
                                    .then((result) {
//if user select remember me----------------------------------------------------------------------------

                                  if (isChckid) {
                                    if (result == "user") {
                                      DatabaseHelper.saveRememberToken(result);
                                      Navigator.pop(context);
                                      DatabaseHelper.saveRememberUser("user");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const MainScreen()));
                                    } else if (result == "celebrity") {
                                      DatabaseHelper.saveRememberToken(result);
                                      Navigator.pop(context);
                                      DatabaseHelper.saveRememberUser(
                                          "celebrity");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const MainScreen()));
                                    } else if (result ==
                                        "Invalid Credentials") {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar(
                                              context,
                                              'خطأ في كلمة المرور او اسم المستخدم',
                                              red,
                                              error));
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar(
                                              context,
                                              'تاكد من ملء جميع الحقول',
                                              red,
                                              error));
                                    }
//if user not select remember me----------------------------------------------------------------------------
                                  } else {
                                    if (result == "user") {
                                      DatabaseHelper.saveRememberUser("user");
                                      Navigator.pop(context);
                                      setState(() {
                                        currentuser = "user";
                                      });

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const MainScreen()));
                                    } else if (result == "celebrity") {
                                      DatabaseHelper.saveRememberUser(
                                          "celebrity");

                                      Navigator.pop(context);
                                      setState(() {
                                        currentuser = "famous";
                                      });

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const MainScreen()));
                                    } else if (result ==
                                        "Invalid Credentials") {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar(
                                              context,
                                              'خطأ في كلمة المرور او اسم المستخدم',
                                              red,
                                              error));
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar(
                                              context,
                                              'تاكد من ملء جميع الحقول',
                                              red,
                                              error));
                                    }
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar(context, 'تاكد من تعبئة كل الحقول',
                                        red, error));
                              }
                            })),
                        SizedBox(
                          height: 34.h,
                        ),
//have Account buttom-----------------------------------------------------------
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                text(context, "ليس لديك حساب بالفعل؟", 13,
                                    darkWhite),
                                SizedBox(
                                  width: 7.w,
                                ),
                                InkWell(
                                    child:
                                        text(context, "انشاء حساب", 13, purple),
                                    onTap: () {
                                      goTopageReplacement(context, SingUp());
                                    }),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
//----------------------------------------------------------------------------------------------------------------------
                      ],
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }

//-------------------------------------------------------
  Widget rememberMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
                child: Icon(Icons.check_circle_rounded,
                    color: isChckid ? purple : ligthtBlack, size: 23.sp),
                onTap: () {
                  setState(() {
                    isChckid = !isChckid;
                  });
                }),
            SizedBox(
              width: 4.w,
            ),
            text(context, 'تذكرني', 17.sp, textBlack),
          ],
        ),
        // SizedBox(
        //   width: 180.w,
        // ),
        InkWell(
            onTap: () {
              forgetPassword('tatooo7331@gmail.com');
            },
            child: text(context, 'هل نسيت كلمة المرور؟', 14.sp, purple)),
      ],
    );
  }

//---------------------------------------------------------------------

  void forgetPassword(String username) async {
    getCreatePassword(username).then((result) {
      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar(context,
            'تم ارسال رمز التحقق علي البريد الالكتروني الخاص بك', green, done));
        print('تم ارسال كود في البريد الالكتروني');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar(context, 'المستخدم غير موجود', red, error));
      }
    });
  }

//--------------------------------------------------------------------------------

  Future<String?> verifyCode(String username, int code) async {
    getVerifyCode(username, code).then((sendCode) async {
      if (sendCode == 'not verified') {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar(context, 'الرمز المدخل خاطئ', red, error));
      } else {
        verifyToken();
      }
    });
    return '';
  }

//-----------------------------------------------------------------------------------------------
  void verifyToken() async {
    getVerifyToken(forgetToken).then((sendToken) async {
      if (sendToken == true) {
        getResetPassword(
                'tatooo7331@gmail.com', '123123', '123123', forgetToken)
            .then((value) {
          if (value == true) {
            ScaffoldMessenger.of(context).showSnackBar(
                snackBar(context, 'تم استعادة كلمة المرور بنجاح', green, done));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackBar(
                context, 'حدث خطا عليك اعادة الخطوات من البداية', red, error));
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBar(context, 'لم يتممممم التحقق من التوكن', red, error));
      }
    });
  }
}
