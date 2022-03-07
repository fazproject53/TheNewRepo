import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftDetials extends StatefulWidget {
  int? i;
  GiftDetials({this.i});

  @override
  State<GiftDetials> createState() => _GiftDetialsState();
}

class _GiftDetialsState extends State<GiftDetials> {
  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 900;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: drowAppBar("تفاصيل الطلب",context),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
//image-----------------------------------------------------
        Container(
          width: double.infinity,
          // height: double.infinity,
          margin: EdgeInsets.all(9.w),
          decoration: BoxDecoration(
              boxShadow: const [BoxShadow(blurRadius: 1)],

              color: deepwhite,
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),

              ),

          ),
          child: Column(
            children: [
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
                        Icon(gift, color: pink),
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
                        SizedBox(
                          width: 10.w,
                        ),
                        divider(),
                        SizedBox(
                          width: 10.w,
                        ),
//ايقونه نوع الاهداء-------------------------------------------------

                        Icon(voiceIcon, color: pink),
//نوع الاهداء-------------------------------------------------

                        text(
                          context,
                          " اهداء صوتي",
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
                height: 20.w,
              ),
//description----------------------------------------------------------------------
              Container(
                //color: black,
                width: double.infinity,
                height: 130.h,
                margin: EdgeInsets.only(left: 9.w, right: 9.w, bottom: 8.w),
                child: Align(
                    alignment: Alignment.center,
                    child: Flex(
                      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                      children: [
                        text(
                          context,
                          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
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
                            text(context, "5200", 15, white,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              width: 3.r,
                            ),
                            Icon(Icons.paid, size: 20.r),
                          ],
                        ))),
              ),
            ],
          )

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
                              pink,
                                  () {},
                              //evaluation: 1,
                            ),
                          ),
                          height: 50,
                          gradient: true,
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
                          child: Icon(Icons.textsms_outlined, color: pink)
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
      )
      ,
    );
  }
}
//
