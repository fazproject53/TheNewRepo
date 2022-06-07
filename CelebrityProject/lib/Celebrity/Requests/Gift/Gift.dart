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
                                  goTopagepush(context, GiftDetials(
                                    i: i,
                                    price: snapshot.data!.data!.giftOrders![i].price,
                                    description:snapshot.data!.data!.giftOrders![i].description ,
                                    advTitle:snapshot.data!.data!.giftOrders![i].occasion?.name ,
                                    advType: snapshot.data!.data!.giftOrders![i].giftType?.name ,
                                    orderId: snapshot.data!.data!.giftOrders![i].id,
                                    token:token,
                                    state:snapshot.data!.data!.giftOrders![i].status?.id,
                                    rejectResonName: snapshot.data!.data!.giftOrders![i].rejectReson?.name!,
                                    rejectResonId: snapshot.data!.data!.giftOrders![i].rejectReson?.id,
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

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(8.0.r),
                            child: Align(
                                alignment: Alignment.topLeft,
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
//-------------------------------------------------------------------------------
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

//icon-------------------------------------------------------------
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(8.0.r),
                            child: Align(
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
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
//details----------------------------------------------------------------------------------

            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    //from to------------------------------------------
                    Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            const Expanded(
                                child: Icon(
                              Icons.volunteer_activism,
                              color: blue,
                            )),
                            Expanded(
                              flex: 2,
                              child: text(
                                  context, giftOrders[i].from!, 14, blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Expanded(
                                child: Icon(
                              Icons.face_retouching_natural,
                              color: pink,
                            )),
                            Expanded(
                                flex: 2,
                                child: text(
                                    context, giftOrders[i].to!, 14, pink,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
//date---------------------------------------------------------------------------------
                    Expanded(
                      flex: 1,
                      child: gradientContainer(
                          double.infinity,
                          Center(
                            child: text(
                                context,
                               // "يناير\n23",
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
