import 'dart:convert';
import 'dart:math';

import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Celebrity/TechincalSupport/contact_with_us.dart';
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
  late Image image1;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    image1= Image.asset("assets/image/singup.jpg");
    fetCelebrityCategories();
    fetCountries();
  }
  @override
  void didChangeDependencies() {
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }
//getCountries--------------------------------------------------------------------
  fetCountries() async {
    String serverUrl = 'https://mobile.celebrityads.net/api';
    String url = "$serverUrl/countries";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (int i = 0; i < body['data'].length; i++) {
        if (mounted) {
          setState(() {
            countries.add(body['data'][i]['name']);
          });
        }
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
        if (mounted) {
          setState(() {
            celebrityCategories.add(body['data'][i]['name']);
          });
        }
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
          body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color:Colors.black ,
            image: DecorationImage(
                image:  image1.image,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                fit: BoxFit.cover)),
        child:
//==============================container===============================================================

            SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60.h),
//logo---------------------------------------------------------------------------
              Image.asset(
                'assets/image/log.png',
                fit: BoxFit.contain,
                height: 150.h,
                width: 150.w,
              ),
//???????????? ????????????????--------------------------------------------------
              text(context, "?????????? ???? ???? ???????? ????????????????", 20,
                 white),
//?????????? ????????--------------------------------------------------
              text(context, "???????? ?????????? ????????", 17, white),
              SizedBox(
                height: 22.h,
              ),
//==============================buttoms===============================================================

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
//famous buttom-------------------------------------
                    gradientContainer(
                        140,
                        buttoms(
                          context,
                          '??????????',
                          14,
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
                        color: isChang == false ? Colors.transparent : Colors.white),
                    SizedBox(
                      width: 21.w,
                    ),
//follower buttom-------------------------------------

                    gradientContainer(
                        140,
                        buttoms(
                          context,
                          '??????????',
                          14,
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
                        color: isChang! ? Colors.transparent : Colors.white),
                  ],
                ),
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
                          buttoms(
                            context,
                            '?????????? ????????',
                            15,
                            white,
                            () {
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
                            },
                          ),
                          color: Colors.transparent),
//signup with text-----------------------------------------------------------
                      SizedBox(
                        height: 14.h,
                      ),
                      registerVi(),
                      //signup with bottom----------------------------------------------------------------------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //google buttom-----------------------------------------------------------
                          singWithsButtom(
                              context, "?????????? ???????? ??????????", black, white, () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(
                                context, '?????? ?????????????? ??????????', green, done));
                          }, googelImage),
                          SizedBox(
                            width: 30.h,
                          ),
//facebook buttom-----------------------------------------------------------
                          singWithsButtom(
                              context, "?????????? ???????? ????????????", white, darkBlue,
                              () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }, facebookImage),
                        ],
                      ),
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
                              text(context, "???? ???????? ???????? ??????????????", 14,
                                  white),
                              SizedBox(
                                width: 7.w,
                              ),
                              InkWell(
                                child: text(context, "?????????? ????????????", 14,
                                    Colors.grey),
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
              snackBar(context, '?????? ?????????? ???????? ?????????? ??????????', green, done));
          setState(() {
            currentuser = "famous";
          });
          goTopageReplacement(context, const MainScreen());
        } else if (result == "email and username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBar(context,
              '???????????? ???????????????????? ???????? ???????????????? ?????????? ??????????', red, error));
        } else if (result == "username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, '?????? ???????????????? ?????????? ??????????', red, error));
        } else if (result == 'email found') {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, '???????????? ???????????????????? ?????????? ??????????', red, error));
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, '???????? ?????????? ???? ?????????????? ????????????????', red, error));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar(context, '???????? ???? ?????????? ???? ????????????', red, error));
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
              snackBar(context, '?????? ?????????? ???????? ???????????? ??????????', green, done));
          setState(() {
            currentuser = "user";
          });
          goTopageReplacement(context, const MainScreen());
        } else if (result == "email and username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBar(context,
              '???????????? ???????????????????? ???????? ???????????????? ?????????? ??????????', red, error));
        } else if (result == "username found") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, '?????? ???????????????? ?????????? ??????????', red, error));
        } else if (result == 'email found') {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, '???????????? ???????????????????? ?????????? ??????????', red, error));
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar(context, '???????? ?????????? ???? ?????????????? ????????????????', red, error));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar(context, '???????? ???? ?????????? ???? ????????????', red, error));
    }
  }

//--------------------------------------------------------------------------------------
  Widget registerVi() {
    return SizedBox(
        width: double.infinity,
        height: 70.h,
        child: Row(children: <Widget>[
          const Expanded(
              child: Divider(
            color: Colors.grey,
            thickness: 1.3,
          )),
          SizedBox(
            width: 8.w,
          ),
          Center(
            child: text(
              context,
              "???? ?????????????? ???? ????????",
              14,
              Colors.white,
              align: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          const Expanded(
              child: Divider(
            color: Colors.grey,
            thickness: 1.3,
          )),
        ]));
  }
}
