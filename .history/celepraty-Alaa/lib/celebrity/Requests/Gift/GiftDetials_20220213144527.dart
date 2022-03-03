import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/Variables.dart';
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          // appBar: drowAppBar("تفاصيل الطلب"),
          body: Column(children: [
//image-----------------------------------------------------
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            // height: double.infinity,
            margin: EdgeInsets.all(9.w),
            decoration: BoxDecoration(
                boxShadow: const [BoxShadow(blurRadius: 2)],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.r),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    giftImage[widget.i!],
                  ),
                  fit: BoxFit.cover,
                )),
            child: Padding(
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
          ),
        ),
//ad titel-----------------------------------------------------

        Container(
          //color: black,
          width: double.infinity,
          margin: EdgeInsets.only(left: 9.w, right: 9.w, bottom: 8.w, top: 8.w),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Icon(Icons.card_giftcard_rounded, color: amber),
                  text(
                    context,
                    " اهداء ل${giftType[widget.i!]}",
                    20,
                    deepgrey!,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.justify,
                  ),
                 
                ],
              )),
        ),
//description----------------------------------------------------------------------
        Expanded(
          flex: 1,
          child: Container(
            color: deepwhite,
            margin: EdgeInsets.all(8.w),
            child: text(
              context,
              " اريد طلب اهداء بمناسبة${giftType[widget.i!]} وايد ان يكون في صوره فيديو",
              15,
              grey!,
              fontWeight: FontWeight.bold,
              align: TextAlign.justify,
            ),
          ),
        ),

//accapt buttom-----------------------------------------------------

        Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.all(20),
            child: Row(children: [
              Expanded(
                flex:2,
                child: gradientContainer(
                  double.infinity,
                  buttoms(
                    context,
                    "قبول",
                    15,
                    white,
                    () {},
                    evaluation: 1,
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
                      child: Icon(Icons.textsms_outlined, color: pink)),
                  //height: 50,
                  //gradient: true,
                //),
              //)
            ]))
      ])),
    );
  }
}
//
