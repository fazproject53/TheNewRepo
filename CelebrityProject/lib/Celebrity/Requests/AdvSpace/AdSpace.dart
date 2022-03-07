import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdSpace extends StatefulWidget {
  const AdSpace({Key? key}) : super(key: key);

  @override
  State<AdSpace> createState() => _AdSpaceState();
}

class _AdSpaceState extends State<AdSpace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, i) {
            return body(i);
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
                  image: const DecorationImage(
                      image: AssetImage(
                       "assets/image/advspace.jpg"
                      ),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken)),
                ),
// مناسبه الاهداء-----------------------------------------
              ),
            ),

//detaiels-----------------------------------------

            Expanded(
                flex: 2,
                child: container(
                    double.infinity,
                    double.infinity,
                    0,
                    0,
                    blue,
                    Padding(
                      padding: EdgeInsets.only(
                          left: 8.0.w, right: 8.0.w, top: 8.0.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
//name--------------------------------------------------------------------------
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: white,
                                      size: 22.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    text(context, "احمد عبد العزيز", 16, white)
                                  ],
                                ),
//order number--------------------------------------------------------------------------

                                Row(
                                  children: [
                                    Icon(
                                      Icons.assignment_turned_in,
                                      color: white,
                                      size: 22.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    text(context, "100056076", 16, white)
                                  ],
                                ),
//date--------------------------------------------------------------------------
                                Row(
                                  children: [
                                    Icon(
                                      Icons.today,
                                      color: white,
                                      size: 22.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    text(context, "26/02/2022", 16, white),
                                    SizedBox(
                                      width: 120.w,
                                    ),
                                    Icon(
                                      Icons.copy,
                                      color: white,
                                      size: 22.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: white,
                                      size: 22.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Icon(
                                      Icons.chat,
                                      color: white,
                                      size: 22.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
//-----------------------------------------------------------------------------------------
                        ],
                      ),
                    ),
                    bottomLeft: 8,
                    bottomRight: 8)),
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