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
          ListView.separated(
            itemCount: 3,
            separatorBuilder: (BuildContext context, int index) { return Divider(color: black,);},
            itemBuilder: (BuildContext context, int index) {

              return
                InkWell(
                  child: Card(
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    'assets/image/user.png',
                                    fit: BoxFit.fill,
                                    height: 48.h,
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    text(context, 'مروان بابلو', 14, black),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    text(context, ' 12/10/2021', 13,
                                        grey!),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Container(
                                      height: 40.h,
                                      width: 250.w,
                                      child: text(
                                          context, 'هذا هو محتوى التنبيه للمشهور', 13, black),
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
