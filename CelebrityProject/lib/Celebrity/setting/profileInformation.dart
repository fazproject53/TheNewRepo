import 'dart:collection';
import 'dart:convert';
import 'package:celepraty/Account/LoggingSingUpAPI.dart';
import 'package:celepraty/Celebrity/celebrityHomePage.dart';
import 'package:celepraty/Celebrity/setting/celebratyProfile.dart';
import 'package:celepraty/Users/Setting/userProfile.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../Account/logging.dart';
import '../../MainScreen/main_screen_navigation.dart';

class profileInformaion extends StatefulWidget {
  _profileInformaionState createState() => _profileInformaionState();
}

class _profileInformaionState extends State<profileInformaion>
// with AutomaticKeepAliveClientMixin
{
  Future<CelebrityInformation>? celebrities;
  Future<CityL>? cities;
  Future<CountryL>? countries;
  Future<CategoryL>? categories;
  bool countryChanged = false;
  String? userToken;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
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
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController currentPassword = TextEditingController();

  String? erroremail;
  String? errorphone;
  bool valid = false;
  bool noMatch = false;
  bool editPassword = false;
  bool genderChosen = true;
  String country = 'الدولة';
  String city = 'المدينة';
  String category = 'التصنيف';
  String gender = 'الجنس';
  String? ContryKey;
  int helper = 0;
  int? catId;
  Map<int, String> getid = HashMap();
  Map<int, String> categoriesId = HashMap();
  var citilist = [];
  var countrylist = [];
  var categorylist = [];
  var genderlist = [
    {'no': 0, 'keyword': 'الجنس'},
    {'no': 1, 'keyword': 'ذكر'},
    {'no': 2, 'keyword': 'انثى'}
  ];

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItems2 = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItems3 = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItems4 = [];

  ///_value
  var _selectedTest;
  int? number;

  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
      city = selectedTest['keyword'];
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
      _selectedTest = null;
      _dropdownTestItems.clear();
      citilist.clear();
      countryChanged = true;
      Logging.theUser!.country = selectedTest['keyword'];
      _selectedTest3 = selectedTest;
      getid.forEach((key, value) {
        if (value == Logging.theUser!.country) {
          print(
              key.toString() + '---------------------------------------------');
          cities = fetCities(key + 1);
        }
      });
      city = 'المدينة';
    });
  }

  var _selectedTest4;

  onChangeDropdownTests4(selectedTest) {
    print(selectedTest);

    setState(() {
      _selectedTest4 = selectedTest;
      genderChosen = true;
      print(_selectedTest4['no']);
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
    DatabaseHelper.getToken().then((value) {
      setState(() {
        userToken = value;
        celebrities = fetchCelebrities(userToken!);
      });
    });
    countries = fetCountries();
    categories = fetCategories();
    _dropdownTestItems = buildDropdownTestItems(citilist);
    _dropdownTestItems2 = buildDropdownTestItems(categorylist);
    _dropdownTestItems3 = buildDropdownTestItems(countrylist);
    _dropdownTestItems4 = buildDropdownTestItems(genderlist);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(genderChosen.toString());
    getid.forEach((key, value) {
      if (value == Logging.theUser!.country) {
        print(key.toString() + '---------------------------------------------');
        cities = fetCities(key + 1);
      }
    });

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
                      return Center(child: mainLoad(context));
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                        //---------------------------------------------------------------------------
                      } else if (snapshot.hasData) {
                        snapshot.data != null
                            ? {
                                helper == 0
                                    ? {
                                        name.text = snapshot
                                            .data!.data!.celebrity!.name!,
                                        email.text = snapshot
                                            .data!.data!.celebrity!.email!,
                                        password.text = "********",
                                        desc.text = snapshot.data!.data!
                                            .celebrity!.description!,
                                        snapshot.data!.data!.celebrity!
                                                    .phonenumber! !=
                                                ""
                                            ? {
                                                number = snapshot
                                                        .data!
                                                        .data!
                                                        .celebrity!
                                                        .phonenumber!
                                                        .length -
                                                    9,
                                                phone.text = snapshot
                                                    .data!
                                                    .data!
                                                    .celebrity!
                                                    .phonenumber!
                                                    .substring(number!),
                                              }
                                            : phone.text = snapshot.data!.data!
                                                .celebrity!.phonenumber!,
                                        snapshot.data!.data!.celebrity!
                                                    .gender !=
                                                null
                                            ? {
                                                gender = snapshot.data!.data!
                                                    .celebrity!.gender!.name!,
                                                genderChosen = true
                                              }
                                            : gender,
                                        pageLink.text = snapshot
                                            .data!.data!.celebrity!.pageUrl!,
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
                                        snapshot.data!.data!.celebrity!
                                                    .category !=
                                                null
                                            ? category = snapshot.data!.data!
                                                .celebrity!.category!.name!
                                            : '',
                                        snapshot.data!.data!.celebrity!
                                                    .country !=
                                                null
                                            ? country = snapshot.data!.data!
                                                .celebrity!.country!.name!
                                            : '',
                                        snapshot.data!.data!.celebrity!.city !=
                                                null
                                            ? city = snapshot.data!.data!
                                                .celebrity!.city!.name
                                                .toString()
                                            : null,

                                        helper = 1,
                                      }
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

                              const SizedBox(
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
                                    return 'حقل اجباري';
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
                                  } else {
                                    return value.length > 150
                                        ? 'يجب ان لا يزيد الوصف عن 150 حرف'
                                        : null;
                                  }
                                  return null;
                                }, counter: (context,
                                        {required currentLength,
                                        required isFocused,
                                        maxLength}) {
                                  return Container(
                                      child: Text('${maxLength!}' +
                                          '/' +
                                          '${currentLength}'));
                                }, maxLenth: 200),
                              ),
                              paddingg(
                                15,
                                15,
                                12,
                                textFieldNoIcon(context, 'البريد الالكتروني',
                                    14, false, email, (String? value) {
                                  if (value == null || value.isEmpty) {
                                  } else {
                                    return value.contains('@') &&
                                            value.contains('.com')
                                        ? null
                                        : 'صيغة البريد الالكتروني غير صحيحة ';
                                  }
                                  return null;
                                }, false),
                              ),
                              paddingg(
                                15,
                                15,
                                12,
                                textFieldNoIcon(context, 'كلمة المرور',
                                    14, true, password, (String? value) {
                                  if (value == null || value.isEmpty) {}
                                  return null;
                                }, false, child: IconButton(onPressed: (){setState(() {
                                      editPassword = !editPassword;
                                    });}, icon:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.edit, color: black),
                                    ))),
                              ),

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
                                                currentPassword,
                                                (String? value) {
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
                                                confirmPassword,
                                                (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'حقل اجباري';
                                              }
                                              return noMatch
                                                  ? 'كلمة المرور وتاكيد كلمة المرور غير متطابقين'
                                                  : null;
                                            }, false),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: paddingg(
                                      15,
                                      15,
                                      12,
                                      textFieldNoIcon(context, 'رقم الجوال', 14,
                                          false, phone, (String? value) {
                                        RegExp regExp = RegExp(
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
                                      }, false, child:Container(
                                          width: 60.w,
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
                                              'BH',
                                              'KW',
                                              'OM',
                                              'AE',
                                              'KW',
                                              'QA',
                                            ],
                                            showFlagDialog: true,
                                            showFlag: false,
                                            // optional. Shows only country name and flag
                                            showCountryOnly: false,
                                            textStyle: TextStyle(
                                                color: black, fontSize: 15.sp),
                                            // optional. Shows only country name and flag when popup is closed.
                                            showOnlyCountryWhenClosed: false,
                                            // optional. aligns the flag and the Text left
                                            alignLeft: true,
                                          ),
                                        ), ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   flex: 2,
                                  //   child: Container(
                                  //     child: CountryCodePicker(
                                  //       padding: EdgeInsets.all(0),
                                  //       onChanged: print,
                                  //       // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  //       initialSelection: country == 'السعودية'
                                  //           ? 'SA'
                                  //           : country == 'فلسطين'
                                  //               ? 'PS'
                                  //               : country == 'الاردن'
                                  //                   ? 'JO'
                                  //                   : country == 'الامارات'
                                  //                       ? 'AE'
                                  //                       : 'SA',
                                  //       countryFilter: const [
                                  //         'SA',
                                  //         'BH',
                                  //         'KW',
                                  //         'OM',
                                  //         'AE',
                                  //         'KW',
                                  //         'QA',
                                  //       ],
                                  //       showFlag: true,
                                  //       // optional. Shows only country name and flag
                                  //       showCountryOnly: false,
                                  //       textStyle: TextStyle(
                                  //           color: black, fontSize: 0.sp),
                                  //       // optional. Shows only country name and flag when popup is closed.
                                  //       showOnlyCountryWhenClosed: false,
                                  //       // optional. aligns the flag and the Text left
                                  //       alignLeft: true,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),

                              // ===========dropdown lists ==================
                              paddingg(
                                15,
                                15,
                                12,
                                DropdownBelow(
                                  itemWidth: 370.w,
                                  dropdownColor: white,

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
                                      color: black,
                                      fontFamily: 'Cairo'),

                                  ///box style
                                  boxPadding: EdgeInsets.fromLTRB(
                                      13.w, 12.h, 13.w, 12.h),
                                  boxWidth: 500.w,
                                  boxHeight: 45.h,
                                  boxDecoration: BoxDecoration(
                                      border:  Border.all(color: newGrey, width: 0.5),
                                      color:  lightGrey.withOpacity(0.10),
                                      borderRadius: BorderRadius.circular(8.r)),

                                  ///Icons
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                  hint: Text(
                                    gender,
                                    textDirection: TextDirection.rtl,
                                  ),
                                  value: _selectedTest4,
                                  items: _dropdownTestItems4,
                                  onChanged: onChangeDropdownTests4,
                                ),
                              ),

                              genderChosen == true
                                  ? SizedBox()
                                  : paddingg(
                                      10,
                                      20,
                                      3,
                                      text(
                                          context,
                                          'تحديد نوع الجنس اجباري لتحديث المعلومات',
                                          14,
                                          red!)),
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
                                            itemWidth: 370.w,
                                            dropdownColor: white,

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
                                                color: black,
                                                fontFamily: 'Cairo'),

                                            ///box style
                                            boxPadding: EdgeInsets.fromLTRB(
                                                13.w, 12.h, 13.w, 12.h),
                                            boxWidth: 500.w,
                                            boxHeight: 45.h,
                                            boxDecoration: BoxDecoration(
                                                border:  Border.all(color: newGrey, width: 0.5),
                                                color: lightGrey.withOpacity(0.10),
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),

                                            ///Icons
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
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
                                            'keyword':
                                            'المدينة'
                                          }),
                                          for (int i = 0;
                                          i <
                                              snapshot
                                                  .data!.data!.length;
                                          i++)
                                            {
                                              citilist.add({
                                                'no': snapshot.data!.data![i].id!,
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
                                            itemWidth: 370.w,
                                            dropdownColor: white,

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
                                                color: black,
                                                fontFamily: 'Cairo'),

                                            ///box style
                                            boxPadding: EdgeInsets.fromLTRB(
                                                13.w, 12.h, 13.w, 12.h),
                                            boxWidth: 500.w,
                                            boxHeight: 45.h,
                                            boxDecoration: BoxDecoration(
                                                border:  Border.all(color: newGrey, width: 0.5),
                                                color:  lightGrey.withOpacity(0.10),
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),

                                            ///Icons
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
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

                              FutureBuilder(
                                  future: categories,
                                  builder: ((context,
                                      AsyncSnapshot<CategoryL> snapshot) {
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
                                        _dropdownTestItems2.isEmpty
                                            ? {
                                                categorylist.add({
                                                  'no': 0,
                                                  'keyword': 'التصنيف'
                                                }),
                                                for (int i = 0;
                                                    i <
                                                        snapshot
                                                            .data!.data!.length;
                                                    i++)
                                                  {
                                                    categorylist.add({
                                                      'no': i,
                                                      'keyword':
                                                          '${snapshot.data!.data![i].name}'
                                                    }),
                                                  },
                                                _dropdownTestItems2 =
                                                    buildDropdownTestItems(
                                                        categorylist)
                                              }
                                            : null;

                                        return paddingg(
                                          15,
                                          15,
                                          12,
                                          DropdownBelow(
                                            itemWidth: 370.w,
                                            dropdownColor: white,
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
                                                color: black,
                                                fontFamily: 'Cairo'),

                                            ///box style
                                            boxPadding: EdgeInsets.fromLTRB(
                                                13.w, 12.h, 13.w, 12.h),
                                            boxWidth: 500.w,
                                            boxHeight: 45.h,
                                            boxDecoration: BoxDecoration(
                                                border:  Border.all(color: newGrey, width: 0.5),
                                                color:  lightGrey.withOpacity(0.10),

                                                borderRadius:
                                                    BorderRadius.circular(8.r)),

                                            ///Icons
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
                                            ),
                                            hint: Text(
                                              category,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: _selectedTest2,
                                            items: _dropdownTestItems2,
                                            onChanged: onChangeDropdownTests2,
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

                              paddingg(
                                15,
                                15,
                                12,
                                textFieldNoIcon(
                                    context, 'رابط الصفحة', 14, false, pageLink,
                                    (String? value) {
                                  if (value == null || value.isEmpty) {}
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
                                  (String? value) {},
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Center(
                                      child: InkWell(
                                          onTap: () {
                                            _selectedTest4 == null &&
                                                gender == 'الجنس'
                                                ? setState(() {
                                              genderChosen = false;
                                            })
                                                : setState(() {
                                              genderChosen = true;
                                            });
                                            _formKey.currentState!.validate() &&
                                                _formKey2.currentState == null &&
                                                genderChosen == true
                                                ? updateInformation().then((value) =>
                                            {
                                              countryChanged
                                                  ? setState(() {
                                                helper = 0;
                                                countryChanged = false;
                                                celebrities =
                                                    fetchCelebrities(
                                                        userToken!);
                                              })
                                                  : Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const MainScreen()),
                                              ),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                Text(value.message!.ar!),
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
                                          },
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
                                  (String? value) {},
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {
                                              _selectedTest4 == null &&
                                                  gender == 'الجنس'
                                                  ? setState(() {
                                                genderChosen = false;
                                              })
                                                  : setState(() {
                                                genderChosen = true;
                                              });
                                              _formKey.currentState!.validate() &&
                                                  _formKey2.currentState == null &&
                                                  genderChosen == true
                                                  ? updateInformation().then((value) =>
                                              {
                                                countryChanged
                                                    ? setState(() {
                                                  helper = 0;
                                                  countryChanged = false;
                                                  celebrities =
                                                      fetchCelebrities(
                                                          userToken!);
                                                })
                                                    : Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const MainScreen()),
                                                ),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                  Text(value.message!.ar!),
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
                                            },
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
                                  (String? value) {},
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {
                                              _selectedTest4 == null &&
                                                  gender == 'الجنس'
                                                  ? setState(() {
                                                genderChosen = false;
                                              })
                                                  : setState(() {
                                                genderChosen = true;
                                              });
                                              _formKey.currentState!.validate() &&
                                                  _formKey2.currentState == null &&
                                                  genderChosen == true
                                                  ? updateInformation().then((value) =>
                                              {
                                                countryChanged
                                                    ? setState(() {
                                                  helper = 0;
                                                  countryChanged = false;
                                                  celebrities =
                                                      fetchCelebrities(
                                                          userToken!);
                                                })
                                                    : Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const celebrityHomePage()),
                                                ),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                  Text(value.message!.ar!),
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
                                            },
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
                                  (String? value) {},
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {
                                              _selectedTest4 == null &&
                                                  gender == 'الجنس'
                                                  ? setState(() {
                                                genderChosen = false;
                                              })
                                                  : setState(() {
                                                genderChosen = true;
                                              });
                                              _formKey.currentState!.validate() &&
                                                  _formKey2.currentState == null &&
                                                  genderChosen == true
                                                  ? updateInformation().then((value) =>
                                              {
                                                countryChanged
                                                    ? setState(() {
                                                  helper = 0;
                                                  countryChanged = false;
                                                  celebrities =
                                                      fetchCelebrities(
                                                          userToken!);
                                                })
                                                    : Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const MainScreen()),
                                                ),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                  Text(value.message!.ar!),
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
                                            },
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
                                  (String? value) {},
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {
                                              _selectedTest4 == null &&
                                                  gender == 'الجنس'
                                                  ? setState(() {
                                                genderChosen = false;
                                              })
                                                  : setState(() {
                                                genderChosen = true;
                                              });
                                              _formKey.currentState!.validate() &&
                                                  _formKey2.currentState == null &&
                                                  genderChosen == true
                                                  ? updateInformation().then((value) =>
                                              {
                                                countryChanged
                                                    ? setState(() {
                                                  helper = 0;
                                                  countryChanged = false;
                                                  celebrities =
                                                      fetchCelebrities(
                                                          userToken!);
                                                })
                                                    : Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const celebrityHomePage()),
                                                ),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                  Text(value.message!.ar!),
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
                                            },
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
                                  (String? value) {},
                                ),
                                gradientContainerWithHeight(
                                  getSize(context).width / 4,
                                  47,
                                  Container(
                                    child: Center(
                                        child: InkWell(
                                            onTap: () {
                                              _selectedTest4 == null &&
                                                  gender == 'الجنس'
                                                  ? setState(() {
                                                genderChosen = false;
                                              })
                                                  : setState(() {
                                                genderChosen = true;
                                              });
                                              _formKey.currentState!.validate() &&
                                                  _formKey2.currentState == null &&
                                                  genderChosen == true
                                                  ? updateInformation().then((value) =>
                                              {
                                                countryChanged
                                                    ? setState(() {
                                                  helper = 0;
                                                  countryChanged = false;
                                                  celebrities =
                                                      fetchCelebrities(
                                                          userToken!);
                                                })
                                                    : Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const MainScreen()),
                                                ),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                  Text(value.message!.ar!),
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
                                            },
                                            child: text(
                                                context, 'اضافة', 14, black,
                                                align: TextAlign.center))),
                                  ),
                                ),
                              ),

                              //===================== button ================================

                              const SizedBox(
                                height: 30,
                              ),
                              padding(
                                15,
                                15,
                                gradientContainerNoborder(
                                    getSize(context).width,
                                    buttoms(context, 'حفظ', 20, white, () {

                                      (currentPassword.text != null &&
                                                  newPassword.text != null) ||
                                              (currentPassword
                                                      .text.isNotEmpty &&
                                                  newPassword.text.isNotEmpty)
                                          ? {
                                              _formKey2.currentState == null
                                                  ? null
                                                  : _formKey2.currentState!
                                                          .validate()
                                                      ? {
                                                          newPassword.text ==
                                                                  confirmPassword
                                                                      .text
                                                              ? {
                                                                  changePassword().then((value) =>
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content:
                                                                            Text('${value.message!.ar}'),
                                                                      ))),
                                                                  updateInformation()
                                                                      .whenComplete(() =>
                                                                          fetchCelebrities(
                                                                              userToken!)),

                                                                }
                                                              : setState(() {
                                                                  noMatch =
                                                                      true;
                                                                })
                                                        }
                                                      : null,
                                            }
                                          : null;
                                      _selectedTest4 == null &&
                                              gender == 'الجنس'
                                          ? setState(() {
                                              genderChosen = false;
                                            })
                                          : setState(() {
                                              genderChosen = true;
                                            });
                                      _formKey.currentState!.validate() &&
                                              _formKey2.currentState == null &&
                                              genderChosen == true
                                          ?
                                     { loadingDialogue(context),
                                      updateInformation().then((value) =>
                                              {
                                                Navigator.pop(context),
                                                countryChanged
                                                    ? setState(() {
                                                        helper = 0;
                                                        countryChanged = false;
                                                        celebrities =
                                                            fetchCelebrities(
                                                                userToken!);
                                                      })
                                                    : Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MainScreen()),
                                                      ),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text(value.message!.ar!),
                                                )),
                                           //   goToPagePushRefresh(context, celebratyProfile, {})

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
                                              })}
                                          : null;
                                    })),
                              ),
                              const SizedBox(
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

  // eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDAzNzUwY2MyNjFjNDY1NjY2YjcwODJlYjgzYmFmYzA0ZjQzMGRlYzEyMzAwYTY5NTE1ZDNlZTYwYWYzYjc0Y2IxMmJiYzA3ZTYzODAwMWYiLCJpYXQiOjE2NTMxMTY4MjcuMTk0MDc3OTY4NTk3NDEyMTA5Mzc1LCJuYmYiOjE2NTMxMTY4MjcuMTk0MDg0ODgyNzM2MjA2MDU0Njg3NSwiZXhwIjoxNjg0NjUyODI3LjE5MDA0ODkzMzAyOTE3NDgwNDY4NzUsInN1YiI6IjExIiwic2NvcGVzIjpbXX0.GUQgvMFS-0VA9wOAhHf7UaX41lo7m8hRm0y4mI70eeAZ0Y9p2CB5613svXrrYJX74SfdUM4y2q48DD-IeT67uydUP3QS9inIyRVTDcEqNPd3i54YplpfP8uSyOCGehmtl5aKKEVAvZLOZS8C-aLIEgEWC2ixwRKwr89K0G70eQ7wHYYHQ3NOruxrpc_izZ5awskVSKwbDVnn9L9-HbE86uP4Y8B5Cjy9tZBGJ-6gJtj3KYP89-YiDlWj6GWs52ShPwXlbMNFVDzPa3oz44eKZ5wNnJJBiky7paAb1hUNq9Q012vJrtazHq5ENGrkQ23LL0n61ITCZ8da1RhUx_g6BYJBvc_10nMuwWxRKCr9l5wygmIItHAGXxB8f8ypQ0vLfTeDUAZa_Wrc_BJwiZU8jSdvPZuoUH937_KcwFQScKoL7VuwbbmskFHrkGZMxMnbDrEedl0TefFQpqUAs9jK4ngiaJgerJJ9qpoCCn4xMSGl_ZJmeQTQzMwcLYdjI0txbSFIieSl6M2muHedWhWscXpzzBhdMOM87cCZYuAP4Gml80jywHCUeyN9ORVkG_hji588pvW5Ur8ZzRitlqJoYtztU3Gq2n6sOn0sRShjTHQGPWWyj5fluqsok3gxpeux5esjG_uLCpJaekrfK3ji2DYp-wB-OBjTGPUqlG9W_fs
  Future<CelebrityInformation> updateInformation() async {
    categoriesId.forEach((key, value) {
      if (value == category) {
        print(key);
        print(key.toString() +
            '---------------------------------------------');
        catId = key+1;
      }
    });
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/celebrity/profile/update',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      },
      body: jsonEncode(<String, dynamic>{
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'phonenumber': phone.text,
        'country_id':
            _selectedTest3 == null ? 1 : countrylist.indexOf(_selectedTest3),
        'city_id': _selectedTest == null ? 1 : _selectedTest['no'],
        'category_id':
            _selectedTest2 == null ? catId : categorylist.indexOf(_selectedTest2),
        'snapchat': snapchat.text,
        'tiktok': tiktok.text,
        'youtube': youtube.text,
        'instagram': instagram.text,
        'twitter': twitter.text,
        'facebook': facebook.text,
        'description': desc.text,
        'gender_id': _selectedTest4 == null ? 1 : _selectedTest4['no'],
      }),
    );
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

  Future<CelebrityInformation> changePassword() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';

    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/celebrity/password/change',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
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
      return CelebrityInformation.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

//getCountries--------------------------------------------------------------------

  Future<CountryL> fetCountries() async {
    final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/countries'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
        setState(() {
          getid.putIfAbsent(
              i, () => jsonDecode(response.body)['data'][i]['name']);
        });
      }
      return CountryL.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  Future<CityL> fetCities(int countryId) async {
    final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/cities/$countryId'),
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

//   //get celebrity Categories--------------------------------------------------------------------
  Future<CategoryL> fetCategories() async {
    final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/categories'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
        setState(() {
          print(jsonDecode(response.body)['data'][i]['name']);
          categoriesId.putIfAbsent(
              i, () => jsonDecode(response.body)['data'][i]['name']);
        });
      }
      return CategoryL.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  Future<CelebrityInformation> fetchCelebrities(String tokenn) async {
    String token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';
    final response = await http.get(
        Uri.parse('https://mobile.celebrityads.net/api/celebrity/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenn'
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
}

// @override
// TODO: implement wantKeepAlive
// bool get wantKeepAlive => true;

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
  Gender? gender;
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
      this.gender,
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
    gender =
        json['gender'] != null ? new Gender.fromJson(json['gender']) : null;
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
    data['gender'] = this.gender;
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

class CountryL {
  bool? success;
  List<DataCountry>? data;
  MessageCountry? message;

  CountryL({this.success, this.data, this.message});

  CountryL.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataCountry>[];
      json['data'].forEach((v) {
        data!.add(new DataCountry.fromJson(v));
      });
    }
    message = json['message'] != null
        ? new MessageCountry.fromJson(json['message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class DataCountry {
  String? name;
  String? nameEn;
  String? flag;

  DataCountry({this.name, this.nameEn, this.flag});

  DataCountry.fromJson(Map<String, dynamic> json) {
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

class MessageCountry {
  String? en;
  String? ar;

  MessageCountry({this.en, this.ar});

  MessageCountry.fromJson(Map<String, dynamic> json) {
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

class CityL {
  bool? success;
  List<Datacity>? data;
  Message? message;

  CityL({this.success, this.data, this.message});

  CityL.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Datacity>[];
      json['data'].forEach((v) {
        data!.add(new Datacity.fromJson(v));
      });
    }
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Gender {
  int? id;
  String? name;
  String? nameEn;
  Gender({this.name, this.nameEn, this.id});
  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class Datacity {
  String? name;
  String? nameEn;
  int? id;
  Datacity({this.name, this.nameEn, this.id});

  Datacity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['id'] = this.id;
    return data;
  }
}

class CategoryL {
  bool? success;
  List<DataCategory>? data;
  Message? message;

  CategoryL({this.success, this.data, this.message});

  CategoryL.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataCategory>[];
      json['data'].forEach((v) {
        data!.add(new DataCategory.fromJson(v));
      });
    }
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class DataCategory {
  String? name;
  String? nameEn;

  DataCategory({this.name, this.nameEn});

  DataCategory.fromJson(Map<String, dynamic> json) {
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

class MessageCategory {
  String? en;
  String? ar;

  MessageCategory({this.en, this.ar});

  MessageCategory.fromJson(Map<String, dynamic> json) {
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
