//UserGiftDetials

import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Account/UserForm.dart';
import '../../../Celebrity/chat/chat_Screen.dart';


class UserGiftDetials extends StatefulWidget {
  int? i;
  final String? description;
  final int? price;
  final String? advTitle;
  final String? advType;
  final String? platform;
  final String? token;
  final int? state;
  final int? orderId;
  final String? rejectResonName;
  final int? rejectResonId;

  UserGiftDetials(
      {Key? key,
        this.description,
        this.price,
        this.advTitle,
        this.advType,
        this.platform,
        this.token,
        this.state,
        this.orderId,
        this.rejectResonName,
        this.rejectResonId,
        this.i})
      : super(key: key);

  @override
  State<UserGiftDetials> createState() => _UserGiftDetialsState();
}

class _UserGiftDetialsState extends State<UserGiftDetials> {
  int? resonRejectId;
  String? resonReject;
  bool isReject = true;
  List<String> rejectResonsList = [];
  TextEditingController reson = TextEditingController();
  GlobalKey<FormState> resonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getRejectReson();
    print(rejectResonsList);
  }

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 900;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: drowAppBar("تفاصيل طلبات الاهداء",context),
            body:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 25.h,
              ),
//image-----------------------------------------------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Column(
                    children: [

//ad title-----------------------------------------------------
                      Container(
                        // color: black,
                        width: double.infinity,
                        height: 50.h,
                        margin: EdgeInsets.only(
                            left: 9.w, right: 15.w, bottom: 0.w, top: 8.w),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
//ايقونه الاهداء-------------------------------------------------
                                Icon(gift, color: amber),
//نص الاهداء-------------------------------------------------

                                text(
                                  context,
                                  " اهداء ل${widget.advTitle}",
                                  20,
                                  deepgrey!,
                                  fontWeight: FontWeight.bold,
                                  align: TextAlign.justify,
                                  space: 3,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 0.w,
                      ),
//ad type-----------------------------------------------------

                      Container(
                        // color: black,
                        width: double.infinity,
                        height: 50.h,
                        margin: EdgeInsets.only(
                            left: 9.w, right: 15.w, bottom: 0.w, top: 8.w),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
//ايقونه نوع الاهداء-------------------------------------------------

                                Icon(
                                  voiceIcon,
                                  color: blue,
                                  size: 25.sp,
                                ),
//نوع الاهداء-------------------------------------------------

                                text(
                                  context,
                                  " اهداء " + widget.advType!,
                                  16,
                                  blue,
                                  fontWeight: FontWeight.bold,
                                  align: TextAlign.justify,
                                  space: 3,
                                ),
                              ],
                            )),
                      ),

