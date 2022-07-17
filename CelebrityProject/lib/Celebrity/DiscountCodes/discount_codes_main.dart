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
import 'package:lottie/lottie.dart';
import '../../Account/LoggingSingUpAPI.dart';

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
  ///future discount model variable
  Future<DiscountModel>? discount;
  String? userToken;


  @override
  void initState() {
    DatabaseHelper.getToken().then((value) {
      setState(() {
        userToken = value;
        discount = fetchDiscountCode(userToken!);
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Future _refreshProducts(BuildContext context) async {
    setState(() {
      discount = fetchDiscountCode(userToken!);
    });
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
                                        CreateNewDiscountCodeHome()));
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


                ///Expanded ListView
                RefreshIndicator(
                  onRefresh: () => _refreshProducts(context),
                  child: FutureBuilder<DiscountModel>(
                    future: discount,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: mainLoad(context));
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                          //---------------------------------------------------------------------------
                        } else if (snapshot.hasData) {
                          return snapshot.data!.data!.promoCode!.isNotEmpty ? Stack(
                            children:[
                              Padding(
                                  padding: EdgeInsets.only(top: 50.h, right: 20.w),
                                  child: text(context, "الاكواد الحالية", 25, ligthtBlack),
                                ),

                              Positioned(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 100.h),
                                  child: ListView.builder(
                                    itemCount:
                                    snapshot.data!.data!.promoCode!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ExpansionTile(
                                          title: text(
                                              context,
                                              snapshot.data!.data!.promoCode![index]
                                                  .code!,
                                              16,
                                              black),

                                          /// the word and color change depend on end date time ///

                                          subtitle: text(
                                              context,
                                              snapshot.data!.data!.promoCode![index]
                                                  .status!.name!,
                                              16,
                                              snapshot.data!.data!.promoCode![index]
                                                  .status!.id ==
                                                  1
                                                  ? green
                                                  : Colors.red),

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
                                                          snapshot
                                                              .data!
                                                              .data!
                                                              .promoCode![index]
                                                              .discountType!,
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
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .promoCode![index]
                                                                .numOfPerson!
                                                                .toString(),
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
                                                        for (int i = 0;
                                                        i <
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .promoCode![
                                                            index]
                                                                .adTypes!
                                                                .length;
                                                        i++)
                                                          text(
                                                            context,
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .promoCode![
                                                            index]
                                                                .adTypes![i]
                                                                .name! +
                                                                '  ',
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
                                                          'من ' +
                                                              snapshot
                                                                  .data!
                                                                  .data!
                                                                  .promoCode![index]
                                                                  .dateFrom! +
                                                              ' الى ' +
                                                              snapshot
                                                                  .data!
                                                                  .data!
                                                                  .promoCode![index]
                                                                  .dateTo!,
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
                                                          snapshot
                                                              .data!
                                                              .data!
                                                              .promoCode![index]
                                                              .description!,
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
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        CreateNewDiscountCodeHome(
                                                                            putId:
                                                                            index),
                                                                  ));
                                                            },
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                                removeDiscount),
                                                            color: red
                                                                ?.withOpacity(0.8),
                                                            onPressed: () => showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext context) => AlertDialog(
                                                                title: Directionality(
                                                                    textDirection: TextDirection.rtl,
                                                                    child: text(context, 'حذف كود الخصم', 16, black,)),
                                                                content: Directionality(
                                                                    textDirection: TextDirection.rtl,
                                                                    child: text(context, 'هل انت متأكد من حذف كود الخصم؟', 14, black,)),
                                                                actions: <Widget>[
                                                                  Padding(
                                                                    padding:  EdgeInsets.only(top: 10.h,),
                                                                    child: TextButton(
                                                                        onPressed: () =>
                                                                            Navigator.pop(
                                                                                context,
                                                                                'الغاء'),
                                                                        child: text(context, 'الغاء', 15, purple)
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:  EdgeInsets.only(top: 10.h, right: 0.w),
                                                                    child: TextButton(
                                                                        onPressed: () => setState(() {
                                                                          deleteDiscountCode(
                                                                              userToken!, snapshot
                                                                              .data!
                                                                              .data!
                                                                              .promoCode![
                                                                          index]
                                                                              .id!);
                                                                          Navigator.pop(
                                                                              context,
                                                                              'حذف');

                                                                        }),
                                                                        child: text(context, 'حذف', 15, purple)
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            ///delete the discount code
                                                            ///Alert dialog to conform
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
                              ),
                            ],
                          ) : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                    height: 160.h,
                                    width: 160.w,
                                    child: Lottie.asset(
                                        'assets/lottie/noDiscount.json')),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              text(
                                context,
                                "لا توجد أكواد خصم لعرضها حاليا",
                                15,
                                black,
                              )
                            ],
                          );
                        } else {
                          return const Center(child: Text('No info to show!!'));
                        }
                      } else {
                        return Center(
                            child: Text('State: ${snapshot.connectionState}'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///GET
  Future<DiscountModel> fetchDiscountCode(String token) async {
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

  ///DELETE
  Future<http.Response> deleteDiscountCode(String token, int id) async {
    final http.Response response = await http.delete(
      Uri.parse(
          'https://mobile.celebrityads.net/api/celebrity/promo-codes/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    setState(() {
      discount = fetchDiscountCode(userToken!);
    });
    return response;
  }
}
