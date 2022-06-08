import 'dart:convert';
import 'dart:math';

import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/MainScreen/main_screen_navigation.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../ModelAPI/ModelsAPI.dart';
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
  List<String> countries = [];
  List<String> celebrityCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetCelebrityCategories();
    fetCountries();
  }

//getCountries--------------------------------------------------------------------
  fetCountries() async {
    String serverUrl = 'https://mobile.celebrityads.net/api';
    String url = "$serverUrl/countries";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (int i = 0; i < body['data'].length; i++) {
        setState(() {
          countries.add(body['data'][i]['name']);
        });
      }

      print('countries is:$countries');
      return countries;
    } else {
      throw Exception('Failed to load  countries');
    }
  }

  //get celebrity Categories--------------------------------------------------------------------
  fetCelebrityCategories() async {
    String serverUrl = 'https://mobile.celebrityads.net/api';
    String url = "$serverUrl/categories";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (int i = 0; i < body['data'].length; i++) {
        celebrityCategories.add(body['data'][i]['name']);
      }
      print(celebrityCategories);

      return celebrityCategories;
    } else {
      throw Exception('Failed to load celebrity catogary');
    }
  }

//--------------------------------------------------------------------------------
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
//famous buttom-------------------------------------
                  gradientContainer(
                    130,
                    buttoms(
                      context,
                      'متابع',
                      12,
                      white,
                      () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          isChang = false;
                        });
                        // print("follower$isChang");
                      },
                    ),
                    gradient: isChang! ? true : false,
                  ),
                  SizedBox(
                    width: 21.w,
                  ),
//follower buttom-------------------------------------

                  gradientContainer(
                    130,
                    buttoms(
                      context,
                      'مشهور',
                      12,
                      white,
                      () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          isChang = true;
                        });
                        print("famous$isChang");
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
                          ? celebratyForm(
                              context, countries, celebrityCategories)
                          : userForm(context, countries),
                      gradientContainer(
                          347,
                          buttoms(context, 'انشاء حساب', 14, white, () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            isChang == true
                                ?
                                //create famous account------------------------------
                                celebrityRegister(
                                    userNameCeleController.text,
                                    emailCeleController.text,
                                    passCeleController.text,
                                    '$celContry',
                                    '$celCatogary')
                                :
                                //create user account------------------------------
                                userRegister(
                                    userNameUserController.text,
                                    emailUserController.text,
                                    passUserController.text,
                                    '$userContry');
                          })),
//signup with-----------------------------------------------------------
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
//google buttom-----------------------------------------------------------
                      solidContainer(
                          347,
                          white,
                          singWthisButtom(
                              context, "تسجيل دخول بجوجل", black, white, () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(
                                context, 'تمت العملية بنجاح', green, done));
                          }, googelImage)),
                      SizedBox(
                        height: 14.h,
                      ),
//facebook buttom-----------------------------------------------------------
                      solidContainer(
                          347,
                          darkBlue,
                          singWthisButtom(
                              context, "تسجيل دخول فيسبوك", white, darkBlue,
                              () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }, facebookImage)),
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
                                  FocusManager.instance.primaryFocus?.unfocus();
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

  //----------------------------------------------------------------------------------------------------------------------
  celebrityRegister(String username, String email, String pass, String country,
      String catogary) async {
    if (celebratyKey.currentState?.validate() == true) {
      loadingDialogue(context);
      databaseHelper
          .celebrityRegister(username, pass, email, country, catogary)
          .then((result) {
        // Navigator.pop(context);
        if (result == "celebrity") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'تمت انشاء حساب مشهور بنجاح', green, done));
          setState(() {
            currentuser = "famous";
          });
          goTopageReplacement(context, const MainScreen());
        } else if (result == "email and username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBar(context,
              'البريد الالكتروني واسم المستخدم موجود سابقا', red, error));
        } else if (result == "username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'اسم المستخدم موجود سابقا', red, error));
        } else if (result == 'email found') {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'البريد الالكتروني موجود سابقا', red, error));
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'توجد مشكله في استرجاع البيانات', red, error));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar(context, 'تاكد من تعبئة كل الحقول', red, error));
    }
  }

//------------------------------------------------------------------------------
  userRegister(String username, String email, String pass, String country) {
    if (userKey.currentState?.validate() == true) {
      loadingDialogue(context);
      databaseHelper
          .userRegister(username, pass, email, country)
          .then((result) {
        if (result == "user") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'تمت انشاء حساب مستخدم بنجاح', green, done));
          setState(() {
            currentuser = "user";
          });
          goTopageReplacement(context, const MainScreen());
        } else if (result == "email and username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBar(context,
              'البريد الالكتروني واسم المستخدم موجود سابقا', red, error));
        } else if (result == "username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'اسم المستخدم موجود سابقا', red, error));
        } else if (result == 'email found') {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'البريد الالكتروني موجود سابقا', red, error));
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, 'توجد مشكله في استرجاع البيانات', red, error));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar(context, 'تاكد من تعبئة كل الحقول', red, error));
    }
  }
}
