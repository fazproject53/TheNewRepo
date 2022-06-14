import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Account/LoggingSingUpAPI.dart';
import 'AdSpaceApi.dart';
import 'AdSpaceDetails.dart';

class AdSpace extends StatefulWidget {
  @override
  State<AdSpace> createState() => _AdSpaceState();
}

class _AdSpaceState extends State<AdSpace> with AutomaticKeepAliveClientMixin {
  String token = '';
  Future<AdSpaceOrder>? celebrityAdSpaceRequests;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
        token = value;
        celebrityAdSpaceRequests = getAdSpaceOrder(token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: celebrityAdSpaceRequests,
            builder: ((context, AsyncSnapshot<AdSpaceOrder> snapshot) {
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
                  return snapshot.data!.data!.adSpaceOrders!.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.data!.adSpaceOrders!.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                                onTap: () {

                                    goTopagepush(context, AdSpaceDetails(
                                      i: i,
                                      image:snapshot.data!.data!.adSpaceOrders![i].image,
                                      link:snapshot.data!.data!.adSpaceOrders![i].link,
                                      price: snapshot.data!.data!.adSpaceOrders![i].price,
                                      orderId: snapshot.data!.data!.adSpaceOrders![i].id,
                                      token:token,
                                      state:snapshot.data!.data!.adSpaceOrders![i].status?.id,
                                      rejectResonName: snapshot.data!.data!.adSpaceOrders![i].rejectReson?.name!,
                                      rejectResonId: snapshot.data!.data!.adSpaceOrders![i].rejectReson?.id,
                                    ));
                                  },
                                child: Column(
                                  children: [
                                    getData(
                                        i, snapshot.data!.data!.adSpaceOrders),
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

//----------------------------------------------------------------------------------------
  Widget getData(int i, List<AdSpaceOrders>? adSpaceOrders) {
    return container(
        160,
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
                        image: NetworkImage(adSpaceOrders![i].image!),
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
                                  adSpaceOrders[i].status!.name!,
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
                                    'اعلان من ' +
                                        adSpaceOrders[i].user!.name!,
                                    18,
                                    white,
                                    fontWeight: FontWeight.bold,
                                  ))),
//date and icon---------------------------------------------------------------------------------
                          const Spacer(),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16.w,bottom: 10.h),
                                child: text(
                                  context,
                                  adSpaceOrders[i].date!,
                                  18,
                                  white,
                                  fontWeight: FontWeight.bold,
                                ),
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
