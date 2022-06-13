import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Account/LoggingSingUpAPI.dart';
import 'GiftApi.dart';
import 'GiftDetials.dart';

class Gift extends StatefulWidget {
  const Gift({Key? key}) : super(key: key);

  @override
  State<Gift> createState() => _GiftState();
}

class _GiftState extends State<Gift> with AutomaticKeepAliveClientMixin {
  String token = '';
  Future<Gifting>? celebrityGiftRequests;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
        token = value;
        celebrityGiftRequests = getGiftingOrder(token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: celebrityGiftRequests,
            builder: ((context, AsyncSnapshot<Gifting> snapshot) {
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
                                  goTopagepush(
                                      context,
                                      GiftDetials(
                                        i: i,
                                        price: snapshot
                                            .data!.data!.giftOrders![i].price,
                                        description: snapshot.data!.data!
                                            .giftOrders![i].description,
                                        advTitle: snapshot.data!.data!
                                            .giftOrders![i].occasion?.name,
                                        advType: snapshot.data!.data!
                                            .giftOrders![i].giftType?.name,
                                        orderId: snapshot
                                            .data!.data!.giftOrders![i].id,
                                        token: token,
                                        state: snapshot.data!.data!
                                            .giftOrders![i].status?.id,
                                        rejectResonName: snapshot.data!.data!
                                            .giftOrders![i].rejectReson?.name!,
                                        rejectResonId: snapshot.data!.data!
                                            .giftOrders![i].rejectReson?.id,
                                      ));
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

  Widget getGiftOrder(int i, List<GiftOrders>? giftOrders) {
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
                        image: NetworkImage(giftOrders![i].occasion!.image!),
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
                                  giftOrders[i].status!.name!,
                                  18,
                                  white,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
// occasion name---------------------------------------------------------------------------------

                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: text(
                                    context,
                                    "اهداء ل" + giftOrders[i].occasion!.name!,
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
                                giftOrders[i].date!,
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

//details-------------------------------------------------------------------------------

            Expanded(
                flex: 1,
                child: Row(
                  children: [
//giftOrders from-----------------------------------------------------------------------------------
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: text(
                                  context,
                                  "اهداء من",
                                  12,
                                  black,
                                )),
                            Expanded(
                                flex: 1,
                                child: text(
                                    context, giftOrders[i].from!, 12, pink,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    divider(),
//giftOrders to-------------------------------------------------

                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: text(
                                  context,
                                  "اهداء الى",
                                  12,
                                  black,
                                )),
                            Expanded(
                                flex: 1,
                                child: text(
                                    context, giftOrders[i].to!, 12, pink,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    divider(),
//giftType-------------------------------------------------

                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1,
                                child: text(
                                  context,
                                  "نوع الاهداء",
                                  12,
                                  black,
                                )),
                            Expanded(
                                flex: 1,
                                child: text(context,
                                    giftOrders[i].giftType!.name!, 12, pink,
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
/*
*
*
* */
