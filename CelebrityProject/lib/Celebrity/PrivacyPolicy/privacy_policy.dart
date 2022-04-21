///import section
import 'dart:convert';

import 'package:celepraty/Celebrity/PrivacyPolicy/ModelPrivicyPolicy.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../setting/profileInformation.dart';

class PrivacyPolicyMain extends StatelessWidget {
  const PrivacyPolicyMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("الشروط والاحكام", context),
        body: const PrivacyPolicyHome(),
      ),
    );
  }
}

///----------------------------PrivacyPolicyHome----------------------------
class PrivacyPolicyHome extends StatefulWidget {
  const PrivacyPolicyHome({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyHomeState createState() => _PrivacyPolicyHomeState();
}

class _PrivacyPolicyHomeState extends State<PrivacyPolicyHome> {
  Future<PrivicyPolicy>? pp;

  ///Text Field
  final TextEditingController addYourAdvPP = TextEditingController();
  final TextEditingController addYourGiftingPP = TextEditingController();
  final TextEditingController addYourAdvAreaPP = TextEditingController();

  bool isVisible = false;
  bool isVisible2 = false;
  bool isVisible3 = false;

  bool isChanged = false;
  bool isChanged2 = false;
  bool isChanged3 = false;

  @override
  void initState() {
    pp = fetchCelebritie();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userInput = addYourAdvPP.text;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: FutureBuilder<PrivicyPolicy>(
                      future: pp,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: lodeing(context));
                        } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                            //---------------------------------------------------------------------------
                          } else if (snapshot.hasData) {

                            ///get data and fill controller
                            addYourAdvPP.text = snapshot.data!.data!.celebrity!.advertisingPolicy!;
                            addYourGiftingPP.text = snapshot.data!.data!.celebrity!.giftingPolicy!;
                            addYourAdvAreaPP.text = snapshot.data!.data!.celebrity!.adSpacePolicy!;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 25.h, right: 20.w),
                                    child: text(
                                      context,
                                      "قم بإضافة الشروط والاحكام الخاصة بك",
                                      19,
                                      ligthtBlack,
                                    ),
                                  ),
                                ),

                                ///Icons Buttons with title
                                Container(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.only(
                                      top: 20.h, right: 16.w, bottom: 20.h),
                                  child: Column(
                                    children: [
                                      ///Adv PP
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: GradientIcon(
                                              ad,
                                              30.w,
                                              const LinearGradient(
                                                begin: Alignment(0.7, 2.0),
                                                end: Alignment(-0.69, -1.0),
                                                colors: [
                                                  Color(0xff0ab3d0),
                                                  Color(0xffe468ca)
                                                ],
                                                stops: [0.0, 1.0],
                                              ),
                                            ),
                                            onPressed: () {
                                              ///Text field will show
                                              setState(() {
                                                isVisible = !isVisible;
                                              });
                                            },
                                          ),
                                          text(
                                            context,
                                            'سياسة الاعلان',
                                            20.sp,
                                            black,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: isVisible,
                                        child: Container(
                                          padding: EdgeInsets.only(right: 10.w),
                                          child: Column(
                                            children: [
                                              ///Text Field
                                              paddingg(
                                                20,
                                                4,
                                                9,
                                                textFieldDescOnChange(
                                                  context,
                                                  'اكتب سياسة الاعلان الخاصة بك',
                                                  12,
                                                  false,
                                                  addYourAdvPP,
                                                  (String? value) {
                                                    /// Validation text field
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  (String? value) {
                                                    if (value == userInput) {
                                                      print('No Change');

                                                    } else {
                                                      print('change it');
                                                      isChanged = true;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      ///Gifting PP
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: GradientIcon(
                                                ad,
                                                30.w,
                                                const LinearGradient(
                                                  begin: Alignment(0.7, 2.0),
                                                  end: Alignment(-0.69, -1.0),
                                                  colors: [
                                                    Color(0xff0ab3d0),
                                                    Color(0xffe468ca)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                )),
                                            onPressed: () {
                                              ///Text field will show
                                              setState(
                                                () {
                                                  isVisible2 = !isVisible2;
                                                },
                                              );
                                            },
                                          ),
                                          text(
                                            context,
                                            'سياسة الاهداء',
                                            20.sp,
                                            black,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: isVisible2,
                                        child: Container(
                                          padding: EdgeInsets.only(right: 10.w),
                                          child: Column(
                                            children: [
                                              ///Text Field
                                              paddingg(
                                                20,
                                                4,
                                                9,
                                                textFieldDescOnChange(
                                                  context,
                                                  'اكتب سياسة الاهداء الخاصة بك',
                                                  12,
                                                  false,
                                                  addYourGiftingPP,
                                                  (String? value) {
                                                    /// Validation text field
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  (String? value) {
                                                    if (value == userInput) {
                                                      print('No Change');
                                                    } else {
                                                      print('change it');
                                                      isChanged = true;

                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      ///Area PP
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: GradientIcon(
                                                ad,
                                                30.w,
                                                const LinearGradient(
                                                  begin: Alignment(0.7, 2.0),
                                                  end: Alignment(-0.69, -1.0),
                                                  colors: [
                                                    Color(0xff0ab3d0),
                                                    Color(0xffe468ca)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                )),
                                            onPressed: () {
                                              ///Text field will show
                                              setState(
                                                () {
                                                  isVisible3 = !isVisible3;
                                                },
                                              );
                                            },
                                          ),
                                          text(
                                            context,
                                            'سياسة المساحة الاعلانية',
                                            20.sp,
                                            black,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: isVisible3,
                                        child: Container(
                                          padding: EdgeInsets.only(right: 10.w),
                                          child: Column(
                                            children: [
                                              ///Text Field
                                              paddingg(
                                                20,
                                                4,
                                                9,
                                                textFieldDescOnChange(
                                                  context,
                                                  'اكتب سياسة المساحة الاعلانية الخاصة بك',
                                                  12,
                                                  false,
                                                  addYourAdvAreaPP,
                                                  (String? value) {
                                                    /// Validation text field
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  (String? value) {
                                                    if (value == userInput) {
                                                      print('No Change');
                                                    } else {
                                                      print('change it');
                                                      isChanged = true;
                                                    }

                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ///will show when text field show
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      padding(
                                        15,
                                        15,
                                        gradientContainerNoborder(getSize(context).width,
                                            buttoms(context, 'حفظ التغيرات', 20, white, () {
                                              postFunction();
                                            })),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return const Center(child: Text('Empty data'));
                          }
                        } else {
                          return Center(
                              child:
                                  Text('State: ${snapshot.connectionState}'));
                        }
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  Future<http.Response> postFunction() async {
    String token2 = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';
    final response = await http.post(
      Uri.parse('https://mobile.celebrityads.net/api/celebrity/profile/update', ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'},
      body: jsonEncode(<String, dynamic>{
        'advertising_policy': addYourAdvPP.text,
        'ad_space_policy': addYourAdvAreaPP.text,
        'gifting_policy': addYourGiftingPP.text
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }
}
