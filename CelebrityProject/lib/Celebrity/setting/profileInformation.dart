import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/setting/celebratyProfile.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class profileInformaion extends StatefulWidget {
  _profileInformaionState createState() => _profileInformaionState();
}

class _profileInformaionState extends State<profileInformaion> with AutomaticKeepAliveClientMixin {
  Future<CelebrityInformation>? celebrities;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController pageLink = TextEditingController();
  final TextEditingController snapchat = TextEditingController();
  final TextEditingController tiktok = TextEditingController();
  final TextEditingController youtube = TextEditingController();
  final TextEditingController instagram = TextEditingController();
  final TextEditingController facebook = TextEditingController();
  final TextEditingController twitter = TextEditingController();
  final TextEditingController linkedin = TextEditingController();
  final TextEditingController desc = TextEditingController();

  String country = 'الدولة';
  String city = 'المدينة';
  String category = 'التصنيف';
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

  var categorylist = [
    {'no': 1, 'keyword': 'التصنيف'},
    {'no': 2, 'keyword': 'item1'},
    {'no': 3, 'keyword': 'item2'},
    {'no': 3, 'keyword': 'item3'},
    {'no': 3, 'keyword': 'item4'}
  ];

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItems2 = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItems3 = [];

  ///_value
  var _selectedTest;
  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  var _selectedTest2;
  onChangeDropdownTests2(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest2 = selectedTest;
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
  void initState() {
    celebrities = fetchCelebrities();
    _dropdownTestItems = buildDropdownTestItems(citilist);
    _dropdownTestItems2 = buildDropdownTestItems(categorylist);
    _dropdownTestItems3 = buildDropdownTestItems(countrylist);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar('المعلومات الشخصية', context),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: paddingg(
                12,
                12,
                5,
                FutureBuilder<CelebrityInformation>(
                  future: celebrities,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: lodeing(context));
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                        //---------------------------------------------------------------------------
                      } else if (snapshot.hasData) {
                        snapshot.data != null
                            ? {
                                name.text =
                                    snapshot.data!.data!.celebrity!.name!,
                                email.text =
                                    snapshot.data!.data!.celebrity!.email!,
                                password.text = "********",
                                desc.text = snapshot
                                    .data!.data!.celebrity!.description!,
                                phone.text = snapshot
                                    .data!.data!.celebrity!.phonenumber!,
                                pageLink.text =
                                    snapshot.data!.data!.celebrity!.pageUrl!,
                                snapchat.text = snapshot
                                    .data!.data!.celebrity!.snapchat!
                                    .toString(),
                                tiktok.text = snapshot
                                    .data!.data!.celebrity!.tiktok!
                                    .toString(),
                                youtube.text = snapshot
                                    .data!.data!.celebrity!.youtube!
                                    .toString(),
                                instagram.text = snapshot
                                    .data!.data!.celebrity!.instagram!
                                    .toString(),
                                facebook.text = snapshot
                                    .data!.data!.celebrity!.facebook!
                                    .toString(),
                                twitter.text = snapshot
                                    .data!.data!.celebrity!.twitter!
                                    .toString(),
                                snapshot.data!.data!.celebrity!.category != null
                                    ? category = snapshot
                                        .data!.data!.celebrity!.category!.name!
                                    : '',
                                snapshot.data!.data!.celebrity!.country != null
                                    ? country = snapshot
                                        .data!.data!.celebrity!.country!.name!
                                    : '',
                                snapshot.data!.data!.celebrity!.city!.name !=
                                        null
                                    ? city = snapshot
                                        .data!.data!.celebrity!.city!.name
                                        .toString()
                                    : null
                              }
                            : null;

                        return Column(
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
                                textFieldDesc(context, 'الوصف الخاص بالمشهور',
                                    14, false, desc, (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }),
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
                                    context, 'كلمة المرور', 14, true, password,
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
                                textFieldNoIcon(
                                    context, 'رقم الجوال', 14, false, phone,
                                    (String? value) {
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
                                  itemWidth: 370.w,
                                  dropdownColor: newGrey,

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
                                      color: white,
                                      fontFamily: 'Cairo'),

                                  ///box style
                                  boxPadding: EdgeInsets.fromLTRB(
                                      13.w, 12.h, 13.w, 12.h),
                                  boxWidth: 500.w,
                                  boxHeight: 40.h,
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
                                  itemWidth: 370.w,
                                  dropdownColor: newGrey,

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
                                      color: white,
                                      fontFamily: 'Cairo'),

                                  ///box style
                                  boxPadding: EdgeInsets.fromLTRB(
                                      13.w, 12.h, 13.w, 12.h),
                                  boxWidth: 500.w,
                                  boxHeight: 40.h,
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

                              paddingg(
                                15,
                                15,
                                12,
                                DropdownBelow(
                                  itemWidth: 370.w,
                                  dropdownColor: newGrey,

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
                                      color: white,
                                      fontFamily: 'Cairo'),

                                  ///box style
                                  boxPadding: EdgeInsets.fromLTRB(
                                      13.w, 12.h, 13.w, 12.h),
                                  boxWidth: 500.w,
                                  boxHeight: 40.h,
                                  boxDecoration: BoxDecoration(
                                      color: textFieldBlack2.withOpacity(0.70),
                                      borderRadius: BorderRadius.circular(8.r)),

                                  ///Icons
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white54,
                                  ),
                                  hint: Text(
                                    category,
                                    textDirection: TextDirection.rtl,
                                  ),
                                  value: _selectedTest2,
                                  items: _dropdownTestItems2,
                                  onChanged: onChangeDropdownTests2,
                                ),
                              ),

                              //=========== end dropdown ==================================

                              paddingg(
                                15,
                                15,
                                12,
                                textFieldNoIcon(
                                    context, 'رابط الصفحة', 14, false, pageLink,
                                    (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }, false),
                              ),

                              //===================================== اضافة روابط الصفحات =======================================================
                              textFeildWithButton(
                                context,
                                textFieldNoIcon2(
                                  context,
                                  'رابط صفحة سناب شات',
                                  14,
                                  false,
                                  snapchat,
                                  (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Center(
                                      child: InkWell(
                                          onTap: () {},
                                          child: text(
                                              context, 'اضافة', 14, black,
                                              align: TextAlign.center))),
                                ),
                              ),
                              textFeildWithButton(
                                context,
                                textFieldNoIcon2(
                                  context,
                                  'رابط صفحة تيك توك',
                                  14,
                                  false,
                                  tiktok,
                                  (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {},
                                            child: text(
                                                context, 'اضافة', 14, black,
                                                align: TextAlign.center))),
                                  ),
                                ),
                              ),
                              textFeildWithButton(
                                context,
                                textFieldNoIcon2(
                                  context,
                                  'رابط صفحة يوتيوب',
                                  14,
                                  false,
                                  youtube,
                                  (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {},
                                            child: text(
                                                context, 'اضافة', 14, black,
                                                align: TextAlign.center))),
                                  ),
                                ),
                              ),
                              textFeildWithButton(
                                context,
                                textFieldNoIcon2(
                                  context,
                                  'رابط صفحة الانستجرام',
                                  14,
                                  false,
                                  instagram,
                                  (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {},
                                            child: text(
                                                context, 'اضافة', 14, black,
                                                align: TextAlign.center))),
                                  ),
                                ),
                              ),
                              textFeildWithButton(
                                context,
                                textFieldNoIcon2(
                                  context,
                                  'رابط صفحة تويتر',
                                  14,
                                  false,
                                  twitter,
                                  (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {},
                                            child: text(
                                                context, 'اضافة', 14, black,
                                                align: TextAlign.center))),
                                  ),
                                ),
                              ),
                              textFeildWithButton(
                                context,
                                textFieldNoIcon2(
                                  context,
                                  'رابط صفحة الفيسبوك',
                                  14,
                                  false,
                                  facebook,
                                  (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {},
                                            child: text(
                                                context, 'اضافة', 14, black,
                                                align: TextAlign.center))),
                                  ),
                                ),
                              ),

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
                                      updateInformation().whenComplete(() => {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "تم تعديل المعلومات بنجاح"),
                                            ))
                                          });
                                    })),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ]);
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
        ),
      ),
    );
  }

  Future<http.Response> updateInformation() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/celebrity/profile/update',
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
        'phonenumber': phone.text,
        'country_id':
            _selectedTest3 == null ? 1 : countrylist.indexOf(_selectedTest3),
        'city_id': _selectedTest == null ? 1 : citilist.indexOf(_selectedTest),
        'category_id':
            _selectedTest2 == null ? 1 : categorylist.indexOf(_selectedTest2),
        'snapchat': snapchat.text,
        'tiktok': tiktok.text,
        'youtube': youtube.text,
        'instagram': instagram.text,
        'twitter': twitter.text,
        'facebook': facebook.text,
        'description': desc.text,
      }),
    );
    if (response.statusCode == 201) {
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

@override
// TODO: implement wantKeepAlive
bool get wantKeepAlive => true;

Widget lodeing(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: 250.w,
    child: Padding(
      padding: EdgeInsets.only(bottom: 100.h),
      child: Lottie.asset('assets/lottie/lode.json', height: 200.h),
    ),
  );
}

