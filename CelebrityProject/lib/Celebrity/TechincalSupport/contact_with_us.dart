///import section
import 'dart:convert';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ComplaintTypes.dart';

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

  ///Model Value
  Future<ComplaintTypes>? contactModel;

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];

  var complaintList = [];

  String complaintText = 'اختر نوع الشكوى';

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
    contactModel = getComplaintTypes();
    _dropdownTestItems = buildDropdownTestItems(complaintList);
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
                                padding:
                                    EdgeInsets.only(top: 20.h, right: 20.w),
                                child: text(context, "قم بملئ البيانات التالية",
                                    20, ligthtBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            ///--------------------------Text Field Section--------------------------
                            ///Dropdown Below
                            FutureBuilder(
                                future: contactModel,
                                builder: ((context,
                                    AsyncSnapshot<ComplaintTypes> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return paddingg(
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
                                        boxPadding: EdgeInsets.fromLTRB(
                                            13.w, 12.h, 13.w, 12.h),
                                        boxWidth: 500.w,
                                        boxHeight: 46.h,
                                        boxDecoration: BoxDecoration(
                                            color: textFieldBlack2
                                                .withOpacity(0.70),
                                            borderRadius:
                                                BorderRadius.circular(8.r)),

                                        ///Icons
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white54,
                                        ),
                                        hint: Text(
                                          complaintText,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        value: _selectedTest,
                                        items: _dropdownTestItems,
                                        onChanged: onChangeDropdownTests,
                                      ),
                                    );
                                  } else if (snapshot.connectionState ==
                                          ConnectionState.active ||
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text(snapshot.error.toString()));
                                    } else if (snapshot.hasData) {
                                      _dropdownTestItems.isEmpty
                                          ? {
                                              complaintList.add({
                                                'no': 0,
                                                'keyword': 'اختر منصة الاعلان'
                                              }),
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!.data!.length;
                                                  i++)
                                                {
                                                  complaintList.add({
                                                    'no': snapshot
                                                        .data!.data![i].id!,
                                                    'keyword':
                                                        '${snapshot.data!.data![i].name!}'
                                                  }),
                                                },
                                              _dropdownTestItems =
                                                  buildDropdownTestItems(
                                                      complaintList),
                                            }
                                          : null;

                                      return paddingg(
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
                                          boxPadding: EdgeInsets.fromLTRB(
                                              13.w, 12.h, 13.w, 12.h),
                                          boxWidth: 500.w,
                                          boxHeight: 46.h,
                                          boxDecoration: BoxDecoration(
                                              color: textFieldBlack2
                                                  .withOpacity(0.70),
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),

                                          ///Icons
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white54,
                                          ),
                                          hint: Text(
                                            complaintText,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          value: _selectedTest,
                                          items: _dropdownTestItems,
                                          onChanged: onChangeDropdownTests,
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                          child:
                                              Text('لايوجد لينك لعرضهم حاليا'));
                                    }
                                  } else {
                                    return Center(
                                        child: Text(
                                            'State: ${snapshot.connectionState}'));
                                  }
                                })),

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
                                    style:
                                        TextStyle(fontSize: 12.sp, color: grey),
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
                                  top: 20.h,
                                  right: 20.w,
                                  left: 20.w,
                                  bottom: 20.h),
                              child: gradientContainerNoborder(
                                  500.w,
                                  buttoms(context, 'إرسال', 15, white, () {
                                    _formKey.currentState!.validate()
                                        ? {
                                            postContactWithUs()
                                                .whenComplete(() => {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
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

  ///Get Complaint Types
  Future<ComplaintTypes> getComplaintTypes() async {
    final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/complaint-types'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ComplaintTypes g = ComplaintTypes.fromJson(jsonDecode(response.body));
      return g;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  ///POST
  Future<http.Response> postContactWithUs() async {
    String token2 = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxLr_AQhAzfEcqgasRrr32031veKVCd21rA';
    final response = await http.post(
      Uri.parse('https://mobile.celebrityads.net/api/technical-support',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      body: jsonEncode(<String, dynamic>{
        'name': supportTitle.text,
        'email': supportTitle.text,
        'subject': supportTitle.text,
        'details': supportDescription.text,
        'complaint_type_id': _selectedTest == null ? complaintList.indexOf(0) : complaintList.indexOf(_selectedTest),
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
