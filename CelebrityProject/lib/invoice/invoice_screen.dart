import 'dart:convert';
import 'dart:io';

import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/invoice/Invoice.dart';
import 'package:celepraty/invoice/ivoice_info_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../Account/LoggingSingUpAPI.dart';
import 'InvoicePdf.dart';
//import 'package:pdf/widgets.dart' as pw;

class invoiceScreen extends StatefulWidget {
  _invoiceScreenState createState() => _invoiceScreenState();
}

class _invoiceScreenState extends State<invoiceScreen> {
  Future<InvoiceModel>? invoices;

  String? desc;
  List<String> imagePaths = [];
  final imagePicker = ImagePicker();
  final file = File('example.pdf');
  //  final pdf = pw.Document();
  DateTime date = DateTime.now();
  String? userToken;

  @override
  void initState() {
    DatabaseHelper.getToken().then((value) {
      setState(() {
        userToken = value;
        invoices = getInvoices();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: drowAppBar('الفوترة', context),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  text(context, '    الطلبات المالية ', 17, black),

                  FutureBuilder<InvoiceModel>(
                      future: invoices,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: mainLoad(context));
                        } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                            //---------------------------------------------------------------------------
                          } else if (snapshot.hasData) {
                             return snapshot.data!.data!.billings!.isEmpty?  Padding(
                               padding:  EdgeInsets.only(top: getSize(context).height/4),
                               child: Center(child: text(context, 'لا يوجد فواتير لعرضهم حاليا', 18, black),),
                             ):
                              Column(
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data!.billings!.length,
                                  itemBuilder: (context, index) {
                                    desc =snapshot.data!.data!.billings![index].order!.adType!.name! == "اعلان" ? ' طلب'+ snapshot.data!.data!.billings![index].order!.adType!.name! + ' ل' +
                                        snapshot.data!.data!.billings![index].order!.advertisingAdType!.name! :
                                    snapshot.data!.data!.billings![index].order!.adType!.name! == "اهداء"? ' طلب ' +snapshot.data!.data!.billings![index].order!.adType!.name! +' / '+ snapshot.data!.data!.billings![index].order!.giftType!.name! + " بمناسبة  " + 'عيد ميلاد':
                                    snapshot.data!.data!.billings![index].order!.adType!.name! == "مساحة اعلانية"?  ' طلب '+'مساحة اعلانية':'';
                                    return Card(
                                        elevation: 3,
                                        child: ExpansionTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.receipt_long,
                                                      color:
                                                          black.withOpacity(0.80),
                                                      size: 27,
                                                    ),
                                                    SizedBox(width: 20.w),
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          text(
                                                              context,
                                                              snapshot.data!.data!.billings![index].user!.name!,
                                                              16,
                                                              black),
                                                          text(
                                                              context,
                                                              snapshot.data!.data!.billings![index].price!.toString() +
                                                                  " ر.س",
                                                              15,
                                                              green),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                text(
                                                    context,
                                                    snapshot.data!.data!.billings![index].date.toString(),
                                                    12,
                                                    grey!),
                                              ],
                                            ),
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10.h),
                                                  height: 70.h,
                                                  decoration: BoxDecoration(
                                                    color: fillWhite,
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: lightGrey
                                                                .withOpacity(
                                                                    0.10))),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 15.0.w),
                                                        child: text(context,
                                                            'التفاصيل', 12, grey!),
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Container(
                                                          child: text(
                                                              context,
                                                        snapshot.data!.data!.billings![index].order!.description != null? snapshot.data!.data!.billings![index].order!.description! : '',
                                                              14,
                                                              black),
                                                          width: 200.w,
                                                          margin: EdgeInsets.only(
                                                              right: 10.w),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 10.w),
                                                        child: Row(children: [
                                                          InkWell(
                                                            child: Icon(
                                                              Icons.info_outlined,
                                                              size: 20,
                                                            ),
                                                            onTap: () {
                                                              showBottomSheettInvoice(
                                                                  context,
                                                                  invoice(index));
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: 15.w,
                                                          ),
                                                          InkWell(
                                                            child: GradientIcon(
                                                              Icons.share,
                                                              20,
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
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              final pdf = await InvoicePdf.createInvoicePDF(snapshot.data!.data!.billings![index].order!.id!.toString(), snapshot.data!.data!.billings![index].billingId.toString(), snapshot.data!.data!.billings![index].date.toString(), snapshot.data!.data!.taxnumber.toString(),
                                                                  snapshot.data!.data!.phone.toString(), snapshot.data!.data!.billings![index].celebrity!.phonenumber.toString(),
                                                                  snapshot.data!.data!.billings![index].celebrity!.country!.name!, snapshot.data!.data!.billings![index].celebrity!.name!, snapshot.data!.data!.billings![index].price.toString(), snapshot.data!.data!.billings![index].priceAfterTax.toString(),
                                                                  snapshot.data!.data!.billings![index].paymentMehtod!.name!, desc!);
                                                              InvoicePdf.openFile(pdf);
                                                            },
                                                          ),
                                                        ]),
                                                      ),
                                                    ],
                                                  ))
                                            ]));
                                  },
                            ),
                                ],
                              );
                          } else {
                            return const Center(
                                child: Text('لايوجد فواتير لعرضهم حاليا'));
                          }
                        } else {
                          return Center(
                              child:
                                  Text('State: ${snapshot.connectionState}'));
                        }
                      })
                ],
              ),
            ),
          )),
    );
  }

  Widget invoice(index) {
    return SingleChildScrollView(
      child: FutureBuilder<InvoiceModel>(
        future: invoices,
        builder: (context, snapshot) {
      if (snapshot.connectionState ==
          ConnectionState.waiting) {
        return Center();
      } else if (snapshot.connectionState ==
          ConnectionState.active ||
          snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
          //---------------------------------------------------------------------------
        } else if (snapshot.hasData) {
          return Column(
          children: [
            Column(
              children: [
                InkWell(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 450.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: lightGrey.withOpacity(0.30)),
                      ),
                      Container(
                        width: 60.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: GradientText(
                        'منصة المشاهير',
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold),
                        colors: const [Color(0xff0ab3d0), Color(0xffe468ca)],
                      ),
                    ),
                    Image.asset(
                      'assets/image/log.png',
                      height: 90.h,
                      width: 90.w,
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: text(
                              context,
                              snapshot.data!.data!.billings![index].date!.toString(),
                              15,
                              grey!)),
                      text(context, 'فاتورة ضريبية', 18, black.withOpacity(0.75),
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
                ),
                padding(
                  15,
                  15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      text(context, snapshot.data!.data!.billings![index].order!.id.toString() + '#', 18, black.withOpacity(0.75),
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 15.h,
                      ),
                      text(context, 'رقم الطلب : ' + snapshot.data!.data!.billings![index].order!.id.toString(), 15, black),
                      text(context, 'رقم الفاتورة : '+  snapshot.data!.data!.billings![index].billingId.toString(), 15, black),
                      Divider(
                        color: black,
                      )
                    ],
                  ),
                ),
                padding(
                    15,
                    15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text(context, ': مصدرة من ', 18, blue,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: text(context, "منصة المشاهير", 15, black),
                                margin: EdgeInsets.only(left: 30.w)),
                            text(context, ': الموقع الالكتروني', 15,
                                black.withOpacity(0.75),
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: text(context, snapshot.data!.data!.taxnumber!, 15, black),
                              margin: EdgeInsets.only(left: 10.w),
                            ),
                            text(context, ': الرقم الضريبي', 15,
                                black.withOpacity(0.75),
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: text(context, snapshot.data!.data!.phone!, 15, black),
                                margin: EdgeInsets.only(left: 10.w)),
                            text(context, ': الهاتف', 15, black.withOpacity(0.75),
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        Divider(
                          color: black,
                        )
                      ],
                    )),
                padding(
                    15,
                    15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text(context, ': مصدرة الى ', 18, pink,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: text(context, snapshot.data!.data!.billings![index].celebrity!.country!.name!, 15, black),
                                margin: EdgeInsets.only(left: 75.w)),
                            Container(
                                child: text(context, snapshot.data!.data!.billings![index].celebrity!.name!, 15,
                                    black.withOpacity(0.75),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          child: text(context, snapshot.data!.data!.billings![index].celebrity!.phonenumber!
                              , 15, black),
                          margin: EdgeInsets.only(left: 30.w),
                          alignment: Alignment.bottomLeft,
                        ),
                        Divider(
                          color: black,
                        )
                      ],
                    )),
                padding(
                    15,
                    15,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text(context, 'تفاصيل الدفع', 17, black.withOpacity(0.75),
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: text(context,  snapshot.data!.data!.billings![index].price.toString() + " ر . س", 15, blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                margin: EdgeInsets.only(left: 50.w)),
                            text(context, ': المبلغ', 17, blue,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: text(context, snapshot.data!.data!.billings![index].paymentMehtod!.name!, 15, black),
                              margin: EdgeInsets.only(left: 50.w),
                            ),
                            Container(
                                child: text(context, ':طريقة الدفع', 15,
                                    black.withOpacity(0.75),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    )),
                Container(
                  color: grey!.withOpacity(0.40),
                  height: 45.h,
                  margin: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          text(context, 'المجموع', 15, black),
                          SizedBox(
                            width: 50.w,
                          ),
                          text(context, 'السعر', 15, black),
                          SizedBox(
                            width: 20.w,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          text(context, 'المنتج', 15, black),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),

                              Container(
                                width: 150.w,
                                child: text(
                                    context,
                                      snapshot.data!.data!.billings![index].order!.adType!.name! == "اعلان" ? ' طلب'+ snapshot.data!.data!.billings![index].order!.adType!.name! + ' ل' +
                                          snapshot.data!.data!.billings![index].order!.advertisingAdType!.name! :
                                      snapshot.data!.data!.billings![index].order!.adType!.name! == "اهداء"? ' طلب ' +snapshot.data!.data!.billings![index].order!.adType!.name! +' / '+ snapshot.data!.data!.billings![index].order!.giftType!.name! + " بمناسبة  " + 'عيد ميلاد':
                                      snapshot.data!.data!.billings![index].order!.adType!.name! == "مساحة اعلانية"?  ' طلب '+'مساحة اعلانية':'',
                                    13.5,
                                    black),
                              ),
                              // SizedBox(width: 10.w,),
                              // Image.asset('assets/image/logo.png', height: 50.h, width: 50.w,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 30.w,
                              ),
                              text(context, snapshot.data!.data!.billings![index].price!.toString() + " ر . س  ", 15, black),
                              SizedBox(
                                width: 40.w,
                              ),
                              text(context, snapshot.data!.data!.billings![index].price!.toString() + " ر . س  ", 15, black),
                              SizedBox(
                                width: 20.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(
                        color: black,
                        thickness: 1.5,
                      ),


                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              text(context, 'اجمالي الطلب', 15, black),
                            ],
                          ),
                          Row(
                            children: [
                              text(context, snapshot.data!.data!.billings![index].priceAfterTax! + ' ر . س ', 15, black),
                              SizedBox(
                                width: 20.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(
                        color: black,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      text(
                          context,
                          'شكرا لتعاملكم مع منصتنا ,,, نتمنى لكم يوما رائعا',
                          17,
                          black.withOpacity(0.75),
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(
                        color: black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
        } else {
          return const Center(
              child: Text('لايوجد فواتير لعرضهم حاليا'));
        }
      } else {
        return Center(
            child:
            Text('State: ${snapshot.connectionState}'));
      }
        })
    );
  }

  Future<InvoiceModel> getInvoices() async {
    String token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDI4MTY3ZWY1YWE0ZDBjZWQ0MDBjOTViMzBmNWQwZGFiNmY4MzgxMWU3YTUwMWUyMmYwMmMyZGU2YjRjOTIwOGI0MjFjNmZjZGM3YWMzZjUiLCJpYXQiOjE2NTM5ODg2MjAuNjgyMDE4OTk1Mjg1MDM0MTc5Njg3NSwibmJmIjoxNjUzOTg4NjIwLjY4MjAyNDk1NTc0OTUxMTcxODc1LCJleHAiOjE2ODU1MjQ2MjAuNjczNjY3OTA3NzE0ODQzNzUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.OguFfzEWNOyCU4xSZ_PbLwg1xmyEbIMYAQ-J9wRApGKMq0qo1aEiM1OvcfvEaopxRiKngk-ckebhhcl7MRtGopNZcNjJwp9jWS7yZuyH7DBvct0O6tys47HL4eBU0QLwgmxMmh8nLkADARdIvVdZJFw9vLp-7X-4Huj6I2E1SFjeYnV6l7Fu_c1BYMAJmXpBwIALxTvwxg8tbxuhKmFBtLnnY3K25Tedra9IMc0nR_nXV3ifXdp4v7fsvbCLLYNr5ihc3ElE_QWczOvkkYeOPTP4yFMFlZFpWUNeER5wiEdbcO6WzzxzCRkLXriedWDI3G6qOrMAUAjiAUxS51--_7x9iI0qHalXHyGxgudUnAHGNsYpvLJ8JVCM2k_dtGazmZtA5w5wDSTI8gSuWUZxf2OpQNCmyt8k80Pbi_Olz2xDMSuDKYmiomWrUhwIwunk_gsU9lC5oLcEzJ2BLcaiiuwFex9xraMbbC1ZyipSIZZhW1l1CppYeYmPSxLC8hEIywRy5Lbvw-WQ25CpurNgEMiHefGooDxCsHqnkfWCQ1MnFAGiEs2hPtG7DVp8RArzCyXXaVrtVi2wbBFrCPDK52yNQxQjs3z8JBNlDwEFR2uDa-VRup61j2WESvyUKPMloD7gL7FsthAl6IZquYh7XujHWEcf1Lnprd6D5J6CPWM';
    final response = await http.get(
        Uri.parse('https://mobile.celebrityads.net/api/celebrity/billings'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return InvoiceModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }
}
