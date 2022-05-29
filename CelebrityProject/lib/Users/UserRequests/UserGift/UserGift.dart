import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Account/LoggingSingUpAPI.dart';
import 'UserGiftApi.dart';
import 'UserGiftDetials.dart';

class UserGift extends StatefulWidget {
  const UserGift({Key? key}) : super(key: key);

  @override
  State<UserGift> createState() => _UserGiftState();
}

class _UserGiftState extends State<UserGift>with AutomaticKeepAliveClientMixin  {

  String token = '';
  Future<UserGiftOrds>? userGiftRequests;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
       // token = value;
        token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxLr_AQhAzfEcqgasRrr32031veKVCd21rA';
        userGiftRequests = getUserGift(token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: userGiftRequests,
            builder: ((context, AsyncSnapshot<UserGiftOrds> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                      child: Center(child: Text(snapshot.error.toString())));
                  //---------------------------------------------------------------------------
                } else if (snapshot.hasData) {
                  return snapshot.data!.data!.giftOrders!.isNotEmpty
                      ? ListView.builder(
                      itemCount: snapshot.data!.data!.giftOrders!.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                            onTap: () {
                              // goTopagepush(context, GiftDetials(
                              //   i: i,
                              //   price: snapshot.data!.data!.giftOrders![i].price,
                              //   description:snapshot.data!.data!.giftOrders![i].description ,
                              //   advTitle:snapshot.data!.data!.giftOrders![i].occasion?.name ,
                              //   advType: snapshot.data!.data!.giftOrders![i].giftType?.name ,
                              //
                              // )
                              // );
                            },
                            child: Column(
                              children: [
                                getGiftOrder(
                                    i, snapshot.data!.data!.giftOrders),
                              ],
                            ));
                      })
                      : Center(
                      child: Center(
                          child: text(
                            context,
                            "لاتوجد طلبات لعرضها حاليا",
                            15,
                            black,
                          )));
                } else {
                  return text(
                    context,
                    "لاتوجد طلبات لعرضها حاليا",
                    15,
                    black,
                  );
                }
              } else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            })));
  }

  Widget  getGiftOrder(int i, List<GiftOrders>? giftOrders) {
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
                      image: NetworkImage(
                        giftOrders![i].occasion!.image!,
                        //advertisingOrders[0].user!.image!,
                      ),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.black45, BlendMode.darken)),
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
                              "اهداء ل" + giftOrders[i].occasion!.name!,
                              18,
                              white,
                              fontWeight: FontWeight.bold,
                            ))),

//icon-------------------------------------------------------------

                    Padding(
                      padding:  EdgeInsets.all(8.0.r),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: giftOrders[i].giftType!.name == 'صورة'
                              ? Icon(imageIcon,
                              color: deepwhite, size: 40.sp)
                              : giftOrders[i].giftType!.name == 'فيديو'
                              ? Icon(vieduoIcon,
                              color: deepwhite, size: 40.sp)
                              : Icon(voiceIcon,
                              color: deepwhite, size: 40.sp)),
                    ),
                  ],
                ),
              ),
            ),

//details-----------------------------------------

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
                                      context, giftOrders[i].from!, 14, blue,
                                      fontWeight: FontWeight.bold),
                                  Spacer(),
                                  const Icon(
                                    Icons.face_retouching_natural,
                                    color: pink,
                                  ),
                                  SizedBox(width: 10.w,),
                                  text(
                                      context, giftOrders[i].to!, 14, pink,
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
                                  text(context, giftOrders[i].status!.name!, 12, green,
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
                            padding: EdgeInsets.only(top: 3.0.h),
                            child: text(
                                context,
                                giftOrders[i].date!,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
/*
*
*
* */
