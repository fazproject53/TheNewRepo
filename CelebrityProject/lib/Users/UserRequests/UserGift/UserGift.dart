import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'UserGiftDetials.dart';

class UserGift extends StatefulWidget {
  const UserGift({Key? key}) : super(key: key);

  @override
  State<UserGift> createState() => _UserGiftState();
}

class _UserGiftState extends State<UserGift> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, i) {
            return InkWell(
                onTap: () {
                  goTopagepush(context, UserGiftDetials(i: i));
                },
                child: body(i));
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
                        giftImage[i],
                      ),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken)),
                ),
// مناسبه الاهداء-----------------------------------------

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: text(
                              context,
                              "اهداء ل" + giftType[i],
                              18,
                              white,
                              fontWeight: FontWeight.bold,
                            ))),

//icon-------------------------------------------------------------

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child:
                              Icon(vieduoIcon, color: deepwhite, size: 40.sp)),
                    ),
                  ],
                ),
              ),
            ),

//detaiels-----------------------------------------

            Expanded(
                flex: 1,
                child: Row(
                  children: [
//from to------------------------------------------
                    Expanded(
                        flex: 3,
                        child: Column(

                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 8.0.w,right: 8.0.w),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.volunteer_activism,
                                    color: blue,
                                  ),
                                  SizedBox(width: 10.w,),
                                  text(
                                      context, "عبد العزيز احمد", 14, blue,
                                      fontWeight: FontWeight.bold),
                                  Spacer(),
                                  const Icon(
                                    Icons.face_retouching_natural,
                                    color: pink,
                                  ),
                                  SizedBox(width: 10.w,),
                                  text(
                                      context, "عبد العزيز احمد", 14, pink,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
//stats-----------------------------------------------------------------------------------------
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 8.0.w,right: 8.0.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.fit_screen,
                                    color: green,

                                  ),
                                  SizedBox(width: 10.w,),
                                  text(context, "تم الموافقة", 12, green,
                                      ),

                                ],
                              ),
                            )
                          ],
                        )),
//date-----------------------------------------------------------------------
                    Expanded(
                      flex: 1,
                      child: gradientContainer(
                          double.infinity,
                          Padding(
                            padding: EdgeInsets.only(top: 8.0.h),
                            child: text(
                                context,
                                "يناير\n23",
                                //,
                                15,
                                white,
                                align: TextAlign.center,
                                fontWeight: FontWeight.bold),
                          ),
                          height: double.infinity,
                          color: Colors.transparent,
                          topLeft: 0,
                          topRight: 0,
                          bottomLeft: 10,
                          bottomRight: 0),
                    ),
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
/*
*
*
* */
