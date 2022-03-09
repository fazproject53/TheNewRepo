import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class notificationList extends StatefulWidget {
  _notificationListState createState() => _notificationListState();
}

class _notificationListState extends State<notificationList> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarNoIcon( 'التنبيهات'),
        body: paddingg(
          10.w,
          10.w,
          20.h,
          ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return
                InkWell(
                  child: Container(
                    height: 140.h,
                    child: Card(
                      elevation: 3,
                      child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 25.w),
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      'assets/image/user.png',
                                      fit: BoxFit.fill,
                                      height: 80.h,
                                      width: 90.w,
                                    ),
                                  ),
                                  SizedBox(width: 15.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      text(context, 'مروان بابلو', 15, black, fontWeight: FontWeight.w500),
                                      text(context, ' 12/10/2021', 14,
                                         black.withOpacity(0.80)),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Container(
                                        height: 45.h,
                                        width: 250.w,
                                        child: text(
                                            context, ' هذا هو محتوى التنبيه للمشهور هذا هو محتوى التنبيه للمشهور', 14, black.withOpacity(0.80)),
                                      ),


                                    ],
                                  ),
                                ],
                              ),





                            ],
                          ),

                    ),
                  ),
                  onTap: (){},
                );

            },
          ),
        ),
      ),
    );
  }
}