Future<CelebrityInformation> fetchCelebrities() async {
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';
  final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/celebrity/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return CelebrityInformation.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load activity');
  }
}

class CelebrityInformation {
  bool? success;
  Data? data;
  Message? message;

  CelebrityInformation({this.success, this.data, this.message});

  CelebrityInformation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Data {
  Celebrity? celebrity;
  int? status;

  Data({this.celebrity, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    celebrity = json['celebrity'] != null
        ? new Celebrity.fromJson(json['celebrity'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.celebrity != null) {
      data['celebrity'] = this.celebrity!.toJson();
    }
    data['status'] = this.status;
    return data;
  }


}

class Celebrity {
  int? id;
  String? username;
  String? name;
  String? image;
  String? email;
  String? phonenumber;
  Country? country;
  City? city;
  String? description;
  String? pageUrl;
  String? snapchat;
  String? tiktok;
  String? youtube;
  String? twitter;
  String? instagram;
  String? facebook;
  Category? category;

  Celebrity(
      {this.id,
      this.username,
      this.name,
      this.image,
      this.email,
      this.phonenumber,
      this.country,
      this.city,
      this.description,
      this.pageUrl,
      this.snapchat,
      this.tiktok,
      this.youtube,
      this.instagram,
      this.twitter,
      this.facebook,
      this.category});

  Celebrity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    description = json['description'];
    pageUrl = json['page_url'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['city'] = this.city;
    data['description'] = this.description;
    data['page_url'] = this.pageUrl;
    data['snapchat'] = this.snapchat;
    data['tiktok'] = this.tiktok;
    data['youtube'] = this.youtube;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class City {
  String? name;
  String? nameEn;
  City({this.name, this.nameEn});
  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class Country {
  String? name;
  String? nameEn;
  String? flag;

  Country({this.name, this.nameEn, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['flag'] = this.flag;
    return data;
  }
}

class Category {
  String? name;
  String? nameEn;

  Category({this.name, this.nameEn});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class Message {
  String? en;
  String? ar;

  Message({this.en, this.ar});

  Message.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }


}
