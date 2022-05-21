import 'dart:convert';

import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/setting/celebratyProfile.dart';
import 'package:country_code_picker/country_code_picker.dart';
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
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController newPassword = new TextEditingController();
  final TextEditingController currentPassword = new TextEditingController();
  final TextEditingController confirmPassword = new TextEditingController();
  final TextEditingController phone = new TextEditingController();

  Future<CountryL>? countries;
  Future<CityL>? cities;
  bool noMatch =false;
  bool editPassword = false;

  int helper =0;
  bool hidden = true;
  bool hidden2 = true;
  String country = 'الدولة';
  String city = 'المدينة';
  String? countrycode;
  bool countryChanged = false;
  Future<UserProfile>? getUser;
  var currentFocus;
  var citilist = [];

  var countrylist = [];

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
      countryChanged  =true;
      _selectedTest3 = selectedTest;
    });
  }

  @override
  void initState() {
    countries = fetCountries();
    cities = fetCities();
    getUser = fetchUsers();
    _dropdownTestItems = buildDropdownTestItems(citilist);
    _dropdownTestItems3 = buildDropdownTestItems(countrylist);

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
                  int number;
                  helper ==0?{
                  name.text = snapshot.data!.data!.user!.name!,
                  email.text = snapshot.data!.data!.user!.email!,
                    snapshot.data!.data!.user!.phonenumber! != ""?{
                  number =
                      snapshot.data!.data!.user!.phonenumber!.length - 9,
                  phone.text =
                      snapshot.data!.data!.user!.phonenumber!.substring(number),}:
                    phone.text =
                    snapshot.data!.data!.user!.phonenumber!,
                  password.text = "********",
                  country = snapshot.data!.data!.user!.country != null
                      ? snapshot.data!.data!.user!.country!.name!
                      : '',
                  city = snapshot.data!.data!.user!.city!.name != null
                      ? snapshot.data!.data!.user!.city!.name.toString()
                      : '',
                    helper =1,
                  }:null;


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
                                    child: const Text(
                                      'قم بملئ او تعديل  معلوماتك الشخصية',
                                      style: TextStyle(
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
                                  if (value == null || value.isEmpty) {}
                                  return null;
                                }, false),
                              ),
                              paddingg(
                                15,
                                15,
                                12,
                                textFieldNoIcon(context, 'البريد الالكتروني',
                                    14, false, email, (String? value) {
                                  if (value == null || value.isEmpty) {}
                                  return null;
                                }, false),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: paddingg(
                                      0,
                                      15,
                                      12,
                                      textFieldNoIcon(context, 'رقم الجوال', 14,
                                          false, phone, (String? value) {
                                        RegExp regExp = new RegExp(
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)');
                                        if (value != null) {
                                          if (value.isNotEmpty) {
                                            if (value.length != 9) {
                                              return "رقم الجوال يجب ان يتكون من 9 ارقام  ";
                                            }
                                            if (value.startsWith('0')) {
                                              return 'رقم الجوال يجب ان لا يبدا ب 0 ';
                                            }
                                            // if(!regExp.hasMatch(value)){
                                            //   return "رقم الجوال غير صالح";
                                            // }
                                          }
                                        }

                                        return null;
                                      }, false),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: CountryCodePicker(
                                        padding: EdgeInsets.all(0),
                                        onChanged: print,
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: country == 'السعودية'
                                            ? 'SA'
                                            : country == 'فلسطين'
                                            ? 'PS'
                                            : country == 'الاردن'
                                            ? 'JO'
                                            : country == 'الامارات'
                                            ? 'AE'
                                            : 'SA',
                                        countryFilter: const [
                                          'SA',
                                          'JO',
                                          'SD',
                                          'DZ',
                                          'BH',
                                          'EG',
                                          'KW',
                                          'PS',
                                          'SY',
                                          'IQ',
                                          'LB',
                                          'LY',
                                          'OM',
                                          'MA',
                                          'AE',
                                          'YE',
                                          'DJ',
                                          'TN',
                                          'KM',
                                          'SO',
                                          'MR'
                                        ],
                                        showFlag: true,
                                        // optional. Shows only country name and flag
                                        showCountryOnly: false,
                                        textStyle:  TextStyle(color: black, fontSize: 0.sp),
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: false,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: paddingg(
                                      0,
                                      15,
                                      12,
                                      textFieldPassword(context, 'كلمة المرور', 14,
                                          hidden, password, (String? value) {
                                        if (value == null || value.isEmpty) {}
                                        return null;
                                      }, false),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                editPassword = !editPassword;
                                              });
                                            },
                                            child: Icon(Icons.edit)),
                                      )),
                                ],
                              ),
                              // paddingg(
                              //   15,
                              //   15,
                              //   12,
                              //   textFieldPassword2(
                              //       context,
                              //       'اعادة ضبط كلمة المرور ',
                              //       14,
                              //       hidden2,
                              //       repassword, (String? value) {
                              //     if (value == null || value.isEmpty) {}
                              //     return null;
                              //   }, false),
                              // ),

                              editPassword
                                  ? Form(
                                key: _formKey2,
                                child: Column(
                                  children: [
                                    paddingg(
                                      15,
                                      15,
                                      12,
                                      textFieldNoIcon(
                                          context,
                                          'كلمة المرور الحالية',
                                          14,
                                          true,
                                          currentPassword, (String? value) {
                                        if (value == null ||
                                            value.isEmpty) {}
                                        return null;
                                      }, false),
                                    ),
                                    paddingg(
                                      15,
                                      15,
                                      12,
                                      textFieldNoIcon(
                                          context,
                                          'كلمة المرور الجديدة',
                                          14,
                                          true,
                                          newPassword, (String? value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'حقل اجباري';
                                        }
                                        return null;
                                      }, false),
                                    ),
                                    paddingg(
                                      15,
                                      15,
                                      12,
                                      textFieldNoIcon(
                                          context,
                                          'تاكيد كلمة المرور ',
                                          14,
                                          true,
                                          confirmPassword, (String? value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'حقل اجباري';
                                        }
                                        return noMatch ? 'كلمة المرور وتاكيد كلمة المرور غير متطابقين': null;
                                      }, false),
                                    ),
                                  ],
                                ),
                              )
                                  : const SizedBox(
                                height: 0,
                              ),
                              //===========dropdown lists ==================
                              FutureBuilder(
                                  future: countries,
                                  builder: ((context,
                                      AsyncSnapshot<CountryL> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center();
                                    } else if (snapshot.connectionState ==
                                            ConnectionState.active ||
                                        snapshot.connectionState ==
                                            ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                snapshot.error.toString()));
                                        //---------------------------------------------------------------------------
                                      } else if (snapshot.hasData) {
                                        _dropdownTestItems3.isEmpty
                                            ? {
                                          countrylist.add({
                                            'no': 0,
                                            'keyword': 'الدولة'
                                          }),
                                          for (int i = 0;
                                          i <
                                              snapshot
                                                  .data!.data!.length;
                                          i++)
                                            {
                                              countrylist.add({
                                                'no': i,
                                                'keyword':
                                                '${snapshot.data!.data![i].name!}'
                                              }),
                                            },
                                          _dropdownTestItems3 =
                                              buildDropdownTestItems(
                                                  countrylist)
                                        }
                                            : null;
                                        return paddingg(
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
                                              country,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: _selectedTest3,
                                            items: _dropdownTestItems3,
                                            onChanged: onChangeDropdownTests3,
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                            child: Text(
                                                'لايوجد لينك لعرضهم حاليا'));
                                      }
                                    } else {
                                      return Center(
                                          child: Text(
                                              'State: ${snapshot.connectionState}'));
                                    }
                                  })),
                              FutureBuilder(
                                  future: cities,
                                  builder: ((context,
                                      AsyncSnapshot<CityL> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center();
                                    } else if (snapshot.connectionState ==
                                            ConnectionState.active ||
                                        snapshot.connectionState ==
                                            ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                snapshot.error.toString()));
                                        //---------------------------------------------------------------------------
                                      } else if (snapshot.hasData) {
                                        _dropdownTestItems.isEmpty
                                            ? {
                                                citilist.add({
                                                  'no': 0,
                                                  'keyword': 'المدينة'
                                                }),
                                                for (int i = 0;
                                                    i <
                                                        snapshot
                                                            .data!.data!.length;
                                                    i++)
                                                  {
                                                    citilist.add({
                                                      'no': i,
                                                      'keyword':
                                                          '${snapshot.data!.data![i].name!}'
                                                    }),
                                                  },
                                                _dropdownTestItems =
                                                    buildDropdownTestItems(
                                                        citilist)
                                              }
                                            : null;
                                        return paddingg(
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
                                              city,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: _selectedTest,
                                            items: _dropdownTestItems,
                                            onChanged: onChangeDropdownTests,
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                            child: Text(
                                                'لايوجد لينك لعرضهم حاليا'));
                                      }
                                    } else {
                                      return Center(
                                          child: Text(
                                              'State: ${snapshot.connectionState}'));
                                    }
                                  })),

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
                                      (currentPassword.text != null && newPassword.text != null ) ||  ( currentPassword.text.isNotEmpty && newPassword.text.isNotEmpty)?{
                                      _formKey2.currentState ==null?null:
                                      _formKey2.currentState!.validate()? {
                                      newPassword.text == confirmPassword.text?{ changePassword().whenComplete(() =>  ScaffoldMessenger.of(
                                      context)
                                          .showSnackBar(
                                      const SnackBar(
                                      content: Text("تم تحديث المعلومات بنجاح"),
                                      ))), updateUserInformation().whenComplete(() => fetchCelebrities())}: setState((){noMatch = true;})}:null,}:null;

                                      _formKey.currentState!.validate() &&  _formKey2.currentState == null? updateUserInformation()
                                          .whenComplete(() => {
                                      countryChanged
                                      ? setState(() {
                                      helper = 0;
                                      countryChanged =
                                      false;
                                      getUser = fetchUsers();})
                                          : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder:
                                      (context) =>
                                      celebratyProfile()),
                                      ),
                                      ScaffoldMessenger.of(
                                      context)
                                          .showSnackBar(
                                      const SnackBar(
                                      content: Text(
                                      "تم تعديل المعلومات بنجاح"),
                                      ))
                                      //   setState(() {
                                      //     helper = 0;
                                      //     celebrities =
                                      //         fetchCelebrities();
                                      //   }),
                                      //   ScaffoldMessenger.of(
                                      //           context)
                                      //       .showSnackBar(
                                      //           const SnackBar(
                                      //     content: Text(
                                      //         "تم تعديل المعلومات بنجاح"),
                                      //   ))
                                      })
                                      : null;
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
    );
  }

  Future<CountryL> fetCountries() async {
    final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/countries'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return CountryL.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  Future<CityL> fetCities() async {
    final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/cities/1'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return CityL.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
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
          // suffixIcon: hidden
          //     ? IconButton(
          //         onPressed: () {
          //           setState(() {
          //             hidden = false;
          //           });
          //         },
          //         icon: Icon(
          //           hide,
          //           color: lightGrey,
          //         ))
          //     : IconButton(
          //         onPressed: () {
          //           setState(() {
          //             hidden = true;
          //           });
          //         },
          //         icon: Icon(show, color: lightGrey)),
          hintText: key,
          contentPadding: EdgeInsets.all(10.h)),
    );
  }

  Future<http.Response> updateUserInformation() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxL'
        'r_AQhAzfEcqgasRrr32031veKVCd21rA';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/user/profile/update',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      body: jsonEncode(<String, dynamic>{
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'phonenumber':
            countrycode != null ? countrycode! + phone.text : phone.text,
        'country_id':
            _selectedTest3 == null ? 1 : countrylist.indexOf(_selectedTest3),
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
  Future<http.Response> changePassword() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';

    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/user/password/change',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      body: jsonEncode(<String, dynamic>{
        'current_password': currentPassword.text,
        'new_password': newPassword.text,
        'confirm_password': confirmPassword.text,
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
