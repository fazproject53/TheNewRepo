///import section
import 'package:celepraty/Celebrity/Calendar/calendar_info.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CelebrityCalenderMain extends StatelessWidget {
  const CelebrityCalenderMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("جدول المواعيد", context),
        body: const CelebrityCalenderHome(),
      ),
    );
  }
}

///---------------------CelebrityCalenderHome---------------------
class CelebrityCalenderHome extends StatefulWidget {
  const CelebrityCalenderHome({Key? key}) : super(key: key);

  @override
  _CelebrityCalenderHomeState createState() => _CelebrityCalenderHomeState();
}

class _CelebrityCalenderHomeState extends State<CelebrityCalenderHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Expanded(
          child: Stack(children: [
            Container(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 23.h, right: 20.w),
                child: text(context, 'الجدول الخاص بالمواعيد المتفق عليها', 17,
                    ligthtBlack),
              ),
            ),
            paddingg(
              10,
              10,
              60,

              ///ListView
              ListView.builder(
                itemCount: calenderList.length,
                itemBuilder: (context, index) {
                  return paddingg(
                    5,
                    12,
                    10,
                    SizedBox(
                      height: 80.h,
                      child: Card(
                        elevation: 20,
                        color: white,
                        shadowColor: Colors.black38,
                        child: paddingg(
                          0,
                          0,
                          0,

                          ///Row to store all info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              paddingg(
                                  10,
                                  2,
                                  0,
                                  Row(
                                    children: [
                                      Container(

                                        ///the box of date
                                        alignment: Alignment.center,
                                        height: 70.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment(0.8, 2.0),
                                              end: Alignment(-0.69, -1.0),
                                              colors: [
                                                Color(0xff0ab3d0)
                                                    .withOpacity(0.90),
                                                Color(0xffe468ca)
                                                    .withOpacity(0.90)
                                              ],
                                              stops: [0.0, 1.0],
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(10.r),
                                              topRight: Radius.circular(10.r),
                                              topLeft: Radius.circular(10.r),
                                            )),

                                        ///Text
                                        child: text(context,
                                            calenderList[index].date, 16, white,
                                            fontWeight: FontWeight.bold),
                                      ),

                                      ///SizedBox
                                      SizedBox(
                                        width: 20.w,
                                      ),

                                      ///type of order and date
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          text(
                                              context,
                                              calenderList[index].typeOfOrder,
                                              18,
                                              black.withOpacity(0.9)),
                                          text(
                                              context,
                                              calenderList[index].time,
                                              14,
                                              grey!.withOpacity(0.9)),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 7.w),
                                child: Row(children: [
                                  InkWell(
                                    child: Icon(
                                      infoIcon,
                                      size: 23,
                                      color: black,
                                    ),
                                    onTap: () {
                                      ///When chick the pop card will show with all details
                                      showDialogFunc(
                                          context,
                                          calenderList[index].personalName,
                                          calenderList[index].invoices,
                                          calenderList[index].date2,
                                          calenderList[index].typeOfOrder);
                                    },
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),

                                  InkWell(
                                    child: GradientIcon(
                                      share,
                                      25.w,
                                      const LinearGradient(
                                        begin: Alignment(0.7, 2.0),
                                        end: Alignment(-0.69, -1.0),
                                        colors: [
                                          Color(0xff0ab3d0),
                                          Color(0xffe468ca)
                                        ],
                                        stops: [0.0, 1.0],
                                      ),
                                    ),
                                    onTap: () {
                                      ///Click on it then you can share the details
                                    },
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

///This is a block of Model Dialog
showDialogFunc(context, personalName, invoices, date2, typeOfOrder) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: white,
            ),
            padding: EdgeInsets.only(top: 15.h, right: 20.w, left: 20.w),
            height: 210.h,
            width: 300.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///text
                    text(context, 'تفاصيل الموعد', 14, grey!),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,

                  ///icons
                  children: [
                    GradientIcon(
                        nameIcon,
                        25.w,
                        const LinearGradient(
                          begin: Alignment(0.7, 2.0),
                          end: Alignment(-0.69, -1.0),
                          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                          stops: [0.0, 1.0],
                        )),

                    ///sizedBox
                    SizedBox(
                      width: 5.w,
                    ),

                    ///text
                    text(context, personalName, 17.sp, black,
                        family: 'DINNextLTArabic'),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,

                  ///icons
                  children: [
                    GradientIcon(
                        invoiceIcon,
                        25.w,
                        const LinearGradient(
                          begin: Alignment(0.7, 2.0),
                          end: Alignment(-0.69, -1.0),
                          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                          stops: [0.0, 1.0],
                        )),

                    ///sizedBox
                    SizedBox(
                      width: 5.w,
                    ),

                    ///text
                    text(context, invoices, 17.sp, black,
                        family: 'DINNextLTArabic'),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,

                  ///icons
                  children: [
                    GradientIcon(
                        dateRange,
                        25.w,
                        const LinearGradient(
                          begin: Alignment(0.7, 2.0),
                          end: Alignment(-0.69, -1.0),
                          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                          stops: [0.0, 1.0],
                        )),

                    ///sizedBox
                    SizedBox(
                      width: 5.w,
                    ),

                    ///text
                    text(context, date2, 17.sp, black,
                        family: 'DINNextLTArabic'),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,

                  ///icons
                  children: [
                    GradientIcon(
                        orders,
                        25.w,
                        const LinearGradient(
                          begin: Alignment(0.7, 2.0),
                          end: Alignment(-0.69, -1.0),
                          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                          stops: [0.0, 1.0],
                        )),

                    ///sizedBox
                    SizedBox(
                      width: 5.w,
                    ),

                    ///text
                    text(context, typeOfOrder, 17.sp, black,
                        family: 'DINNextLTArabic'),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