//description----------------------------------------------------------------------
                      Container(
                        //color: black,
                        width: double.infinity,
                        height: 100.h,

                        margin:
                        EdgeInsets.only(left: 22.w, right: 22.w, bottom: 8.w),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Flex(
                              direction:
                              isScreenWide ? Axis.horizontal : Axis.vertical,
                              children: [
                                text(
                                  context,
                                  widget.description!,
                                  13,
                                  deepgrey!,

                                  fontWeight: FontWeight.bold,
                                  //align: TextAlign.justify,
                                  space: 3,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              isReject
                  ? Container(
                  width: double.infinity,
                  height: 50,
                  //color: Colors.red,
                  margin: EdgeInsets.all(20.r),
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: gradientContainer(
                        double.infinity,
                        buttoms(
                          context,
                          widget.state == 4
                              ? "لقد قبلت الطلب"
                              : widget.state == 3
                              ? 'قبول'
                              : widget.state == 2
                              ? 'قبول من المتابع'
                              : widget.state == 6
                              ? 'تم الدفع'
                              : 'قبول',
                          15,
                          widget.state == 4 ||
                              widget.state == 3 ||
                              widget.state == 2 ||
                              widget.state == 5 ||
                              widget.state == 6
                              ? deepBlack
                              : white,
                          widget.state == 4 ||
                              widget.state == 3 ||
                              widget.state == 2 ||
                              widget.state == 5 ||
                              widget.state == 6
                              ? null
                              : () {
                            loadingDialogue(context);
                            // Future<bool> result = acceptAdvertisingOrder(
                            //     widget.token!,
                            //     widget.orderId!,
                            //     widget.price!);
                            // result.then((value) {
                            //   if (value == true) {
                            //     Navigator.pop(context);
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(snackBar(context,
                            //         'تم قبول الطلب', green, done));
                            //   } else {
                            //     Navigator.pop(context);
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(snackBar(
                            //         context,
                            //         'تم قبول الطلب مسبقا',
                            //         red,
                            //         error));
                            //   }
                            // });
                          },
                          evaluation: 0,
                        ),
                        height: 50,
                        color: widget.state == 4 ||
                            widget.state == 3 ||
                            widget.state == 2 ||
                            widget.state == 5 ||
                            widget.state == 6
                            ? deepBlack
                            : Colors.transparent,
                        gradient: widget.state == 4 ||
                            widget.state == 3 ||
                            widget.state == 2 ||
                            widget.state == 5 ||
                            widget.state == 6
                            ? true
                            : false,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),

//reject buttom-------------------------------------------------

                    Expanded(
                      flex: 2,
                      child: gradientContainer(
                        double.infinity,
                        buttoms(
                          context,
                          widget.state == 3
                              ? "لقد رفضت الطلب "
                              : widget.state == 4
                              ? 'رفض'
                              : widget.state == 5
                              ? 'رفض من المتابع'
                              : widget.state == 6
                              ? 'رفض'
                              : 'رفض',
                          15,
                          widget.state == 3 ||
                              widget.state == 4 ||
                              widget.state == 5 ||
                              widget.state == 2 ||
                              widget.state == 6
                              ? deepgrey!
                              : black,
                          widget.state == 4 ||
                              widget.state == 3 ||
                              widget.state == 5 ||
                              widget.state == 2 ||
                              widget.state == 6
                              ? null
                              : () {
                            rejectResonsList.isNotEmpty
                                ? showBottomSheetModel(context)
                                : '';
                          },
                          //evaluation: 1,
                        ),
                        height: 50,
                        gradient: true,
                        color: widget.state == 3 ||
                            widget.state == 4 ||
                            widget.state == 5 ||
                            widget.state == 2 ||
                            widget.state == 6
                            ? deepBlack
                            : pink,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
//---------------------------------------------------------
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: widget.state == 3
                                      ? null
                                      : () {
                                    goTopagepush(context, chatScreen());
                                  },
                                  child: Icon(Icons.forum_outlined,
                                      color: widget.state == 3
                                          ? deepBlack
                                          : pink)))
                        ],
                      ),
                    ),
                    //height: 50,
                    //gradient: true,
                    //),
                    //)
                  ]))
                  :
//confirm reject---------------------------------------------------------------
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: text(
                        context,
                        'سبب الرفض',
                        18,
                        deepgrey!,
                        fontWeight: FontWeight.bold,
                        align: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 15.h),
//-------------------------------------------------------------------------
                    resonReject == 'أخرى'
                        ? Form(
                      key: resonKey,
                      child: textField2(
                        context,
                        Icons.unpublished,
                        '',
                        14,
                        false,
                        reson,
                        empty,
                      ),
                    )
                        : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: text(
                        context,
                        '$resonReject',
                        18,
                        deepBlack,
                        //fontWeight: FontWeight.bold,
                        align: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 8),
                    //--------------------------------
                    //const Spacer(),
                    gradientContainer(
                      double.infinity,
                      buttoms(
                        context,
                        "تاكيد",
                        15,
                        white,
                            () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (resonReject == 'أخرى') {
                            if (resonKey.currentState?.validate() == true) {
                              loadingDialogue(context);
                              // Future<bool> result = rejectAdvertisingOrder(
                              //     widget.token!,
                              //     widget.orderId!,
                              //     reson.text,
                              //     0);
                              // result.then((value) {
                              //   if (value == true) {
                              //     Navigator.pop(context);
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //         snackBar(context, 'تم رفض الطلب', green,
                              //             done));
                              //   } else {
                              //     Navigator.pop(context);
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //         snackBar(context, 'تم رفض الطلب مسبقا',
                              //             red, error));
                              //   }
                              // });
                            }
                          } else {
                            loadingDialogue(context);
                            // Future<bool> result = rejectAdvertisingOrder(
                            //     widget.token!,
                            //     widget.orderId!,
                            //     resonReject!,
                            //     resonRejectId!);
                            // result.then((value) {
                            //   if (value == true) {
                            //     Navigator.pop(context);
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         snackBar(context, 'تم رفض الطلب', green,
                            //             done));
                            //   } else {
                            //     Navigator.pop(context);
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         snackBar(context, 'تم رفض الطلب مسبقا',
                            //             red, error));
                            //   }
                            // });
                          }
                        },
                        evaluation: 0,
                      ),
                      height: 50,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ])));
  }

  //----------------------------------------------------------------------------------------------
  showBottomSheetModel(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        elevation: 10,
        backgroundColor: black,
        //isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(70.r), topLeft: Radius.circular(70.r)),
          //side: BorderSide(color: Colors.white, width: 1),
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 10),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(50.r))),
                  width: MediaQuery.of(context).size.width / 9,
                  height: 4.h,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
//Reject reson-----------------------------------------------------------------------------
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.7.h,
                  child: ListView.builder(
                      itemCount: rejectResonsList.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0.w, vertical: 3.h),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                resonReject = rejectResonsList[i];
                                resonRejectId = i;
                                isReject = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 46.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                  color: deepPink),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: text(
                                  context,
                                  rejectResonsList[i],
                                  15,
                                  white,
                                  fontWeight: FontWeight.bold,
                                  align: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
//Another reson-----------------------------------------------------------------------------

              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 3.h),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      resonReject = 'أخرى';
                      isReject = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 46.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0.r),
                        color: deepPink),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: text(
                        context,
                        'أخرى',
                        15,
                        white,
                        fontWeight: FontWeight.bold,
                        align: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

//-------------------------------------------------------------------------
  void getRejectReson() async {
    String url = "https://mobile.celebrityads.net/api/reject-resons";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (int i = 0; i < body['data'].length; i++) {
        rejectResonsList.add(body['data'][i]['name']);
      }
    } else {
      throw Exception('Failed to load celebrity Reject reson');
    }
  }
}
//

//
