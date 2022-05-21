import 'dart:ui';

import 'package:celepraty/Account/LoggingSingUpAPI.dart';
import 'package:celepraty/Celebrity/Requests/Ads/RequestAPI.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AdvDetials.dart';

class Advertisment extends StatefulWidget {
  const Advertisment({Key? key}) : super(key: key);

  @override
  State<Advertisment> createState() => _AdvertismentState();
}

class _AdvertismentState extends State<Advertisment> {
  String token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    getAdvertisingOrder(token);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, i) {
            return InkWell(
                onTap: () {
                  goTopagepush(context, AdvDetials(i: i));
                },
                child: Column(
                  children: [
                    body(i),
                  ],
                ));
          }),
    );
  }

  Widget body(int i) {
    return container(
        200,
        double.infinity,
        18,
        18,
        Colors.white,
        Column(
          children: [
//image-----------------------------------------

            Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.h),
                      topRight: Radius.circular(10.h),
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                          adsImage[i],
                        ),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black45, BlendMode.darken)),
                  ),
// 7odory-----------------------------------------
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: text(
                                context,
                                "حضوري",
                                18,
                                white,
                                fontWeight: FontWeight.bold,
                              ))),

//date and icon-------------------------------------------------------------

                      Row(
                        children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: text(
                                context,
                                "12/12/2022",
                                18,
                                white,
                                fontWeight: FontWeight.bold,
                              )),
                          // Align(
                          //     alignment: Alignment.bottomLeft,
                          //     child: Icon(clander,color:deepblue) ),
                          SizedBox(width: 10.w),
                        ],
                      )
                    ],
                  )),
            ),

//detaiels-----------------------------------------

            Expanded(
                flex: 1,
                child: Row(
                  children: [
//type-------------------------------------------------
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: text(
                                  context,
                                  "النوع",
                                  12,
                                  black,
                                )),
                            Expanded(
                                flex: 1,
                                child: text(context, "منتج", 12, pink,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    divider(),
//owner-------------------------------------------------

                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: text(
                                  context,
                                  "المالك",
                                  12,
                                  black,
                                )),
                            Expanded(
                                flex: 1,
                                child: text(context, "فرد", 12, pink,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    divider(),
//time-------------------------------------------------

                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: text(
                                  context,
                                  "الوقت",
                                  12,
                                  black,
                                )),
                            Expanded(
                                flex: 1,
                                child: text(context, "مساء", 12, pink,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                  ],
                ))
          ],
        ),
        bottomLeft: 10,
        bottomRight: 10,
        topLeft: 10,
        topRight: 10,
        marginB: 15,
        blur: 5,
        marginT: 5);
  }
}
