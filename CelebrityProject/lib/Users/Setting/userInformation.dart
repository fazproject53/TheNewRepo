import 'dart:convert';

import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/setting/celebratyProfile.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Celebrity/setting/profileInformation.dart';
import 'userProfile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class userInformation extends StatefulWidget {
  _userInformationState createState() => _userInformationState();
}

class _userInformationState extends State<userInformation> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController repassword = new TextEditingController();
  final TextEditingController phone = new TextEditingController();

  bool hidden = true;
  bool hidden2 = true;
  String country = 'الدولة';
  String city = 'المدينة';
  Future<UserProfile>? getUser;
  var currentFocus;
  var citilist = [
    {'no': 1, 'keyword': 'المدينة'},
    {'no': 2, 'keyword': 'item1'},
    {'no': 3, 'keyword': 'item2'},
    {'no': 3, 'keyword': 'item3'},
    {'no': 3, 'keyword': 'item4'}
  ];

  var countrylist = [
    {'no': 1, 'keyword': 'الدولة'},
    {'no': 2, 'keyword': 'item1'},
    {'no': 3, 'keyword': 'item2'},
    {'no': 3, 'keyword': 'item3'},
    {'no': 3, 'keyword': 'item4'}
  ];

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItems3 = [];

  ///_value
  var _selectedTest;
  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  var _selectedTest3;
  onChangeDropdownTests3(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest3 = selectedTest;
    });
  }

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(citilist);
    _dropdownTestItems3 = buildDropdownTestItems(countrylist);
    getUser = fetchUsers();
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
          alignment: Alignment.topRight,
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
      child: GestureDetector(
        onTap: (){
          updateUserInformation().whenComplete(() =>    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("تم تعديل المعلومات بنجاح"),
          )));
        },
        child: Scaffold(
          appBar: drowAppBar('المعلومات الشخصية', context),
          body: SingleChildScrollView(
            child: FutureBuilder<UserProfile>(
              future: getUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: lodeing(context));
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                    //---------------------------------------------------------------------------
                  } else if (snapshot.hasData) {

                    name.text = snapshot.data!.data!.user!.name!;
                    email.text = snapshot.data!.data!.user!.email!;
                    phone.text = snapshot.data!.data!.user!.phonenumber!;
                    password.text = "********";
                    repassword.text = "********";
                    country = snapshot.data!.data!.user!.country != null? snapshot.data!.data!.user!.country!.name!: '';
                    city = snapshot.data!.data!.user!.city!.name != null? snapshot.data!.data!.user!.city!.name.toString(): '';

                return Container(
                      child: Form(
                        key: _formKey,
                        child: paddingg(
                          12,
                          12,
                          5,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                padding(
                                  10,
                                  12,
                                  Container(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'قم بملئ او تعديل  معلوماتك الشخصية',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: textBlack,
                                            fontFamily: 'Cairo'),
                                      )),
                                ),

                                //========================== form ===============================================

                                SizedBox(
                                  height: 30,
                                ),

                                paddingg(
                                  15,
                                  15,
                                  12,
                                  textFieldNoIcon(
                                      context, 'الاسم', 14, false, name,
                                      (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  }, false),
                                ),
                                paddingg(
                                  15,
                                  15,
                                  12,
                                  textFieldNoIcon(context, 'البريد الالكتروني',
                                      14, false, email, (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  }, false),
                                ),
                                paddingg(
                                  15,
                                  15,
                                  12,
                                  textFieldNoIcon(
                                      context, 'رقم الجوال', 14, false, phone,
                                      (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  }, false),
                                ),
                                paddingg(
                                  15,
                                  15,
                                  12,
                                  textFieldPassword(context, 'كلمة المرور', 14,
                                      hidden, password, (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  }, false),
                                ),
                                paddingg(
                                  15,
                                  15,
                                  12,
                                  textFieldPassword2(
                                      context,
                                      'اعادة ضبط كلمة المرور ',
                                      14,
                                      hidden2,
                                      repassword, (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  }, false),
                                ),

                                //===========dropdown lists ==================

                                paddingg(
                                  15,
                                  15,
                                  12,
                                  DropdownBelow(
                                    dropdownColor: newGrey,
                                    itemWidth: 370.w,

                                    ///text style inside the menu
                                    itemTextstyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: white,
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
                                    boxHeight: 45.h,
                                    boxDecoration: BoxDecoration(
                                        color: textFieldBlack2.withOpacity(0.70),
                                        borderRadius: BorderRadius.circular(8.r)),

                                    ///Icons
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white54,
                                    ),
                                    hint: Text(
                                      country,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    value: _selectedTest3,
                                    items: _dropdownTestItems3,
                                    onChanged: onChangeDropdownTests3,
                                  ),
                                ),
                                paddingg(
                                  15,
                                  15,
                                  12,
                                  DropdownBelow(
                                    dropdownColor: newGrey,
                                    itemWidth: 370.w,

                                    ///text style inside the menu
                                    itemTextstyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: white,
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
                                    boxHeight: 45.h,
                                    boxDecoration: BoxDecoration(
                                        color: textFieldBlack2.withOpacity(0.70),
                                        borderRadius: BorderRadius.circular(8.r)),

                                    ///Icons
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white54,
                                    ),
                                    hint: Text(
                                      city,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    value: _selectedTest,
                                    items: _dropdownTestItems,
                                    onChanged: onChangeDropdownTests,
                                  ),
                                ),

                                //=========== end dropdown ==================================

                                //===================== button ================================

                                SizedBox(
                                  height: 30,
                                ),
                                padding(
                                  15,
                                  15,
                                  gradientContainerNoborder(
                                      getSize(context).width,
                                      buttoms(context, 'حفظ', 20, white, () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  celebratyProfile()),
                                        );
                                      })),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ]),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Empty data'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldPassword(
    context,
    String key,
    double fontSize,
    bool hintPass,
    TextEditingController mycontroller,
    myvali,
    isOptional,
  ) {
    return TextFormField(
      obscureText: hintPass ? true : false,
      validator: myvali,
      controller: mycontroller,
      style:
          TextStyle(color: white, fontSize: fontSize.sp, fontFamily: 'Cairo'),
      decoration: InputDecoration(
          isDense: false,
          filled: true,
          helperText: isOptional ? 'اختياري' : null,
          helperStyle: TextStyle(
              color: pink, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          hintStyle: TextStyle(
              color: grey, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          fillColor: textFieldBlack2.withOpacity(0.70),
          labelStyle: TextStyle(color: white, fontSize: fontSize.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: pink, width: 1)),
          suffixIcon: hidden
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidden = false;
                    });
                  },
                  icon: Icon(
                    hide,
                    color: lightGrey,
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      hidden = true;
                    });
                  },
                  icon: Icon(show, color: lightGrey)),
          hintText: key,
          contentPadding: EdgeInsets.all(10.h)),
    );
  }

  Future<http.Response> updateUserInformation() async {
    String token2 = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxL'
        'r_AQhAzfEcqgasRrr32031veKVCd21rA';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/user/profile/update',),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'},
      body: jsonEncode(<String, dynamic>{
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'phonenumber': phone.text,
        'country_id': _selectedTest3 == null ? 1 : countrylist.indexOf(
            _selectedTest3),
        'city_id': _selectedTest == null ? 1 : citilist.indexOf(_selectedTest),

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

  Widget textFieldPassword2(
    context,
    String key,
    double fontSize,
    bool hintPass,
    TextEditingController mycontroller,
    myvali,
    isOptional,
  ) {
    return TextFormField(
      obscureText: hintPass ? true : false,
      validator: myvali,
      controller: mycontroller,
      style:
          TextStyle(color: white, fontSize: fontSize.sp, fontFamily: 'Cairo'),
      decoration: InputDecoration(
          isDense: false,
          filled: true,
          helperText: isOptional ? 'اختياري' : null,
          helperStyle: TextStyle(
              color: pink, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          hintStyle: TextStyle(
              color: grey, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          fillColor: textFieldBlack2.withOpacity(0.70),
          labelStyle: TextStyle(color: white, fontSize: fontSize.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: pink, width: 1)),
          suffixIcon: hidden2
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidden2 = false;
                    });
                  },
                  icon: Icon(
                    hide,
                    color: lightGrey,
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      hidden2 = true;
                    });
                  },
                  icon: Icon(show, color: lightGrey)),
          hintText: key,
          contentPadding: EdgeInsets.all(10.h)),
    );
  }
}
