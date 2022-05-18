///import section
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../celebrity/HomeScreen/celebrity_home_page.dart';
import 'ModelDiscountCode.dart';

///CreateNewDiscountCodeHome
class CreateNewDiscountCodeHome extends StatefulWidget {
  final int? putId;
  bool get isUpdate => putId != null;

  const CreateNewDiscountCodeHome({Key? key, this.putId}) : super(key: key);

  @override
  _CreateNewDiscountCodeHomeState createState() =>
      _CreateNewDiscountCodeHomeState();
}

class _CreateNewDiscountCodeHomeState extends State<CreateNewDiscountCodeHome>
    with AutomaticKeepAliveClientMixin {
  Future<DiscountModel>? discount;

  List<int> saveList = [];
  bool isValue1 = false;

  ///Text Field
  final _formKey = GlobalKey<FormState>();
  TextEditingController discountCode = TextEditingController();
  TextEditingController discountValue = TextEditingController();
  TextEditingController numberOfUsers = TextEditingController();
  TextEditingController description = TextEditingController();

  DateTime currentStart = DateTime.now();
  DateTime currentEnd = DateTime.now();

  ///discount go to list

  var list = {
    1: false,
    2: false,
    3: false,
  };

  var listName = {
    1: 'اعلان',
    2: 'اهداء',
    3: 'مساحة اعلانية',
  };

  ///_value
  int? _value = 1;

  int? helper = 0;
  int? helper1 = 0;
  int? helper2 = 0;
  int? helper3 = 0;


  @override
  void initState() {
    super.initState();
    discount = fetchDiscountCode();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: drowAppBar(widget.isUpdate ?  'تعديل كود الخصم' : 'إنشاء كود خصم جديد' , context),
          body: SafeArea(
            child: FutureBuilder<DiscountModel>(
                future: discount,
                builder: (BuildContext context,
                    AsyncSnapshot<DiscountModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: loading(context));
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));

                      ///if has data
                    } else if (snapshot.hasData) {
                      widget.putId != null ?

                          /// Update Case - if we have id fill the text fields otherwise null
                          {
                              ///Fill the text fields with info
                              if (helper3 == 0)
                                {
                                  discountCode.text = snapshot.data!.data!
                                      .promoCode![widget.putId!].code!,
                                  discountValue.text = snapshot.data!.data!
                                      .promoCode![widget.putId!].discount!
                                      .toString(),
                                  numberOfUsers.text = snapshot.data!.data!
                                      .promoCode![widget.putId!].numOfPerson!
                                      .toString(),
                                  description.text = snapshot.data!.data!
                                      .promoCode![widget.putId!].description!,
                                  helper3 = 1,
                                },

                              ///Discount type
                              if (helper == 0)
                                {
                                  snapshot.data!.data!.promoCode![widget.putId!]
                                              .discountType! ==
                                          "مبلغ ثابت"
                                      ? _value = 1
                                      : _value = 2,
                                  helper = 1,
                                },

                              ///Put a check sign on AD type
                              if (helper1 == 0){
                                for (int i = 0; i < snapshot.data!.data!
                                    .promoCode![widget.putId!].adTypes!
                                    .length; i++){
                                  list.containsKey(snapshot.data!.data!
                                      .promoCode![widget.putId!].adTypes![i].id)
                                      ? list[snapshot.data!.data!
                                      .promoCode![widget.putId!].adTypes![i]
                                      .id!] = true : false,
                                  helper1 = 1,
                                },
                                for(int j = 0; j < list.length; j++){
                                  list[j] == true ? saveList.add(j) : null
                                },
                              },

                              ///Fetch the date from database and store in right variables
                              if (helper2 == 0)
                                {
                                  currentStart = DateTime.parse(snapshot
                                      .data!
                                      .data!
                                      .promoCode![widget.putId!]
                                      .dateFrom!),
                                  currentEnd = DateTime.parse(snapshot.data!
                                      .data!.promoCode![widget.putId!].dateTo!),
                                  helper2 = 1,
                                }
                            }
                          : const SizedBox();

                      return Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ///Title
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 20.h, right: 20.w),
                                            child: text(
                                                context,
                                                widget.isUpdate ? 'تعديل معلومات كود الخصم' : 'إنشاء كود خصم جديد',
                                                20,
                                                ligthtBlack),
                                          ),
                                        ),

                                        ///subTitle
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10.h, right: 20.w),
                                            child: text(
                                                context,
                                                widget.isUpdate ?
                                                'يمكنك الان تعديل كود الخصم الخاص بك يمكنك الان تعديل كود الخصم\n الخاص بك' :
                                                'يمكنك الان انشاء كود خصم جديد خاص بك يمكنك الان انشاء كود خصم\n جديد خاص بك' ,
                                                12,
                                                ligthtBlack),
                                          ),
                                        ),

                                        ///--------------------------Text Field Section--------------------------
                                        ///discount code
                                        Column(
                                          children: [
                                            paddingg(
                                              15,
                                              15,
                                              12,
                                              textFieldNoIcon(
                                                  context,
                                                  'أدخل كود الخصم',
                                                  12,
                                                  false,
                                                  discountCode,
                                                  (String? value) {
                                                /// Validation text field
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              }, false),
                                            ),

                                            ///Select The Type of Support
                                            Container(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.h, right: 20.w),
                                                child: text(
                                                    context,
                                                    "اختر نوع الخصم",
                                                    18,
                                                    ligthtBlack,
                                                    family: 'DINNextLTArabic'),
                                              ),
                                            ),

                                            ///Type of discount
                                            paddingg(
                                              15,
                                              15,
                                              9,

                                              ///The Radio Buttons
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 3.h, right: 2.w),
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Transform.scale(
                                                          scale: 0.8,
                                                          child: Radio<int>(
                                                              value: 1,
                                                              groupValue:
                                                                  _value,
                                                              activeColor:
                                                                  purple,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _value =
                                                                      value;
                                                                  isValue1 =
                                                                      false;
                                                                });
                                                              }),
                                                        ),
                                                        text(
                                                            context,
                                                            "مبلغ ثابت",
                                                            14,
                                                            ligthtBlack,
                                                            family:
                                                                'DINNextLTArabic'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Transform.scale(
                                                          scale: 0.8,
                                                          child: Radio<int>(
                                                              value: 2,
                                                              groupValue:
                                                                  _value,
                                                              activeColor:
                                                                  purple,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _value =
                                                                      value;
                                                                  isValue1 =
                                                                      true;
                                                                });
                                                              }),
                                                        ),
                                                        text(
                                                            context,
                                                            "نسبة مئوية",
                                                            14,
                                                            ligthtBlack,
                                                            family:
                                                                'DINNextLTArabic'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            ///-----------------------------------------------------
                                            ///Value of discount
                                            paddingg(
                                              15,
                                              15,
                                              12,

                                              ///-------in case with مبلغ ثابت the text will be ادخل مبلغ الخصم-------///
                                              textFieldNoIcon(
                                                  context,
                                                  isValue1
                                                      ? 'أدخل النسبة المئوية'
                                                      : 'أدخل مبلغ الخصم',
                                                  12,
                                                  false,
                                                  discountValue,
                                                  (String? value) {
                                                /// Validation text field
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              }, false),
                                            ),

                                            ///number of users
                                            paddingg(
                                              15,
                                              15,
                                              12,
                                              textFieldNoIcon(
                                                  context,
                                                  'أدخل عدد الاشخاص المستفيدين',
                                                  12,
                                                  false,
                                                  numberOfUsers,
                                                  (String? value) {
                                                /// Validation text field
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              }, false),
                                            ),

                                            ///description
                                            paddingg(
                                              15,
                                              15,
                                              12,
                                              textFieldDesc(
                                                context,
                                                'الوصف الخاص بكود الخصم',
                                                12,
                                                false,
                                                description,
                                                (String? value) {
                                                  /// Validation text field
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),

                                            ///Check box
                                            SizedBox(
                                              height: 15.h,
                                            ),

                                            padding(
                                                8,
                                                20,
                                                text(context, 'الخصم الى', 14,
                                                    black,
                                                    fontWeight:
                                                        FontWeight.bold)),

                                            SizedBox(
                                              height: 150.h,
                                              child: ListView(
                                                children:
                                                    list.keys.map((int key) {
                                                  return CheckboxListTile(
                                                    title: Text(listName[key]!),
                                                    value: list[key],
                                                    selected: list[key]!,
                                                    activeColor:
                                                        Colors.deepPurple[400],
                                                    checkColor: Colors.white,
                                                    onChanged: (bool? valueF) {
                                                      setState(() {
                                                        list[key] = valueF!;
                                                        if (!saveList.contains(
                                                                key) &&
                                                            list[key] == true) {
                                                          saveList.add(key);
                                                        }
                                                        if (list[key] ==
                                                                false &&
                                                            saveList.contains(
                                                                key)) {
                                                          saveList.remove(key);
                                                        }
                                                      });
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                            ),

                                            ///Determine the Start and end date
                                            Container(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5.h, right: 20.w),
                                                child: text(
                                                    context,
                                                    'تحديد عدد الايام المتاح بها الكود',
                                                    18,
                                                    ligthtBlack),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  margin: EdgeInsets.only(
                                                      right: 20.w, top: 10.h),
                                                  child: InkWell(
                                                    child:
                                                        gradientContainerNoborder2(
                                                      120,
                                                      40,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            scheduale,
                                                            color: white,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          text(
                                                              context,
                                                              'تاريخ البداية',
                                                              15.sp,
                                                              white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      DateTime? startDate =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  currentStart,
                                                              firstDate:
                                                                  DateTime(
                                                                      2000),
                                                              lastDate:
                                                                  DateTime(
                                                                      2100));
                                                      if (startDate == null) {
                                                        return;
                                                      }
                                                      setState(() {
                                                        currentStart =
                                                            startDate;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //end date
                                            Container(
                                              alignment: Alignment.topRight,
                                              margin: EdgeInsets.only(
                                                  right: 20.w, top: 10.h),
                                              child: InkWell(
                                                child:
                                                    gradientContainerNoborder2(
                                                  120,
                                                  40,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        scheduale,
                                                        color: white,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      text(
                                                          context,
                                                          'تاريخ النهاية',
                                                          15.sp,
                                                          white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () async {
                                                  DateTime? endDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              currentEnd,
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime(2100));
                                                  if (endDate == null) return;
                                                  setState(() {
                                                    currentEnd = endDate;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),

                                        ///Save box
                                        SizedBox(
                                          height: 50.h,
                                        ),
                                        padding(
                                          15,
                                          15,
                                          gradientContainerNoborder(
                                              getSize(context).width,
                                              buttoms(context, widget.isUpdate ? 'حفظ التغيرات' : 'حفظ', 20, white,
                                                  () {
                                                widget.putId != null
                                                    ? updateDiscountCode(
                                                        snapshot
                                                            .data!
                                                            .data!
                                                            .promoCode![
                                                                widget.putId!]
                                                            .id!)
                                                    : createNewDiscountCode();
                                                fetchDiscountCode();

                                                Navigator.pop(context);
                                              })),
                                        ),
                                        SizedBox(
                                          height: 50.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );

                      ///if no data to show
                    } else {
                      return const Center(child: Text('No info to show!!'));
                    }
                  } else {
                    return Center(
                        child: Text('State: ${snapshot.connectionState}'));
                  }
                }),
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  ///POST
  Future<http.Response> createNewDiscountCode() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pgcaQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ6nLbyu1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';
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
        'code': discountCode.text,
        'discount_type': isValue1 == true ? 'مبلغ ثابت' : 'نسبة مئوية',
        'discount': discountValue.text,
        'num_of_person': numberOfUsers.text,
        'description': description.text,
        'ad_type_ids': saveList,
        'date_from': currentStart.toString(),
        'date_to': currentEnd.toString()
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

  ///GET
  Future<DiscountModel> fetchDiscountCode() async {
    String token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pgcaQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ6nLbyu1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';
    final response = await http.get(
        Uri.parse('https://mobile.celebrityads.net/api/celebrity/promo-codes'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);

      return DiscountModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  ///UPDATE
  Future<http.Response> updateDiscountCode(int id) async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pgcaQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ6nLbyu1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/celebrity/promo-codes/update/$id',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      body: jsonEncode(<String, dynamic>{
        'code': discountCode.text,
        'discount_type': _value == 1 ? 'مبلغ ثابت' : 'نسبة مئوية',
        'discount': discountValue.text,
        'num_of_person': numberOfUsers.text,
        'description': description.text,
        'ad_type_ids': saveList,
        'date_from': currentStart.toString(),
        'date_to': currentEnd.toString()
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print(response.body);
      setState(() {
        discount = fetchDiscountCode();
      });
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }
}
