import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class blockList extends StatefulWidget {
  _blockListState createState() => _blockListState();
}

class _blockListState extends State<blockList> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("قائمة المحظورين", context),
        body: Stack(
          children: [
            Container(
              height: 300.h,
              width: 1000.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.7, 2.0),
                    end: Alignment(-0.69, -1.0),
                    colors: [
                      Color(0xff0ab3d0).withOpacity(0.60),
                      Color(0xffe468ca).withOpacity(0.80)
                    ],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r))),
            ),
            paddingg(
              10,
              10,
              20,
              ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return paddingg(
                    8,
                    8,
                    5,
                    SizedBox(
                      height: 150.h,
                      width: 300.w,
                      child: Card(
                        elevation: 10,
                        color: white,
                        child: paddingg(
                          0,
                          0,
                          12,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              paddingg(
                                15,
                                35,
                                0,
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      'assets/image/user.png',
                                      fit: BoxFit.fill,
                                      height: 90.h,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  text(context, 'مروان بابلو', 14, black),
                                  text(context, 'وقت الحظر: 12/10/2021', 14,
                                      black),
                                  text(
                                      context, 'الحظر بسبب الازعاج', 14, black),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      gradientContainerNoborder2(
                                        80,
                                        33,
                                        buttoms(context, 'فك الحظر', 12, white,
                                            () {}),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      InkWell(
                                          child: Container(
                                            width: 80.w,
                                            height: 33.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r)),
                                                border: Border.all(
                                                    color: deepBlack)),
                                            child: Center(
                                                child: text(
                                                    context, 'ابلاغ', 12, black,
                                                    align: TextAlign.center)),
                                          ),
                                          onTap: () {}),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
