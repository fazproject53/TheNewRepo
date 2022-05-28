///import section
import 'dart:convert';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';


///----------------------------ContactWithUsHome----------------------------
class ContactWithUsHome extends StatefulWidget {
  const ContactWithUsHome({Key? key}) : super(key: key);

  @override
  _ContactWithUsHomeState createState() => _ContactWithUsHomeState();
}

class _ContactWithUsHomeState extends State<ContactWithUsHome> {
  ///Text Field
  final TextEditingController supportTitle = TextEditingController();
  final TextEditingController supportDescription = TextEditingController();

  ///formKey
  final _formKey = GlobalKey<FormState>();

  ///Type of discount drop down list
  final List _testList = [
    {'no': 1, 'keyword': 'دعم فني'},
    {'no': 2, 'keyword': 'إستفسار'},
    {'no': 3, 'keyword': 'صيانة'},
    {'no': 4, 'keyword': 'سوال'},
    {'no': 5, 'keyword': 'إستفسار'}
  ];

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];

  ///_value
  var _selectedTest;
  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(_testList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          alignment: Alignment.centerRight,
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("الدعم الفني", context),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ///Title
                            Container(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h, right: 20.w),
                                child: text(context, "قم بملئ البيانات التالية", 20,
                                    ligthtBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            ///--------------------------Text Field Section--------------------------
                            ///Dropdown Below
                            paddingg(
                              15,
                              15,
                              12,
                              DropdownBelow(
                                itemWidth: 380.w,

                                ///text style inside the menu
                                itemTextstyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: black,
                                  fontFamily: 'Cairo',
                                ),

                                ///hint style
                                boxTextstyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: grey,
                                    fontFamily: 'Cairo'),

                                ///box style
                                boxPadding:
                                    EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 12.h),
                                boxWidth: 500.w,
                                boxHeight: 46.h,
                                boxDecoration: BoxDecoration(
                                    color: textFieldBlack2.withOpacity(0.70),
                                    borderRadius: BorderRadius.circular(8.r)),

                                ///Icons
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white54,
                                ),
                                hint: const Text(
                                  'اختر نوع الشكوى',
                                  textDirection: TextDirection.rtl,
                                ),
                                value: _selectedTest,
                                items: _dropdownTestItems,
                                onChanged: onChangeDropdownTests,
                              ),
                            ),

                            ///Title
                            paddingg(
                              15,
                              15,
                              12,
                              textFieldNoIcon(
                                context,
                                'موضوع الرسالة',
                                12,
                                false,
                                supportTitle,
                                (String? value) {
                                  /// Validation text field
                                  if (value == null || value.isEmpty) {
                                    return 'حقل اجباري';
                                  }
                                  if (value.startsWith('0')) {
                                    return 'يجب ان لا يبدا بصفر';
                                  }
                                  if (value.startsWith(RegExp(r'[0-9]'))) {
                                    return 'يجب ان لا يبدا برقم';
                                  }
                                  return null;
                                },
                                false,
                                inputFormatters: [
                                  ///letters and numbers only
                                  FilteringTextInputFormatter(
                                      RegExp(r'[a-zA-Z]|[0-9]'),
                                      allow: true)
                                ],
                              ),
                            ),

                            ///Description
                            paddingg(
                              15,
                              15,
                              12,
                              textFieldDesc(
                                context,
                                'تفاصيل الرسالة',
                                12,
                                false,
                                supportDescription,
                                (String? value) {
                                  if (value!.startsWith('0')) {
                                    return 'يجب ان لا يبدا بصفر';
                                  }
                                  if (value.isEmpty) {
                                    return 'حقل اجباري';
                                  }
                                  if (value.startsWith('0')) {
                                    return 'يجب ان لا يبدا بصفر';
                                  }
                                  if (value.startsWith(RegExp(r'[0-9]'))) {
                                    return 'يجب ان لا يبدا برقم';
                                  } else {
                                    return value.length > 500
                                        ? 'يجب ان لا يزيد الوصف عن 500 حرف'
                                        : null;
                                  }
                                },
                                counter: (context,
                                    {required currentLength,
                                    required isFocused,
                                    maxLength}) {
                                  return Text(
                                    '$maxLength'
                                    '/'
                                    '$currentLength',
                                    style: TextStyle(fontSize: 12.sp, color: grey),
                                  );
                                },
                                maxLenth: 500,
                                keyboardType: TextInputType.multiline,
                                inputFormatters: [
                                  ///letters and numbers only
                                  FilteringTextInputFormatter(
                                      RegExp(r'[a-zA-Z]|[0-9]'),
                                      allow: true)
                                ],
                              ),
                            ),

                            ///SizedBox
                            SizedBox(
                              height: 15.h,
                            ),

                            ///Save box
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20.h, right: 20.w, left: 20.w, bottom: 20.h),
                              child: gradientContainerNoborder(
                                  500.w,
                                  buttoms(context, 'إرسال', 15, white, () {
                                    _formKey.currentState!.validate()
                                        ? {
                                            postContactWithUs().whenComplete(() => {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: text(
                                                        context,
                                                        'تم الارسال بنجاح',
                                                        12,
                                                        black),
                                                    backgroundColor: white,
                                                  ))
                                                })
                                          }
                                        : null;
                                  })),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///POST
  Future<http.Response> postContactWithUs() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';

    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/celebrity/promo-codes/add',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      body: jsonEncode(<String, dynamic>{
        'code': supportTitle.text,
        'discount': supportDescription.text,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // print(response.body);
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }
}
