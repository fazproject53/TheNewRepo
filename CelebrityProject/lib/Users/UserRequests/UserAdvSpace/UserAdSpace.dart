import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Account/LoggingSingUpAPI.dart';
import 'UserAdsSpaceApi.dart';

class UserAdSpace extends StatefulWidget {
  const UserAdSpace({Key? key}) : super(key: key);

  @override
  State<UserAdSpace> createState() => _UserAdSpaceState();
}

class _UserAdSpaceState extends State<UserAdSpace>
    with AutomaticKeepAliveClientMixin {
  String token = '';
  Future<UserAdvsSpace>? userAdSpaceRequests;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
        token = value;
        userAdSpaceRequests = getUserAdvSpaceOrder(token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: userAdSpaceRequests,
            builder: ((context, AsyncSnapshot<UserAdvsSpace> snapshot) {
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
                                  // goTopagepush(context, adSpaceOrders(i: i));
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

  Widget getData(int i, List<AdSpaceOrders>? adSpaceOrders) {
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
                      image: NetworkImage(adSpaceOrders![i].image!),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.black45, BlendMode.darken)),
                ),
// مناسبه الاهداء-----------------------------------------
              ),
            ),

//details-----------------------------------------

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
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
                                    text(context, adSpaceOrders[i].celebrity!.name!, 16, white)
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
                                    text(context, '${adSpaceOrders[i].id}', 16, white)
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
                                    text(context, adSpaceOrders[i].date!, 16, white),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //Request stats---------------------------------------------------------------
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
//stats--------------------------------------------------------------------------
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.fit_screen,
                                      color: white,
                                      size: 25.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    text(context, adSpaceOrders[i].status!.name!, 16, white)
                                  ],
                                ),

//link--------------------------------------------------------------------------
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0.h),
                                  child: Icon(
                                    Icons.copy,
                                    color: white,
                                    size: 0.h,
                                  ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
