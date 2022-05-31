import 'dart:ui';

import 'package:celepraty/Account/LoggingSingUpAPI.dart';
import 'package:celepraty/Celebrity/Requests/Ads/AdvertisinApi.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AdvDetials.dart';

class Advertisment extends StatefulWidget {
  @override
  State<Advertisment> createState() => _AdvertismentState();
}

class _AdvertismentState extends State<Advertisment> with AutomaticKeepAliveClientMixin {
  String token = '';
  Future<Advertising>? celebrityAdvertisingRequests;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
        token = value;
        celebrityAdvertisingRequests = getAdvertisingOrder(token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: celebrityAdvertisingRequests,
            builder: ((context, AsyncSnapshot<Advertising> snapshot) {
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
                                  goTopagepush(context, AdvDetials(i: i,
                                  image: snapshot.data!.data!.advertisingOrders![i].file,
                                  advTitle: snapshot.data!.data!.advertisingOrders![i].advertisingAdType?.name,
                                  description: snapshot.data!.data!.advertisingOrders![i].description,
                                  orderId: snapshot.data!.data!.advertisingOrders![i].id, token:token,
                                  platform:snapshot.data!.data!.advertisingOrders![i].platform?.name,
                                  ));
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
                }
                else {
                  return text(
                    context,
                    "لاتوجد طلبات لعرضها حاليا",
                    15,
                    black,
                  );
                }
              }
              else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            })));
  }

  Widget body(int i, List<AdvertisingOrders>? advertisingOrders) {
    return advertisingOrders!.isNotEmpty
        ? container(
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
                              advertisingOrders[i].file!,


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
                            padding:  EdgeInsets.all(8.0.r),
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
// 7odory---------------------------------------------------------------------------------

                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 10.r),
                                      child: text(

                                        context,
                                        advertisingOrders[i].adFeature!.name!,
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

//details-----------------------------------------------------------------------------------------------------

                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
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
//owner-------------------------------------------------------------------------------------------

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
                                    child: text(
                                        context,
                                        advertisingOrders[i].adOwner!.name!,
                                        12,
                                        pink,
                                        fontWeight: FontWeight.bold))
                              ],
                            )),
                        divider(),
//time----------------------------------------------------------------------------------------

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
            marginT: 5)
        : Center(
            child: Container(
              color: Colors.red,
              child: Expanded(
                child: text(
                  context,
                  "لاتوجد طلبات لعرضها حاليا",
                  15,
                  black,
                ),
              ),
            ),
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
