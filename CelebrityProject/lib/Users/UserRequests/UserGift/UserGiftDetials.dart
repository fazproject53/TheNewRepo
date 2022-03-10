import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class UserGiftDetials extends StatefulWidget {
  int? i;
  UserGiftDetials({this.i});

  @override
  State<UserGiftDetials> createState() => _UserGiftDetialsState();
}


class _UserGiftDetialsState extends State<UserGiftDetials> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 900;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            //appBar: drowAppBar("تفاصيل الطلب",context),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.h,
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
                  Container(
                    //color: black,
                    width: double.infinity,
                    height: 50.h,
                    margin:
                    EdgeInsets.only(left: 20.w, right: 20.w, bottom: 0.w, top: 20.w),
                    child:  Align(
                        alignment: Alignment.topRight,
                        child:InkWell(
                          onTap:() {
                            Navigator.pop(context);
                          },
                            child: Icon(Icons.arrow_back_ios_sharp, color: black))


                           ,
                    ),
                  ),
//ad titel-----------------------------------------------------
                  Container(
                   // color: black,
                    width: double.infinity,
                    height: 50.h,
                    margin:
                    EdgeInsets.only(left: 9.w, right: 15.w, bottom: 0.w, top: 8.w),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
//ايقونه الاهداء-------------------------------------------------
                            Icon(gift, color: amber),
//نص الاهداء-------------------------------------------------

                            text(
                              context,
                              " اهداء ل${giftType[widget.i!]}",
                              20,
                              deepgrey!,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.justify,
                              space: 3,
                            ),

                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    height: 0.w,
                  ),
//ad type-----------------------------------------------------

                  Container(
                    // color: black,
                    width: double.infinity,
                    height: 50.h,
                    margin:
                    EdgeInsets.only(left: 9.w, right: 15.w, bottom: 0.w, top: 8.w),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [

//ايقونه نوع الاهداء-------------------------------------------------

                            Icon(voiceIcon, color: blue,size: 25.sp,),
//نوع الاهداء-------------------------------------------------

                            text(
                              context,
                              " اهداء صوتي",
                              16,
                              blue,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.justify,
                              space: 3,
                            ),
                          ],
                        )
                    ),
                  ),

//description----------------------------------------------------------------------
                  Container(
                    //color: black,
                    width: double.infinity,
                    height: 100.h,
                    margin: EdgeInsets.only(left: 9.w, right: 9.w, bottom: 8.w),
                    child: Align(
                        alignment: Alignment.center,
                        child: Flex(
                          direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                          children: [
                            text(
                              context,
                              "اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء اهداء ",
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
                        )


                    ),
                  ),

//accapt buttom-----------------------------------------------------


                  Padding(
                    padding: const EdgeInsets.all(8.0),
//price--------------------------------------------------------------
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: pink,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15.r,
                                ),
                                text(context, "5200", 16, white,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  width: 3.r,
                                ),
                                Icon(Icons.paid, size: 20.sp,color: white,),
                              ],
                            ))),
                  ),
                ],
              ),
            ),
          ),
                  Spacer(),
                  Container(
                      width: double.infinity,
                      height: 50,
                      //color: Colors.red,
                      margin: EdgeInsets.all(20),
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: gradientContainer(
                            double.infinity,
                            buttoms(
                              context,
                              "قبول",
                              15,
                              white,
                                  () {},
                              evaluation: 0,
                            ),
                            height: 50,
                            color: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),

//chat icon-------------------------------------------------

                        Expanded(
                          flex: 2,
                          child: gradientContainer(
                            double.infinity,
                            InkWell(
                              onTap: () {
                                print("go to chat home");
                              },
                              child: buttoms(
                                context,
                                "رفض ",
                                15,
                                black,
                                    () {},
                                //evaluation: 1,
                              ),
                            ),
                            height: 50,
                            gradient: true,
                            color: pink,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
//---------------------------------------------------------
                        const Expanded(
                            flex: 1,
                            //child:
                            //  gradientContainer(
                            //   double.infinity,
                            //   InkWell(
                            //       onTap: () {
                            //         print("go to chat home");
                            //       },
                            child: Icon(Icons.forum_outlined, color: pink)
                        ),
                        //height: 50,
                        //gradient: true,
                        //),
                        //)
                      ]
                      )
                  ),




        ]
            )
        ),
      )
      ,
    );
  }
}
//
