///import section
import 'dart:convert';

import 'package:celepraty/Celebrity/DiscountCodes/ModelDiscountCode.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/DiscountCodes/create_new_discount_code.dart';
import 'package:flutter/material.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../HomeScreen/celebrity_home_page.dart';

class DiscountCodes extends StatelessWidget {
  const DiscountCodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("أكواد الخصم", context),
        body: const HomeBodyDiscount(),
      ),
    );
  }
}

///-------------------------HomeBody Discount-------------------------
class HomeBodyDiscount extends StatefulWidget {
  const HomeBodyDiscount({Key? key}) : super(key: key);

  @override
  _HomeBodyDiscountState createState() => _HomeBodyDiscountState();
}

class _HomeBodyDiscountState extends State<HomeBodyDiscount> {
  Future<DiscountModel>? discount;

  @override
  void initState() {
    discount = fetchDiscountCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100.w,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: gradientContainerNoborder(
                        120.0,
                        buttoms(
                          context,
                          "انشاء كود جديد",
                          15,
                          white,
                              () {
                            ///Go to create a new discount code screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                    const CreateNewDiscountCode()));
                          },
                          evaluation: 0,
                        ),
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h, right: 20.w),
                    child: text(context, "الاكواد الحالية", 25, ligthtBlack),
                  ),
                ),

                ///Expanded ListView
                FutureBuilder<DiscountModel>(
                    future: discount,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: loading(context));
                      } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          //throw snapshot.error.toString();
                          return Center(child: Text(snapshot.error.toString()));
                          //---------------------------------------------------------------------------
                        } else if (snapshot.hasData) {
                          return Positioned(
                            child: Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: ListView.builder(
                                itemCount: snapshot.data!.data!.promoCode!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ExpansionTile(
                                      title: text(context, snapshot.data!.data!.promoCode![index].code!,
                                          16, black),
                                      subtitle: text(context,
                                          'غير صالح للاستخدام', 16, green),

                                      ///Inside each list
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10.h, right: 15.w),
                                          height: 180.h,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                ///Type of discount
                                                Row(
                                                  children: [
                                                    GradientIcon(
                                                        typeOfDiscount,
                                                        25.w,
                                                        const LinearGradient(
                                                          begin: Alignment(
                                                              0.7, 2.0),
                                                          end: Alignment(
                                                              -0.69, -1.0),
                                                          colors: [
                                                            Color(0xff0ab3d0),
                                                            Color(0xffe468ca)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        )),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    text(
                                                      context,
                                                      snapshot.data!.data!.promoCode![index].discountType!,
                                                      15.sp,
                                                      black,
                                                    ),
                                                  ],
                                                ),

                                                ///Number of users
                                                Row(
                                                  children: [
                                                    GradientIcon(
                                                        numberOfUsers,
                                                        25.w,
                                                        const LinearGradient(
                                                          begin: Alignment(
                                                              0.7, 2.0),
                                                          end: Alignment(
                                                              -0.69, -1.0),
                                                          colors: [
                                                            Color(0xff0ab3d0),
                                                            Color(0xffe468ca)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        )),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    text(
                                                        context,
                                                        snapshot.data!.data!.promoCode![index].numOfPerson!.toString(),
                                                        15.sp,
                                                        black),
                                                  ],
                                                ),

                                                ///Discount go to
                                                Row(
                                                  children: [
                                                    GradientIcon(
                                                        copun,
                                                        25.w,
                                                        const LinearGradient(
                                                          begin: Alignment(
                                                              0.7, 2.0),
                                                          end: Alignment(
                                                              -0.69, -1.0),
                                                          colors: [
                                                            Color(0xff0ab3d0),
                                                            Color(0xffe468ca)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        )),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    text(
                                                      context,
                                                      snapshot.data!.data!.promoCode![index].adType!.name!,
                                                      15.sp,
                                                      black,
                                                    ),
                                                  ],
                                                ),

                                                ///Duration
                                                Row(
                                                  children: [
                                                    GradientIcon(
                                                        duration,
                                                        25.w,
                                                        const LinearGradient(
                                                          begin: Alignment(
                                                              0.7, 2.0),
                                                          end: Alignment(
                                                              -0.69, -1.0),
                                                          colors: [
                                                            Color(0xff0ab3d0),
                                                            Color(0xffe468ca)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        )),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    text(
                                                      context,
                                                      snapshot.data!.data!.promoCode![index].dateFrom! + ' ' + snapshot.data!.data!.promoCode![index].dateFrom!,
                                                      15.sp,
                                                      black,
                                                    ),
                                                  ],
                                                ),

                                                ///Description
                                                Row(
                                                  children: [
                                                    GradientIcon(
                                                        discountDes,
                                                        25.w,
                                                        const LinearGradient(
                                                          begin: Alignment(
                                                              0.7, 2.0),
                                                          end: Alignment(
                                                              -0.69, -1.0),
                                                          colors: [
                                                            Color(0xff0ab3d0),
                                                            Color(0xffe468ca)
                                                          ],
                                                          stops: [0.0, 1.0],
                                                        )),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    text(
                                                      context,
                                                      snapshot.data!.data!.promoCode![index].description!,
                                                      15.sp,
                                                      black,
                                                    ),
                                                  ],
                                                ),

                                                ///Two button edit and delete
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        padding:
                                                        EdgeInsets.only(
                                                            right: 20.w),
                                                        icon:
                                                        Icon(editDiscount),
                                                        color: black
                                                            .withOpacity(0.8),
                                                        onPressed: () {
                                                          ///go to create new discount to edit the code

                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                            removeDiscount),
                                                        color: red
                                                            ?.withOpacity(0.8),
                                                        onPressed: () {
                                                          ///delete the discount code
                                                          ///Alert dialog to conform
                                                          setState(() {
                                                            deleteDiscountCode(snapshot.data!.data!.promoCode![index].id!);
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text('No info to show!!'));
                        }
                      } else {
                        return Center(
                            child: Text('State: ${snapshot.connectionState}'));
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
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
      print(response.body);
      return DiscountModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }



///UPDATE
  Future<http.Response> updateNews(int id) async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI'
        '3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1O'
        'DYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0'
        '.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9'
        'DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pg'
        'caQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ip'
        'asx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJ'
        'c3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ6nLbyu1i'
        '4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/celebrity/promo-codes/update/${id}',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      // body: jsonEncode(<String, dynamic>{
      //   'code' : ,
      //   'discount_type' : ,
      //   'discount': ,
      //   'num_of_person':,
      //   'description':,
      //   'ad_type_id':,
      //   'date_from':,
      //   'date_to':
      // }),
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
///DELETE
  Future<http.Response> deleteDiscountCode(int id) async {
    String token2 = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTM'
        'yNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwi'
        'bmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic'
        '2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzs'
        'uRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pgcaQhE'
        'Y3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10'
        '-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDH'
        'KgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ6nLbyu1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_Z'
        'tqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';

    final http.Response response = await http.delete(
      Uri.parse('https://mobile.celebrityads.net/api/celebrity/promo-codes/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
    );

    setState(() {
      discount = fetchDiscountCode();
    });

    return response;
  }
}
