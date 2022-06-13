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
        token = value;
        userAdvertisingRequests = getUserAdvertisingOrder(token);
      });
    });
    //print(getUserAdvertisingOrder(token));
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
                                  goTopagepush(context, UserAdvDetials(i: i,
                                    image: snapshot.data!.data!.advertisingOrders![i].file,
                                    advTitle: snapshot.data!.data!.advertisingOrders![i].advertisingAdType?.name,
                                    description: snapshot.data!.data!.advertisingOrders![i].description,
                                    orderId: snapshot.data!.data!.advertisingOrders![i].id,
                                    celebrityName:snapshot.data!.data!.advertisingOrders![i].celebrity?.name!,
                                    celebrityId:snapshot.data!.data!.advertisingOrders![i].celebrity?.id!,
                                    celebrityImage:snapshot.data!.data!.advertisingOrders![i].celebrity?.image!,
                                    celebrityPagUrl:snapshot.data!.data!.advertisingOrders![i].celebrity?.pageUrl!,
                                    platform:snapshot.data!.data!.advertisingOrders![i].platform?.name,
                                    state:snapshot.data!.data!.advertisingOrders![i].status?.id,
                                    price:snapshot.data!.data!.advertisingOrders![i].price,
                                    rejectResonName: snapshot.data!.data!.advertisingOrders![i].rejectReson?.name!,
                                    rejectResonId: snapshot.data!.data!.advertisingOrders![i].rejectReson?.id,
                                    token:token,
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
        160,
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
                      bottomRight: Radius.circular(10.h),
                      bottomLeft: Radius.circular(10.h),
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
                                  advertisingOrders[i].status?.id==4?'تم القبول الرجاء اكمال الطلب':advertisingOrders[i].status!.name!,
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
                                  padding: EdgeInsets.only(right: 16.w,bottom: 10.h),
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
