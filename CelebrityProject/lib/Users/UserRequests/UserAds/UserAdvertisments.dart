import 'dart:ui';

import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Account/LoggingSingUpAPI.dart';
import 'UserAdsOrdersApi.dart';
import 'UserAdvDetials.dart';

class UserAdvertisment extends StatefulWidget {
  const UserAdvertisment({Key? key}) : super(key: key);

  @override
  State<UserAdvertisment> createState() => _UserAdvertismentState();
}

class _UserAdvertismentState extends State<UserAdvertisment> with AutomaticKeepAliveClientMixin {
  String token = '';
  Future<UserAdvertising>? userAdvertisingRequests;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
        // token = value;
        token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxLr_AQhAzfEcqgasRrr32031veKVCd21rA';
        userAdvertisingRequests = getUserAdvertisingOrder(token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          
            future: userAdvertisingRequests,
            builder: ((context, AsyncSnapshot<UserAdvertising> snapshot) {
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
                  return snapshot.data!.data!.advertisingOrders!.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              snapshot.data!.data!.advertisingOrders!.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                                onTap: () {
                                  // goTopagepush(
                                  //     context,
                                  //     UserAdvDetials(
                                  //       i: i,
                                  //       image: snapshot.data!.data!
                                  //           .advertisingOrders![i].file,
                                  //       advTitle: snapshot
                                  //           .data!
                                  //           .data!
                                  //           .advertisingOrders![i]
                                  //           .advertisingAdType
                                  //           ?.name,
                                  //       description: snapshot.data!.data!
                                  //           .advertisingOrders![i].description,
                                  //       price: snapshot.data!.data!
                                  //           .advertisingOrders![i].price,
                                  //     ));
                                },
                                child: Column(
                                  children: [
                                    body(i,
                                        snapshot.data!.data!.advertisingOrders),
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

  Widget body(int i, List<AdvertisingOrders>? advertisingOrders) {
    return container(
        200,
        double.infinity,
        18,
        18,
        Colors.white,
        Column(
          children: [
//image------------------------------------------------------------------------------------

            Expanded(
              flex: 2,
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.h),
                      topRight: Radius.circular(10.h),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                          advertisingOrders![i].file!,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.black45, BlendMode.darken)),
                  ),
//status-----------------------------------------------------------------------------------

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: text(
                                  context,
                                  advertisingOrders[i].status!.name!,
                                  18,
                                  white,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
// celebrity name---------------------------------------------------------------------------------

                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 10.r),
                                  child: text(
                                    context,
                                    advertisingOrders[i].celebrity!.name!,
                                    18,
                                    white,
                                    fontWeight: FontWeight.bold,
                                  ))),
//date and icon---------------------------------------------------------------------------------
                          const Spacer(),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: text(
                                context,
                                advertisingOrders[i].date!,
                                18,
                                white,
                                fontWeight: FontWeight.bold,
                              )),

                          SizedBox(width: 10.w),
                        ],
                      )
                    ],
                  )),
            ),

//details-----------------------------------------

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
                                child: text(
                                    context,
                                    advertisingOrders[i]
                                        .advertisingAdType!
                                        .name!,
                                    12,
                                    pink,
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
                                  "المنصة",
                                  12,
                                  black,
                                )),
                            Expanded(
                                flex: 1,
                                child: text(
                                    context,
                                    '${advertisingOrders[i].platform?.name!}',
                                    12,
                                    pink,
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
                                child: text(
                                    context,
                                    advertisingOrders[i].adTiming!.name!,
                                    12,
                                    pink,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
